import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/routes/app_routes.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/repository/usuario_repository.dart';

class UsuarioController extends ControllerBase<UsuarioModel, UsuarioRepository> {

  UsuarioController({required super.repository}) {
    dbColumns = UsuarioModel.dbColumns;
    aliasColumns = UsuarioModel.aliasColumns;
    gridColumns = usuarioGridColumns();
    functionName = "usuario";
    screenTitle = "Usuário";
  }

  @override
  UsuarioModel createNewModel() => UsuarioModel();

  @override
  final standardFieldForFilter = UsuarioModel.aliasColumns[UsuarioModel.dbColumns.indexOf('login')];

  final papelModelController = TextEditingController();
  final viewPessoaColaboradorModelController = TextEditingController();
  final loginController = TextEditingController();
  final senhaController = TextEditingController();

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['login'],
    'secondaryColumns': ['senha'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((usuario) => usuario.toJson).toList();
  }

  @override
  void prepareForInsert() {
    isNewRecord = true;
    currentModel = createNewModel();
    _resetForm();
    Get.toNamed(Routes.usuarioEditPage);
  }

  void _resetForm() {
    formWasChanged = false;
    papelModelController.text = '';
    viewPessoaColaboradorModelController.text = '';
    loginController.text = '';
    senhaController.text = '';
  }

  @override
  void selectRowForEditingById(int id) {
    final model = modelList.firstWhere((m) => m.id == id);
    currentModel = model.clone();
    updateControllersFromModel();
    Get.toNamed(Routes.usuarioEditPage);
  }

  void updateControllersFromModel() {
    papelModelController.text = currentModel.papelModel?.nome?.toString() ?? '';
    viewPessoaColaboradorModelController.text = currentModel.viewPessoaColaboradorModel?.nome?.toString() ?? '';
    loginController.text = currentModel.login ?? '';
    senhaController.text = currentModel.senha ?? '';
    formWasChanged = false;
  }

  @override
  Future<void> save() async {
    if (!formKey.currentState!.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
      return;
    }

    final existingIndex = modelList.indexWhere((m) => m.id == currentModel.id);

    if (existingIndex >= 0) {
      modelList[existingIndex] = currentModel.clone();
    }

    final result = await repository.save(usuarioModel: currentModel);
    if (result == null) return;

    if (existingIndex >= 0) {
      modelList[existingIndex] = result;
    } else {
      modelList.insert(0, result);
    }

    if (!GetPlatform.isMobile) {
      updateGridRow(result);
    }

    Get.back(result: true);
  }

  Future callPapelLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Papel]'; 
		lookupController.route = '/papel/'; 
		lookupController.gridColumns = papelGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PapelModel.aliasColumns; 
		lookupController.dbColumns = PapelModel.dbColumns; 
		lookupController.standardColumn = PapelModel.aliasColumns[PapelModel.dbColumns.indexOf('nome')]; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			currentModel.idPapel = plutoRowResult.cells['id']!.value; 
			currentModel.papelModel = PapelModel.fromPlutoRow(plutoRowResult); 
			papelModelController.text = currentModel.papelModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

  Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 
		lookupController.standardColumn = ViewPessoaColaboradorModel.aliasColumns[ViewPessoaColaboradorModel.dbColumns.indexOf('nome')]; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			currentModel.idColaborador = plutoRowResult.cells['id']!.value; 
			currentModel.viewPessoaColaboradorModel = ViewPessoaColaboradorModel.fromPlutoRow(plutoRowResult); 
			viewPessoaColaboradorModelController.text = currentModel.viewPessoaColaboradorModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  @override
  void onClose() {
    papelModelController.dispose();
    viewPessoaColaboradorModelController.dispose();
    loginController.dispose();
    senhaController.dispose();
    super.onClose();
  }

}