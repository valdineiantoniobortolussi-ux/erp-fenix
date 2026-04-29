import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/controller/controller_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:contratos/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contratos/app/routes/app_routes.dart';
import 'package:contratos/app/data/repository/contrato_template_repository.dart';
import 'package:contratos/app/page/shared_page/shared_page_imports.dart';
import 'package:contratos/app/page/shared_widget/message_dialog.dart';
import 'package:contratos/app/mixin/controller_base_mixin.dart';

class ContratoTemplateController extends GetxController with ControllerBaseMixin {
  final ContratoTemplateRepository contratoTemplateRepository;
  ContratoTemplateController({required this.contratoTemplateRepository});

  // general
  final _dbColumns = ContratoTemplateModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = ContratoTemplateModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = contratoTemplateGridColumns();
  
  var _contratoTemplateModelList = <ContratoTemplateModel>[];

  final _contratoTemplateModel = ContratoTemplateModel().obs;
  ContratoTemplateModel get contratoTemplateModel => _contratoTemplateModel.value;
  set contratoTemplateModel(value) => _contratoTemplateModel.value = value ?? ContratoTemplateModel();

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
    for (var contratoTemplateModel in _contratoTemplateModelList) {
      plutoRowList.add(_getPlutoRow(contratoTemplateModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(ContratoTemplateModel contratoTemplateModel) {
    return PlutoRow(
      cells: _getPlutoCells(contratoTemplateModel: contratoTemplateModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ ContratoTemplateModel? contratoTemplateModel}) {
    return {
			"id": PlutoCell(value: contratoTemplateModel?.id ?? 0),
			"nome": PlutoCell(value: contratoTemplateModel?.nome ?? ''),
			"descricao": PlutoCell(value: contratoTemplateModel?.descricao ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _contratoTemplateModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      contratoTemplateModel.plutoRowToObject(plutoRow);
    } else {
      contratoTemplateModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Template]';
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
    await Get.find<ContratoTemplateController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await contratoTemplateRepository.getList(filter: filter).then( (data){ _contratoTemplateModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Template',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.contratoTemplateEditPage)!.then((value) {
        if (contratoTemplateModel.id == 0) {
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
    contratoTemplateModel = ContratoTemplateModel();
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
        if (await contratoTemplateRepository.delete(id: currentRow.cells['id']!.value)) {
          _contratoTemplateModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final descricaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contratoTemplateModel.id;
		plutoRow.cells['nome']?.value = contratoTemplateModel.nome;
		plutoRow.cells['descricao']?.value = contratoTemplateModel.descricao;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await contratoTemplateRepository.save(contratoTemplateModel: contratoTemplateModel); 
        if (result != null) {
          contratoTemplateModel = result;
          if (_isInserting) {
            _contratoTemplateModelList.add(result);
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
		functionName = "contrato_template";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nomeController.dispose();
		descricaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}