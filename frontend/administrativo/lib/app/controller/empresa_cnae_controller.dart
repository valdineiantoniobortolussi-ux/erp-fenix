import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/routes/app_routes.dart';

import 'package:administrativo/app/page/page_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

class EmpresaCnaeController extends ControllerBase<EmpresaCnaeModel, void> {

  EmpresaCnaeController() : super(repository: null) {
    dbColumns = EmpresaCnaeModel.dbColumns;
    aliasColumns = EmpresaCnaeModel.aliasColumns;
    gridColumns = empresaCnaeGridColumns();
    functionName = "empresa_cnae";
    screenTitle = "CNAEs";
  }

  final _empresaCnaeModel = EmpresaCnaeModel().obs;
  EmpresaCnaeModel get empresaCnaeModel => _empresaCnaeModel.value;
  set empresaCnaeModel(value) => _empresaCnaeModel.value = value ?? EmpresaCnaeModel();

  List<EmpresaCnaeModel> get empresaCnaeModelList => Get.find<EmpresaController>().currentModel.empresaCnaeModelList ?? [];

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

  final empresaCnaeScaffoldKey = GlobalKey<ScaffoldState>();
  final empresaCnaeFormKey = GlobalKey<FormState>();

  @override
  EmpresaCnaeModel createNewModel() => EmpresaCnaeModel();

  @override
  final standardFieldForFilter = EmpresaCnaeModel.aliasColumns[EmpresaCnaeModel.dbColumns.indexOf('principal')];

  final cnaeModelController = TextEditingController();
  final ramoAtividadeController = TextEditingController();
  final objetoSocialController = TextEditingController();

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['principal'],
    'secondaryColumns': ['ramo_atividade'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((empresaCnae) => empresaCnae.toJson).toList();
  }

  @override
  List<PlutoRow> plutoRows() => List<PlutoRow>.from(empresaCnaeModelList.map((model) => model.toPlutoRow()));

  @override
  Future<void> getList({Filter? filter}) async {}

  @override
  void prepareForInsert() {
    isNewRecord = true;
    empresaCnaeModel = createNewModel();
    _resetForm();
    Get.to(() => EmpresaCnaeEditPage());
  }

  void _resetForm() {
    formWasChangedDetail = false;
    cnaeModelController.text = '';
    ramoAtividadeController.text = '';
    objetoSocialController.text = '';
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
    final model = empresaCnaeModelList.firstWhere((m) => m.tempId == tempId);
    empresaCnaeModel = model.clone();
		empresaCnaeModel.tempId = model.tempId;
    updateControllersFromModel();
    Get.to(() => EmpresaCnaeEditPage());
  }

  void updateControllersFromModel() {
    cnaeModelController.text = empresaCnaeModel.cnaeModel?.codigo?.toString() ?? '';
    ramoAtividadeController.text = empresaCnaeModel.ramoAtividade ?? '';
    objetoSocialController.text = empresaCnaeModel.objetoSocial ?? '';
    formWasChangedDetail = false;
  }

  @override
  Future<void> save() async {
    if (!empresaCnaeFormKey.currentState!.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
      return;
    }

    if (formWasChangedDetail) {
      if (isNewRecord) {
        empresaCnaeModelList.insert(0, empresaCnaeModel.clone());
      } else {
        final index = empresaCnaeModelList.indexWhere((m) => m.tempId == empresaCnaeModel.tempId);
        if (index >= 0) {
          empresaCnaeModelList[index] = empresaCnaeModel.clone();
        }
      }

      userMadeChanges = true;
      loadData();
      Get.back(result: true);
    } else {
      Get.back();
    }
  }

  Future callCnaeLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [CNAE]'; 
		lookupController.route = '/cnae/'; 
		lookupController.gridColumns = cnaeGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CnaeModel.aliasColumns; 
		lookupController.dbColumns = CnaeModel.dbColumns; 
		lookupController.standardColumn = CnaeModel.aliasColumns[CnaeModel.dbColumns.indexOf('codigo')]; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			empresaCnaeModel.idCnae = plutoRowResult.cells['id']!.value; 
			empresaCnaeModel.cnaeModel = CnaeModel.fromPlutoRow(plutoRowResult); 
			cnaeModelController.text = empresaCnaeModel.cnaeModel?.codigo ?? ''; 
			formWasChanged = true; 
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
      empresaCnaeModelList.removeWhere((model) => (id != 0 && model.id == id) || (id == 0 && model.tempId == tempId));
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
    cnaeModelController.dispose();
    ramoAtividadeController.dispose();
    objetoSocialController.dispose();
  }

}