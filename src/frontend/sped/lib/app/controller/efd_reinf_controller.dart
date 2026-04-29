import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:sped/app/infra/infra_imports.dart';
import 'package:sped/app/controller/controller_imports.dart';
import 'package:sped/app/data/model/model_imports.dart';
import 'package:sped/app/page/grid_columns/grid_columns_imports.dart';

import 'package:sped/app/routes/app_routes.dart';
import 'package:sped/app/data/repository/efd_reinf_repository.dart';
import 'package:sped/app/page/shared_page/shared_page_imports.dart';
import 'package:sped/app/page/shared_widget/message_dialog.dart';
import 'package:sped/app/mixin/controller_base_mixin.dart';

class EfdReinfController extends GetxController with ControllerBaseMixin {
  final EfdReinfRepository efdReinfRepository;
  EfdReinfController({required this.efdReinfRepository});

  // general
  final _dbColumns = EfdReinfModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = EfdReinfModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = efdReinfGridColumns();
  
  var _efdReinfModelList = <EfdReinfModel>[];

  final _efdReinfModel = EfdReinfModel().obs;
  EfdReinfModel get efdReinfModel => _efdReinfModel.value;
  set efdReinfModel(value) => _efdReinfModel.value = value ?? EfdReinfModel();

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
    for (var efdReinfModel in _efdReinfModelList) {
      plutoRowList.add(_getPlutoRow(efdReinfModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(EfdReinfModel efdReinfModel) {
    return PlutoRow(
      cells: _getPlutoCells(efdReinfModel: efdReinfModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ EfdReinfModel? efdReinfModel}) {
    return {
			"id": PlutoCell(value: efdReinfModel?.id ?? 0),
			"dataEmissao": PlutoCell(value: efdReinfModel?.dataEmissao ?? ''),
			"periodoInicial": PlutoCell(value: efdReinfModel?.periodoInicial ?? ''),
			"periodoFinal": PlutoCell(value: efdReinfModel?.periodoFinal ?? ''),
			"finalidadeArquivo": PlutoCell(value: efdReinfModel?.finalidadeArquivo ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _efdReinfModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      efdReinfModel.plutoRowToObject(plutoRow);
    } else {
      efdReinfModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [EFD REINF]';
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
    await Get.find<EfdReinfController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await efdReinfRepository.getList(filter: filter).then( (data){ _efdReinfModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'EFD REINF',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			finalidadeArquivoController.text = currentRow.cells['finalidadeArquivo']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.efdReinfEditPage)!.then((value) {
        if (efdReinfModel.id == 0) {
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
    efdReinfModel = EfdReinfModel();
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
        if (await efdReinfRepository.delete(id: currentRow.cells['id']!.value)) {
          _efdReinfModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final finalidadeArquivoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = efdReinfModel.id;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(efdReinfModel.dataEmissao);
		plutoRow.cells['periodoInicial']?.value = Util.formatDate(efdReinfModel.periodoInicial);
		plutoRow.cells['periodoFinal']?.value = Util.formatDate(efdReinfModel.periodoFinal);
		plutoRow.cells['finalidadeArquivo']?.value = efdReinfModel.finalidadeArquivo;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await efdReinfRepository.save(efdReinfModel: efdReinfModel); 
        if (result != null) {
          efdReinfModel = result;
          if (_isInserting) {
            _efdReinfModelList.add(result);
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
		functionName = "efd_reinf";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		finalidadeArquivoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}