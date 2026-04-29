import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/page_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/routes/app_routes.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/repository/empresa_repository.dart';

class EmpresaController extends ControllerBase<EmpresaModel, EmpresaRepository> 
with GetSingleTickerProviderStateMixin {

  EmpresaController({required super.repository}) {
    dbColumns = EmpresaModel.dbColumns;
    aliasColumns = EmpresaModel.aliasColumns;
    gridColumns = empresaGridColumns();
    functionName = "empresa";
    screenTitle = "Empresa";
  }

  final empresaScaffoldKey = GlobalKey<ScaffoldState>();
  final empresaTabPageScaffoldKey = GlobalKey<ScaffoldState>();
  final empresaFormKey = GlobalKey<FormState>();
  late TabController tabController;
  String? mandatoryMessage;  

  @override
  EmpresaModel createNewModel() => EmpresaModel();

  @override
  final standardFieldForFilter = EmpresaModel.aliasColumns[EmpresaModel.dbColumns.indexOf('razao_social')];

  final razaoSocialController = TextEditingController();
  final nomeFantasiaController = TextEditingController();
  final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
  final inscricaoEstadualController = TextEditingController();
  final inscricaoMunicipalController = TextEditingController();
  final emailController = TextEditingController();
  final siteController = TextEditingController();
  final contatoController = TextEditingController();
  final inscricaoJuntaComercialController = TextEditingController();
  final codigoIbgeCidadeController = MoneyMaskedTextController(precision: 0, decimalSeparator: '', thousandSeparator: '');
  final codigoIbgeUfController = MoneyMaskedTextController(precision: 0, decimalSeparator: '', thousandSeparator: '');
  final ceiController = TextEditingController();
  final codigoCnaePrincipalController = TextEditingController();
  final imagemLogotipoController = TextEditingController();

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['razao_social'],
    'secondaryColumns': ['nome_fantasia'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((empresa) => empresa.toJson).toList();
  }

  @override
  void prepareForInsert() {
    isNewRecord = true;
    currentModel = createNewModel();
    _resetForm();
    tabController.animateTo(0);
    _configureChildrenControllers();
    Get.toNamed(Routes.empresaTabPage);
  }

  void _resetForm() {
    formWasChanged = false;
    razaoSocialController.text = '';
    nomeFantasiaController.text = '';
    cnpjController.text = '';
    inscricaoEstadualController.text = '';
    inscricaoMunicipalController.text = '';
    emailController.text = '';
    siteController.text = '';
    contatoController.text = '';
    inscricaoJuntaComercialController.text = '';
    codigoIbgeCidadeController.updateValue(0);
    codigoIbgeUfController.updateValue(0);
    ceiController.text = '';
    codigoCnaePrincipalController.text = '';
    imagemLogotipoController.text = '';
  }

  @override
  void selectRowForEditingById(int id) {
    final model = modelList.firstWhere((m) => m.id == id);
    currentModel = model.clone();
    updateControllersFromModel();

    tabController.animateTo(0);
    _configureChildrenControllers();
    Get.toNamed(Routes.empresaTabPage);
  }

  _configureChildrenControllers() {
    //Contatos
		Get.put<EmpresaContatoController>(EmpresaContatoController()); 
		final empresaContatoController = Get.find<EmpresaContatoController>(); 
		empresaContatoController.userMadeChanges = false; 

    //Telefones
		Get.put<EmpresaTelefoneController>(EmpresaTelefoneController()); 
		final empresaTelefoneController = Get.find<EmpresaTelefoneController>(); 
		empresaTelefoneController.userMadeChanges = false; 

    //CNAEs
		Get.put<EmpresaCnaeController>(EmpresaCnaeController()); 
		final empresaCnaeController = Get.find<EmpresaCnaeController>(); 
		empresaCnaeController.userMadeChanges = false; 

    //Endereços
		Get.put<EmpresaEnderecoController>(EmpresaEnderecoController()); 
		final empresaEnderecoController = Get.find<EmpresaEnderecoController>(); 
		empresaEnderecoController.userMadeChanges = false; 

  }
  
  void updateControllersFromModel() {
    razaoSocialController.text = currentModel.razaoSocial ?? '';
    nomeFantasiaController.text = currentModel.nomeFantasia ?? '';
    cnpjController.text = currentModel.cnpj ?? '';
    inscricaoEstadualController.text = currentModel.inscricaoEstadual ?? '';
    inscricaoMunicipalController.text = currentModel.inscricaoMunicipal ?? '';
    emailController.text = currentModel.email ?? '';
    siteController.text = currentModel.site ?? '';
    contatoController.text = currentModel.contato ?? '';
    inscricaoJuntaComercialController.text = currentModel.inscricaoJuntaComercial ?? '';
    codigoIbgeCidadeController.updateValue((currentModel.codigoIbgeCidade ?? 0).toDouble());
    codigoIbgeUfController.updateValue((currentModel.codigoIbgeUf ?? 0).toDouble());
    ceiController.text = currentModel.cei ?? '';
    codigoCnaePrincipalController.text = currentModel.codigoCnaePrincipal ?? '';
    imagemLogotipoController.text = currentModel.imagemLogotipo ?? '';
    formWasChanged = false;
  }

  @override
  Future<void> save() async {
    if (!validateCurrentForm()) return;
    if (validateForms()) {
      if (userMadeChanges()) {
        final existingIndex = modelList.indexWhere((m) => m.id == currentModel.id);

        if (existingIndex >= 0) {
          modelList[existingIndex] = currentModel.clone();
        }

        final result = await repository.save(empresaModel: currentModel);
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
      } else {
        Get.back();
      }
    } 
  }


  List<Tab> tabItems = [
    Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Empresa', 
		),
    Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Contatos', 
		),
    Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Telefones', 
		),
    Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'CNAEs', 
		),
    Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Endereços', 
		),
  ];

  List<Widget> tabPages() {
    return [
      EmpresaEditPage(),
      const EmpresaContatoListPage(),
      const EmpresaTelefoneListPage(),
      const EmpresaCnaeListPage(),
      const EmpresaEnderecoListPage(),
    ];
  }

  @override
  void preventDataLoss() {
    if (userMadeChanges()) {
      showQuestionDialog('message_data_loss'.tr, () { 
        Get.back(); 
      });
    } else {
      Get.back();
    }
  }  

  bool userMadeChanges() {
    return
    formWasChanged 
    || 
		Get.find<EmpresaContatoController>().userMadeChanges
    || 
		Get.find<EmpresaTelefoneController>().userMadeChanges
    || 
		Get.find<EmpresaCnaeController>().userMadeChanges
    || 
		Get.find<EmpresaEnderecoController>().userMadeChanges
    ;
  }

  void tabChange(int index) {
    validateCurrentForm();
  }

  bool validateCurrentForm() {
    final emailValidationMessage = ValidateFormField.validateEmail(currentModel.email); 
		if (emailValidationMessage != null) { 
			tabController.animateTo(0); 
			showErrorSnackBar(message: emailValidationMessage); 
			return false; 
		}
    return true;
  }

  bool validateForms() {
    return true;
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(vsync: this, length: tabItems.length);
  }
	
  @override
  void onClose() {
    tabController.dispose();
    razaoSocialController.dispose();
    nomeFantasiaController.dispose();
    cnpjController.dispose();
    inscricaoEstadualController.dispose();
    inscricaoMunicipalController.dispose();
    emailController.dispose();
    siteController.dispose();
    contatoController.dispose();
    inscricaoJuntaComercialController.dispose();
    codigoIbgeCidadeController.dispose();
    codigoIbgeUfController.dispose();
    ceiController.dispose();
    codigoCnaePrincipalController.dispose();
    imagemLogotipoController.dispose();
    super.onClose();
  }	
}