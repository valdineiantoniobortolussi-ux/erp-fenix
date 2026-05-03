import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';

import 'package:contabil/app/routes/app_routes.dart';
import 'package:contabil/app/data/repository/aidf_aimdf_repository.dart';
import 'package:contabil/app/page/shared_page/shared_page_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';
import 'package:contabil/app/mixin/controller_base_mixin.dart';

class AidfAimdfController extends GetxController with ControllerBaseMixin {
  final AidfAimdfRepository aidfAimdfRepository;
  AidfAimdfController({required this.aidfAimdfRepository});

  // general
  final _dbColumns = AidfAimdfModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = AidfAimdfModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = aidfAimdfGridColumns();
  
  var _aidfAimdfModelList = <AidfAimdfModel>[];

  final _aidfAimdfModel = AidfAimdfModel().obs;
  AidfAimdfModel get aidfAimdfModel => _aidfAimdfModel.value;
  set aidfAimdfModel(value) => _aidfAimdfModel.value = value ?? AidfAimdfModel();

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
    for (var aidfAimdfModel in _aidfAimdfModelList) {
      plutoRowList.add(_getPlutoRow(aidfAimdfModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(AidfAimdfModel aidfAimdfModel) {
    return PlutoRow(
      cells: _getPlutoCells(aidfAimdfModel: aidfAimdfModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ AidfAimdfModel? aidfAimdfModel}) {
    return {
			"id": PlutoCell(value: aidfAimdfModel?.id ?? 0),
			"numero": PlutoCell(value: aidfAimdfModel?.numero ?? 0),
			"dataValidade": PlutoCell(value: aidfAimdfModel?.dataValidade ?? ''),
			"dataAutorizacao": PlutoCell(value: aidfAimdfModel?.dataAutorizacao ?? ''),
			"numeroAutorizacao": PlutoCell(value: aidfAimdfModel?.numeroAutorizacao ?? ''),
			"formularioDisponivel": PlutoCell(value: aidfAimdfModel?.formularioDisponivel ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _aidfAimdfModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      aidfAimdfModel.plutoRowToObject(plutoRow);
    } else {
      aidfAimdfModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [AIDF/AIMDF]';
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
    await Get.find<AidfAimdfController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await aidfAimdfRepository.getList(filter: filter).then( (data){ _aidfAimdfModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'AIDF/AIMDF',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			numeroAutorizacaoController.text = currentRow.cells['numeroAutorizacao']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.aidfAimdfEditPage)!.then((value) {
        if (aidfAimdfModel.id == 0) {
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
    aidfAimdfModel = AidfAimdfModel();
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
        if (await aidfAimdfRepository.delete(id: currentRow.cells['id']!.value)) {
          _aidfAimdfModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final numeroController = TextEditingController();
	final numeroAutorizacaoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = aidfAimdfModel.id;
		plutoRow.cells['numero']?.value = aidfAimdfModel.numero;
		plutoRow.cells['dataValidade']?.value = Util.formatDate(aidfAimdfModel.dataValidade);
		plutoRow.cells['dataAutorizacao']?.value = Util.formatDate(aidfAimdfModel.dataAutorizacao);
		plutoRow.cells['numeroAutorizacao']?.value = aidfAimdfModel.numeroAutorizacao;
		plutoRow.cells['formularioDisponivel']?.value = aidfAimdfModel.formularioDisponivel;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await aidfAimdfRepository.save(aidfAimdfModel: aidfAimdfModel); 
        if (result != null) {
          aidfAimdfModel = result;
          if (_isInserting) {
            _aidfAimdfModelList.add(result);
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
		functionName = "aidf_aimdf";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		numeroController.dispose();
		numeroAutorizacaoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}