import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';

import 'package:patrimonio/app/routes/app_routes.dart';
import 'package:patrimonio/app/data/repository/seguradora_repository.dart';
import 'package:patrimonio/app/page/shared_page/shared_page_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';
import 'package:patrimonio/app/mixin/controller_base_mixin.dart';

class SeguradoraController extends GetxController with ControllerBaseMixin {
  final SeguradoraRepository seguradoraRepository;
  SeguradoraController({required this.seguradoraRepository});

  // general
  final _dbColumns = SeguradoraModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = SeguradoraModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = seguradoraGridColumns();
  
  var _seguradoraModelList = <SeguradoraModel>[];

  final _seguradoraModel = SeguradoraModel().obs;
  SeguradoraModel get seguradoraModel => _seguradoraModel.value;
  set seguradoraModel(value) => _seguradoraModel.value = value ?? SeguradoraModel();

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
    for (var seguradoraModel in _seguradoraModelList) {
      plutoRowList.add(_getPlutoRow(seguradoraModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(SeguradoraModel seguradoraModel) {
    return PlutoRow(
      cells: _getPlutoCells(seguradoraModel: seguradoraModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ SeguradoraModel? seguradoraModel}) {
    return {
			"id": PlutoCell(value: seguradoraModel?.id ?? 0),
			"nome": PlutoCell(value: seguradoraModel?.nome ?? ''),
			"contato": PlutoCell(value: seguradoraModel?.contato ?? ''),
			"telefone": PlutoCell(value: seguradoraModel?.telefone ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _seguradoraModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      seguradoraModel.plutoRowToObject(plutoRow);
    } else {
      seguradoraModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Seguradora]';
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
    await Get.find<SeguradoraController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await seguradoraRepository.getList(filter: filter).then( (data){ _seguradoraModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Seguradora',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			contatoController.text = currentRow.cells['contato']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.seguradoraEditPage)!.then((value) {
        if (seguradoraModel.id == 0) {
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
    seguradoraModel = SeguradoraModel();
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
        if (await seguradoraRepository.delete(id: currentRow.cells['id']!.value)) {
          _seguradoraModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nomeController = TextEditingController();
	final contatoController = TextEditingController();
	final telefoneController = MaskedTextController(mask: '(00)00000-0000',);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = seguradoraModel.id;
		plutoRow.cells['nome']?.value = seguradoraModel.nome;
		plutoRow.cells['contato']?.value = seguradoraModel.contato;
		plutoRow.cells['telefone']?.value = seguradoraModel.telefone;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await seguradoraRepository.save(seguradoraModel: seguradoraModel); 
        if (result != null) {
          seguradoraModel = result;
          if (_isInserting) {
            _seguradoraModelList.add(result);
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
		functionName = "seguradora";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		contatoController.dispose();
		telefoneController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}