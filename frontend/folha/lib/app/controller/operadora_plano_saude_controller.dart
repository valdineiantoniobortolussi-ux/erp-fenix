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
import 'package:folha/app/data/repository/operadora_plano_saude_repository.dart';
import 'package:folha/app/page/shared_page/shared_page_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';
import 'package:folha/app/mixin/controller_base_mixin.dart';

class OperadoraPlanoSaudeController extends GetxController with ControllerBaseMixin {
  final OperadoraPlanoSaudeRepository operadoraPlanoSaudeRepository;
  OperadoraPlanoSaudeController({required this.operadoraPlanoSaudeRepository});

  // general
  final _dbColumns = OperadoraPlanoSaudeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = OperadoraPlanoSaudeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = operadoraPlanoSaudeGridColumns();
  
  var _operadoraPlanoSaudeModelList = <OperadoraPlanoSaudeModel>[];

  final _operadoraPlanoSaudeModel = OperadoraPlanoSaudeModel().obs;
  OperadoraPlanoSaudeModel get operadoraPlanoSaudeModel => _operadoraPlanoSaudeModel.value;
  set operadoraPlanoSaudeModel(value) => _operadoraPlanoSaudeModel.value = value ?? OperadoraPlanoSaudeModel();

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
    for (var operadoraPlanoSaudeModel in _operadoraPlanoSaudeModelList) {
      plutoRowList.add(_getPlutoRow(operadoraPlanoSaudeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(OperadoraPlanoSaudeModel operadoraPlanoSaudeModel) {
    return PlutoRow(
      cells: _getPlutoCells(operadoraPlanoSaudeModel: operadoraPlanoSaudeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ OperadoraPlanoSaudeModel? operadoraPlanoSaudeModel}) {
    return {
			"id": PlutoCell(value: operadoraPlanoSaudeModel?.id ?? 0),
			"nome": PlutoCell(value: operadoraPlanoSaudeModel?.nome ?? ''),
			"registroAns": PlutoCell(value: operadoraPlanoSaudeModel?.registroAns ?? ''),
			"classificacaoContabilConta": PlutoCell(value: operadoraPlanoSaudeModel?.classificacaoContabilConta ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _operadoraPlanoSaudeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      operadoraPlanoSaudeModel.plutoRowToObject(plutoRow);
    } else {
      operadoraPlanoSaudeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Operadora Plano de Saúde]';
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
    await Get.find<OperadoraPlanoSaudeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await operadoraPlanoSaudeRepository.getList(filter: filter).then( (data){ _operadoraPlanoSaudeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Operadora Plano de Saúde',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			registroAnsController.text = currentRow.cells['registroAns']?.value ?? '';
			classificacaoContabilContaController.text = currentRow.cells['classificacaoContabilConta']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.operadoraPlanoSaudeEditPage)!.then((value) {
        if (operadoraPlanoSaudeModel.id == 0) {
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
    operadoraPlanoSaudeModel = OperadoraPlanoSaudeModel();
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
        if (await operadoraPlanoSaudeRepository.delete(id: currentRow.cells['id']!.value)) {
          _operadoraPlanoSaudeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final registroAnsController = TextEditingController();
	final classificacaoContabilContaController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = operadoraPlanoSaudeModel.id;
		plutoRow.cells['nome']?.value = operadoraPlanoSaudeModel.nome;
		plutoRow.cells['registroAns']?.value = operadoraPlanoSaudeModel.registroAns;
		plutoRow.cells['classificacaoContabilConta']?.value = operadoraPlanoSaudeModel.classificacaoContabilConta;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await operadoraPlanoSaudeRepository.save(operadoraPlanoSaudeModel: operadoraPlanoSaudeModel); 
        if (result != null) {
          operadoraPlanoSaudeModel = result;
          if (_isInserting) {
            _operadoraPlanoSaudeModelList.add(result);
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
		functionName = "operadora_plano_saude";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		registroAnsController.dispose();
		classificacaoContabilContaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}