import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:administrativo/app/page/page_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class EmpresaContatoController extends ControllerBase<EmpresaContatoModel, void> {

  EmpresaContatoController() : super(repository: null) {
    dbColumns = EmpresaContatoModel.dbColumns;
    aliasColumns = EmpresaContatoModel.aliasColumns;
    gridColumns = empresaContatoGridColumns();
    functionName = "empresa_contato";
    screenTitle = "Contatos";
  }

  final _empresaContatoModel = EmpresaContatoModel().obs;
  EmpresaContatoModel get empresaContatoModel => _empresaContatoModel.value;
  set empresaContatoModel(value) => _empresaContatoModel.value = value ?? EmpresaContatoModel();

  List<EmpresaContatoModel> get empresaContatoModelList => Get.find<EmpresaController>().currentModel.empresaContatoModelList ?? [];

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

  final empresaContatoScaffoldKey = GlobalKey<ScaffoldState>();
  final empresaContatoFormKey = GlobalKey<FormState>();

  @override
  EmpresaContatoModel createNewModel() => EmpresaContatoModel();

  @override
  final standardFieldForFilter = EmpresaContatoModel.aliasColumns[EmpresaContatoModel.dbColumns.indexOf('nome')];

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final observacaoController = TextEditingController();

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['nome'],
    'secondaryColumns': ['email'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((empresaContato) => empresaContato.toJson).toList();
  }

  @override
  List<PlutoRow> plutoRows() => List<PlutoRow>.from(empresaContatoModelList.map((model) => model.toPlutoRow()));

  @override
  Future<void> getList({Filter? filter}) async {}

  @override
  void prepareForInsert() {
    isNewRecord = true;
    empresaContatoModel = createNewModel();
    _resetForm();
    Get.to(() => EmpresaContatoEditPage());
  }

  void _resetForm() {
    formWasChangedDetail = false;
    nomeController.text = '';
    emailController.text = '';
    observacaoController.text = '';
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
    final model = empresaContatoModelList.firstWhere((m) => m.tempId == tempId);
    empresaContatoModel = model.clone();
		empresaContatoModel.tempId = model.tempId;
    updateControllersFromModel();
    Get.to(() => EmpresaContatoEditPage());
  }

  void updateControllersFromModel() {
    nomeController.text = empresaContatoModel.nome ?? '';
    emailController.text = empresaContatoModel.email ?? '';
    observacaoController.text = empresaContatoModel.observacao ?? '';
    formWasChangedDetail = false;
  }

  @override
  Future<void> save() async {
    if (!empresaContatoFormKey.currentState!.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
      return;
    }

    if (formWasChangedDetail) {
      if (isNewRecord) {
        empresaContatoModelList.insert(0, empresaContatoModel.clone());
      } else {
        final index = empresaContatoModelList.indexWhere((m) => m.tempId == empresaContatoModel.tempId);
        if (index >= 0) {
          empresaContatoModelList[index] = empresaContatoModel.clone();
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
      empresaContatoModelList.removeWhere((model) => (id != 0 && model.id == id) || (id == 0 && model.tempId == tempId));
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
    nomeController.dispose();
    emailController.dispose();
    observacaoController.dispose();
  }

}