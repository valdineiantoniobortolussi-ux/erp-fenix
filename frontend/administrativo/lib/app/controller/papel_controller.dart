import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/page_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/page/grid_columns/grid_columns_imports.dart';
import 'package:administrativo/app/routes/app_routes.dart';
import 'package:administrativo/app/controller/controller_imports.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/repository/papel_repository.dart';

class PapelController extends ControllerBase<PapelModel, PapelRepository> 
with GetSingleTickerProviderStateMixin {

  PapelController({required super.repository}) {
    dbColumns = PapelModel.dbColumns;
    aliasColumns = PapelModel.aliasColumns;
    gridColumns = papelGridColumns();
    functionName = "papel";
    screenTitle = "Papel";
  }

  final papelScaffoldKey = GlobalKey<ScaffoldState>();
  final papelTabPageScaffoldKey = GlobalKey<ScaffoldState>();
  final papelFormKey = GlobalKey<FormState>();
  late TabController tabController;
  String? mandatoryMessage;  

  @override
  PapelModel createNewModel() => PapelModel();

  @override
  final standardFieldForFilter = PapelModel.aliasColumns[PapelModel.dbColumns.indexOf('nome')];

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();

  final Map<String, dynamic> mobileConfig = {
    'primaryColumns': ['nome'],
    'secondaryColumns': ['descricao'],
  };

  List<Map<String, dynamic>> get mobileItems {
    return modelList.map((papel) => papel.toJson).toList();
  }

  @override
  void prepareForInsert() {
    isNewRecord = true;
    currentModel = createNewModel();
    _resetForm();
    tabController.animateTo(0);
    _configureChildrenControllers();
    Get.toNamed(Routes.papelTabPage);
  }

  void _resetForm() {
    formWasChanged = false;
    nomeController.text = '';
    descricaoController.text = '';
  }

  @override
  void selectRowForEditingById(int id) {
    final model = modelList.firstWhere((m) => m.id == id);
    currentModel = model.clone();
    updateControllersFromModel();

    tabController.animateTo(0);
    _configureChildrenControllers();
    Get.toNamed(Routes.papelTabPage);
  }

  _configureChildrenControllers() {
    //Controle de Acesso
		Get.put<PapelFuncaoController>(PapelFuncaoController()); 
		final papelFuncaoController = Get.find<PapelFuncaoController>(); 
		papelFuncaoController.userMadeChanges = false; 

  }
  
  void updateControllersFromModel() {
    nomeController.text = currentModel.nome ?? '';
    descricaoController.text = currentModel.descricao ?? '';
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

        final result = await repository.save(papelModel: currentModel);
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
			text: 'Papel', 
		),
    Tab( 
			icon: Icon(iconDataList[Random().nextInt(10)]), 
			text: 'Controle de Acesso', 
		),
  ];

  List<Widget> tabPages() {
    return [
      PapelEditPage(),
      const PapelFuncaoListPage(),
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
		Get.find<PapelFuncaoController>().userMadeChanges
    ;
  }

  void tabChange(int index) {
    validateCurrentForm();
  }

  bool validateCurrentForm() {
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
    nomeController.dispose();
    descricaoController.dispose();
    super.onClose();
  }	
}