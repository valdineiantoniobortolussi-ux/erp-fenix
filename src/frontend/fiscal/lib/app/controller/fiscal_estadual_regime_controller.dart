import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/controller/controller_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';

import 'package:fiscal/app/routes/app_routes.dart';
import 'package:fiscal/app/data/repository/fiscal_estadual_regime_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalEstadualRegimeController extends GetxController with ControllerBaseMixin {
  final FiscalEstadualRegimeRepository fiscalEstadualRegimeRepository;
  FiscalEstadualRegimeController({required this.fiscalEstadualRegimeRepository});

  // general
  final _dbColumns = FiscalEstadualRegimeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FiscalEstadualRegimeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = fiscalEstadualRegimeGridColumns();
  
  var _fiscalEstadualRegimeModelList = <FiscalEstadualRegimeModel>[];

  final _fiscalEstadualRegimeModel = FiscalEstadualRegimeModel().obs;
  FiscalEstadualRegimeModel get fiscalEstadualRegimeModel => _fiscalEstadualRegimeModel.value;
  set fiscalEstadualRegimeModel(value) => _fiscalEstadualRegimeModel.value = value ?? FiscalEstadualRegimeModel();

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
    for (var fiscalEstadualRegimeModel in _fiscalEstadualRegimeModelList) {
      plutoRowList.add(_getPlutoRow(fiscalEstadualRegimeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FiscalEstadualRegimeModel fiscalEstadualRegimeModel) {
    return PlutoRow(
      cells: _getPlutoCells(fiscalEstadualRegimeModel: fiscalEstadualRegimeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FiscalEstadualRegimeModel? fiscalEstadualRegimeModel}) {
    return {
			"id": PlutoCell(value: fiscalEstadualRegimeModel?.id ?? 0),
			"uf": PlutoCell(value: fiscalEstadualRegimeModel?.uf ?? ''),
			"codigo": PlutoCell(value: fiscalEstadualRegimeModel?.codigo ?? ''),
			"nome": PlutoCell(value: fiscalEstadualRegimeModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _fiscalEstadualRegimeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      fiscalEstadualRegimeModel.plutoRowToObject(plutoRow);
    } else {
      fiscalEstadualRegimeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Regime Estadual]';
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
    await Get.find<FiscalEstadualRegimeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await fiscalEstadualRegimeRepository.getList(filter: filter).then( (data){ _fiscalEstadualRegimeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Regime Estadual',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.fiscalEstadualRegimeEditPage)!.then((value) {
        if (fiscalEstadualRegimeModel.id == 0) {
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
    fiscalEstadualRegimeModel = FiscalEstadualRegimeModel();
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
        if (await fiscalEstadualRegimeRepository.delete(id: currentRow.cells['id']!.value)) {
          _fiscalEstadualRegimeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final codigoController = TextEditingController();
	final nomeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalEstadualRegimeModel.id;
		plutoRow.cells['uf']?.value = fiscalEstadualRegimeModel.uf;
		plutoRow.cells['codigo']?.value = fiscalEstadualRegimeModel.codigo;
		plutoRow.cells['nome']?.value = fiscalEstadualRegimeModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await fiscalEstadualRegimeRepository.save(fiscalEstadualRegimeModel: fiscalEstadualRegimeModel); 
        if (result != null) {
          fiscalEstadualRegimeModel = result;
          if (_isInserting) {
            _fiscalEstadualRegimeModelList.add(result);
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
		functionName = "fiscal_estadual_regime";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		codigoController.dispose();
		nomeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}