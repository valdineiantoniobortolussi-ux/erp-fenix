import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';

import 'package:folha/app/routes/app_routes.dart';
import 'package:folha/app/data/repository/folha_tipo_afastamento_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class FolhaTipoAfastamentoController extends GetxController with ControllerBaseMixin {
  final FolhaTipoAfastamentoRepository folhaTipoAfastamentoRepository;
  FolhaTipoAfastamentoController({required this.folhaTipoAfastamentoRepository});

  // general
  final _dbColumns = FolhaTipoAfastamentoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FolhaTipoAfastamentoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = folhaTipoAfastamentoGridColumns();
  
  var _folhaTipoAfastamentoModelList = <FolhaTipoAfastamentoModel>[];

  final _folhaTipoAfastamentoModel = FolhaTipoAfastamentoModel().obs;
  FolhaTipoAfastamentoModel get folhaTipoAfastamentoModel => _folhaTipoAfastamentoModel.value;
  set folhaTipoAfastamentoModel(value) => _folhaTipoAfastamentoModel.value = value ?? FolhaTipoAfastamentoModel();

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
    for (var folhaTipoAfastamentoModel in _folhaTipoAfastamentoModelList) {
      plutoRowList.add(_getPlutoRow(folhaTipoAfastamentoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FolhaTipoAfastamentoModel folhaTipoAfastamentoModel) {
    return PlutoRow(
      cells: _getPlutoCells(folhaTipoAfastamentoModel: folhaTipoAfastamentoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FolhaTipoAfastamentoModel? folhaTipoAfastamentoModel}) {
    return {
			"id": PlutoCell(value: folhaTipoAfastamentoModel?.id ?? 0),
			"codigo": PlutoCell(value: folhaTipoAfastamentoModel?.codigo ?? ''),
			"nome": PlutoCell(value: folhaTipoAfastamentoModel?.nome ?? ''),
			"codigoEsocial": PlutoCell(value: folhaTipoAfastamentoModel?.codigoEsocial ?? ''),
			"descricao": PlutoCell(value: folhaTipoAfastamentoModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _folhaTipoAfastamentoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      folhaTipoAfastamentoModel.plutoRowToObject(plutoRow);
    } else {
      folhaTipoAfastamentoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Tipo de Afastamento]';
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
    await Get.find<FolhaTipoAfastamentoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await folhaTipoAfastamentoRepository.getList(filter: filter).then( (data){ _folhaTipoAfastamentoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Tipo de Afastamento',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			codigoEsocialController.text = currentRow.cells['codigoEsocial']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.folhaTipoAfastamentoEditPage)!.then((value) {
        if (folhaTipoAfastamentoModel.id == 0) {
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
    folhaTipoAfastamentoModel = FolhaTipoAfastamentoModel();
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
        if (await folhaTipoAfastamentoRepository.delete(id: currentRow.cells['id']!.value)) {
          _folhaTipoAfastamentoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoController = TextEditingController();
	final nomeController = TextEditingController();
	final codigoEsocialController = TextEditingController();
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaTipoAfastamentoModel.id;
		plutoRow.cells['codigo']?.value = folhaTipoAfastamentoModel.codigo;
		plutoRow.cells['nome']?.value = folhaTipoAfastamentoModel.nome;
		plutoRow.cells['codigoEsocial']?.value = folhaTipoAfastamentoModel.codigoEsocial;
		plutoRow.cells['descricao']?.value = folhaTipoAfastamentoModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await folhaTipoAfastamentoRepository.save(folhaTipoAfastamentoModel: folhaTipoAfastamentoModel); 
        if (result != null) {
          folhaTipoAfastamentoModel = result;
          if (_isInserting) {
            _folhaTipoAfastamentoModelList.add(result);
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
		functionName = "folha_tipo_afastamento";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
		codigoEsocialController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}