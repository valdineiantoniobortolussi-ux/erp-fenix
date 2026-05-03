import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/registro_cartorio_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class RegistroCartorioController extends GetxController with ControllerBaseMixin {
  final RegistroCartorioRepository registroCartorioRepository;
  RegistroCartorioController({required this.registroCartorioRepository});

  // general
  final _dbColumns = RegistroCartorioModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = RegistroCartorioModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = registroCartorioGridColumns();
  
  var _registroCartorioModelList = <RegistroCartorioModel>[];

  final _registroCartorioModel = RegistroCartorioModel().obs;
  RegistroCartorioModel get registroCartorioModel => _registroCartorioModel.value;
  set registroCartorioModel(value) => _registroCartorioModel.value = value ?? RegistroCartorioModel();

  final _filter = Filter().obs;
  Filter get filter => _filter.value;
  set filter(value) => _filter.value = value ?? Filter(); 

  var _isInserting = false;

  // list page
  late StreamSubscription _keyboardListener;
  get keyboardListener => _keyboardListener;
  set keyboardListener(value) => _keyboardListener = value;

  late PlutoGridStateManager _plutoGridStateManager;
  get plutoGridStateManager => _plutoGridStateManager;
  set plutoGridStateManager(value) => _plutoGridStateManager = value;

  final _plutoRow = PlutoRow(cells: {}).obs;
  get plutoRow => _plutoRow.value;
  set plutoRow(value) => _plutoRow.value = value;

  List<PlutoRow> plutoRows() {
    List<PlutoRow> plutoRowList = <PlutoRow>[];
    for (var registroCartorioModel in _registroCartorioModelList) {
      plutoRowList.add(_getPlutoRow(registroCartorioModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(RegistroCartorioModel registroCartorioModel) {
    return PlutoRow(
      cells: _getPlutoCells(registroCartorioModel: registroCartorioModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ RegistroCartorioModel? registroCartorioModel}) {
    return {
			"id": PlutoCell(value: registroCartorioModel?.id ?? 0),
			"nomeCartorio": PlutoCell(value: registroCartorioModel?.nomeCartorio ?? ''),
			"dataRegistro": PlutoCell(value: registroCartorioModel?.dataRegistro ?? ''),
			"numero": PlutoCell(value: registroCartorioModel?.numero ?? 0),
			"folha": PlutoCell(value: registroCartorioModel?.folha ?? 0),
			"livro": PlutoCell(value: registroCartorioModel?.livro ?? 0),
			"nire": PlutoCell(value: registroCartorioModel?.nire ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _registroCartorioModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      registroCartorioModel.plutoRowToObject(plutoRow);
    } else {
      registroCartorioModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Registro em Cartório]';
    filterController.standardFilter = true;
    filterController.aliasColumns = aliasColumns;
    filterController.dbColumns = dbColumns;
    filterController.filter.field = 'Id';

    filter = await Get.toNamed(Routes.filterPage);
    await loadData();
  }

  Future loadData() async {
    _plutoGridStateManager.setShowLoading(true);
    _plutoGridStateManager.removeAllRows();
    await Get.find<RegistroCartorioController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await registroCartorioRepository.getList(filter: filter).then( (data){ _registroCartorioModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Registro em Cartório',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeCartorioController.text = currentRow.cells['nomeCartorio']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			folhaController.text = currentRow.cells['folha']?.value?.toString() ?? '';
			livroController.text = currentRow.cells['livro']?.value?.toString() ?? '';
			nireController.text = currentRow.cells['nire']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.registroCartorioEditPage)!.then((value) {
        if (registroCartorioModel.id == 0) {
          _plutoGridStateManager.removeCurrentRow();
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
    }
  }

  void callEditPageToInsert() {
    _plutoGridStateManager.prependNewRows(); 
    final cell = _plutoGridStateManager.rows.first.cells.entries.elementAt(0).value;
    _plutoGridStateManager.setCurrentCell(cell, 0); 
    _isInserting = true;
    registroCartorioModel = RegistroCartorioModel();
    callEditPage();   
  }

  void handleKeyboard(PlutoKeyManagerEvent event) {
    if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
      if (canUpdate) {
        callEditPage();
      } else {
        noPrivilegeMessage();
      }
    }
  }  

  Future delete() async {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
      showDeleteDialog(() async {
        if (await registroCartorioRepository.delete(id: currentRow.cells['id']!.value)) {
          _registroCartorioModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
          _plutoGridStateManager.removeCurrentRow();
        } else {
          showErrorSnackBar(message: 'message_error_delete'.tr);
        }
      });
    } else {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
    }
  }


  // edit page
  final scrollController = ScrollController();
	final nomeCartorioController = TextEditingController();
	final numeroController = TextEditingController();
	final folhaController = TextEditingController();
	final livroController = TextEditingController();
	final nireController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = registroCartorioModel.id;
		plutoRow.cells['nomeCartorio']?.value = registroCartorioModel.nomeCartorio;
		plutoRow.cells['dataRegistro']?.value = Util.formatDate(registroCartorioModel.dataRegistro);
		plutoRow.cells['numero']?.value = registroCartorioModel.numero;
		plutoRow.cells['folha']?.value = registroCartorioModel.folha;
		plutoRow.cells['livro']?.value = registroCartorioModel.livro;
		plutoRow.cells['nire']?.value = registroCartorioModel.nire;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await registroCartorioRepository.save(registroCartorioModel: registroCartorioModel); 
        if (result != null) {
          registroCartorioModel = result;
          if (_isInserting) {
            _registroCartorioModelList.add(result);
            _isInserting = false;
          }
          objectToPlutoRow();
          Get.back();
        }
      } else {
        Get.back();
      }
    }
  }

  void preventDataLoss() {
    if (formWasChanged) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      Get.back();
    }
  }  


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "registro_cartorio";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeCartorioController.dispose();
		numeroController.dispose();
		folhaController.dispose();
		livroController.dispose();
		nireController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}