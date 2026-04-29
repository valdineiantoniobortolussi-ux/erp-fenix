import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:administrativo/app/page/page_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class EmpresaEnderecoController extends ControllerBase<EmpresaEnderecoModel, void> {

  EmpresaEnderecoController() : super(repository: null) {
    dbColumns = EmpresaEnderecoModel.dbColumns;
    aliasColumns = EmpresaEnderecoModel.aliasColumns;
    gridColumns = empresaEnderecoGridColumns();
    functionName = "empresa_endereco";
    screenTitle = "Endereços";
  }

  final _empresaEnderecoModel = EmpresaEnderecoModel().obs;
  EmpresaEnderecoModel get empresaEnderecoModel => _empresaEnderecoModel.value;
  set empresaEnderecoModel(value) => _empresaEnderecoModel.value = value ?? EmpresaEnderecoModel();

  List<EmpresaEnderecoModel> get empresaEnderecoModelList => Get.find<EmpresaController>().currentModel.empresaEnderecoModelList ?? [];

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

  final empresaEnderecoScaffoldKey = GlobalKey<ScaffoldState>();
  final empresaEnderecoFormKey = GlobalKey<FormState>();

  @override
  EmpresaEnderecoModel createNewModel() => EmpresaEnderecoModel();

  @override
  final standardFieldForFilter = EmpresaEnderecoModel.aliasColumns[EmpresaEnderecoModel.dbColumns.indexOf('logradouro')];

  final logradouroController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final cepController = MaskedTextController(mask: '00000-000',);
  final municipioIbgeController = MoneyMaskedTextController(precision: 0, decimalSeparator: '', thousandSeparator: '');
  final complementoController = TextEditingController();

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['logradouro'],
    'secondaryColumns': ['numero'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((empresaEndereco) => empresaEndereco.toJson).toList();
  }

  @override
  List<PlutoRow> plutoRows() => List<PlutoRow>.from(empresaEnderecoModelList.map((model) => model.toPlutoRow()));

  @override
  Future<void> getList({Filter? filter}) async {}

  @override
  void prepareForInsert() {
    isNewRecord = true;
    empresaEnderecoModel = createNewModel();
    _resetForm();
    Get.to(() => EmpresaEnderecoEditPage());
  }

  void _resetForm() {
    formWasChangedDetail = false;
    logradouroController.text = '';
    numeroController.text = '';
    bairroController.text = '';
    cidadeController.text = '';
    cepController.text = '';
    municipioIbgeController.updateValue(0);
    complementoController.text = '';
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
    final model = empresaEnderecoModelList.firstWhere((m) => m.tempId == tempId);
    empresaEnderecoModel = model.clone();
		empresaEnderecoModel.tempId = model.tempId;
    updateControllersFromModel();
    Get.to(() => EmpresaEnderecoEditPage());
  }

  void updateControllersFromModel() {
    logradouroController.text = empresaEnderecoModel.logradouro ?? '';
    numeroController.text = empresaEnderecoModel.numero ?? '';
    bairroController.text = empresaEnderecoModel.bairro ?? '';
    cidadeController.text = empresaEnderecoModel.cidade ?? '';
    cepController.text = empresaEnderecoModel.cep ?? '';
    municipioIbgeController.updateValue((empresaEnderecoModel.municipioIbge ?? 0).toDouble());
    complementoController.text = empresaEnderecoModel.complemento ?? '';
    formWasChangedDetail = false;
  }

  @override
  Future<void> save() async {
    if (!empresaEnderecoFormKey.currentState!.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
      return;
    }

    if (formWasChangedDetail) {
      if (isNewRecord) {
        empresaEnderecoModelList.insert(0, empresaEnderecoModel.clone());
      } else {
        final index = empresaEnderecoModelList.indexWhere((m) => m.tempId == empresaEnderecoModel.tempId);
        if (index >= 0) {
          empresaEnderecoModelList[index] = empresaEnderecoModel.clone();
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
      empresaEnderecoModelList.removeWhere((model) => (id != 0 && model.id == id) || (id == 0 && model.tempId == tempId));
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
    logradouroController.dispose();
    numeroController.dispose();
    bairroController.dispose();
    cidadeController.dispose();
    cepController.dispose();
    municipioIbgeController.dispose();
    complementoController.dispose();
  }

}