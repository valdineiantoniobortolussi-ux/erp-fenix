import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:administrativo/app/page/page_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class EmpresaTelefoneController extends ControllerBase<EmpresaTelefoneModel, void> {

  EmpresaTelefoneController() : super(repository: null) {
    dbColumns = EmpresaTelefoneModel.dbColumns;
    aliasColumns = EmpresaTelefoneModel.aliasColumns;
    gridColumns = empresaTelefoneGridColumns();
    functionName = "empresa_telefone";
    screenTitle = "Telefones";
  }

  final _empresaTelefoneModel = EmpresaTelefoneModel().obs;
  EmpresaTelefoneModel get empresaTelefoneModel => _empresaTelefoneModel.value;
  set empresaTelefoneModel(value) => _empresaTelefoneModel.value = value ?? EmpresaTelefoneModel();

  List<EmpresaTelefoneModel> get empresaTelefoneModelList => Get.find<EmpresaController>().currentModel.empresaTelefoneModelList ?? [];

  final _userMadeChanges = false.obs;
  get userMadeChanges => _userMadeChanges.value;
  set userMadeChanges(value) => _userMadeChanges.value = value;

  final _formWasChangedDetail = false.obs;
  bool get formWasChangedDetail => _formWasChangedDetail.value;
  set formWasChangedDetail(value) => _formWasChangedDetail.value = value;

  late PlutoGridStateManager _plutoGridStateManager;
  @override
  PlutoGridStateManager get plutoGridStateManager => _plutoGridStateManager;
  @override
  set plutoGridStateManager(value) => _plutoGridStateManager = value;

  final empresaTelefoneScaffoldKey = GlobalKey<ScaffoldState>();
  final empresaTelefoneFormKey = GlobalKey<FormState>();

  @override
  EmpresaTelefoneModel createNewModel() => EmpresaTelefoneModel();

  @override
  final standardFieldForFilter = EmpresaTelefoneModel.aliasColumns[EmpresaTelefoneModel.dbColumns.indexOf('tipo')];

  final numeroController = MaskedTextController(mask: '(00)00000-0000',);

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['tipo'],
    'secondaryColumns': ['numero'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((empresaTelefone) => empresaTelefone.toJson).toList();
  }

  @override
  List<PlutoRow> plutoRows() => List<PlutoRow>.from(empresaTelefoneModelList.map((model) => model.toPlutoRow()));

  @override
  Future<void> getList({Filter? filter}) async {}

  @override
  void prepareForInsert() {
    isNewRecord = true;
    empresaTelefoneModel = createNewModel();
    _resetForm();
    Get.to(() => EmpresaTelefoneEditPage());
  }

  void _resetForm() {
    formWasChangedDetail = false;
    numeroController.text = '';
  }

  @override
  void selectRowForEditing(PlutoRow? row) async {
    if (row == null) {
      showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
      return;
    }

    selectRowForEditingByTempId(row.cells['tempId']?.value);
  }

  @override
  void selectRowForEditingById(int id) {}

  void selectRowForEditingByTempId(String tempId) {
		isNewRecord = false;
    final model = empresaTelefoneModelList.firstWhere((m) => m.tempId == tempId);
    empresaTelefoneModel = model.clone();
		empresaTelefoneModel.tempId = model.tempId;
    updateControllersFromModel();
    Get.to(() => EmpresaTelefoneEditPage());
  }

  void updateControllersFromModel() {
    numeroController.text = empresaTelefoneModel.numero ?? '';
    formWasChangedDetail = false;
  }

  @override
  Future<void> save() async {
    if (!empresaTelefoneFormKey.currentState!.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
      return;
    }

    if (formWasChangedDetail) {
      if (isNewRecord) {
        empresaTelefoneModelList.insert(0, empresaTelefoneModel.clone());
      } else {
        final index = empresaTelefoneModelList.indexWhere((m) => m.tempId == empresaTelefoneModel.tempId);
        if (index >= 0) {
          empresaTelefoneModelList[index] = empresaTelefoneModel.clone();
        }
      }

      userMadeChanges = true;
      loadData();
      Get.back(result: true);
    } else {
      Get.back();
    }
  }


  @override
  Future deleteSelected() async {
    final currentRow = plutoGridStateManager.currentRow;
    if (currentRow == null) {
      showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
      return null;
    }
    showDeleteDialog(() async {
      final id = currentRow.cells['id']?.value;
      final tempId = currentRow.cells['tempId']?.value;
      empresaTelefoneModelList.removeWhere((model) => (id != 0 && model.id == id) || (id == 0 && model.tempId == tempId));
      plutoGridStateManager.removeCurrentRow();
      userMadeChanges = true;
    });
  }

  @override
  void preventDataLoss() {
    if (formWasChangedDetail) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      formWasChangedDetail = false;
      Get.back();
    }
  }

  @override
  void onClose() {
    numeroController.dispose();
  }

}