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
import 'package:fiscal/app/data/repository/fiscal_municipal_regime_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalMunicipalRegimeController extends GetxController with ControllerBaseMixin {
  final FiscalMunicipalRegimeRepository fiscalMunicipalRegimeRepository;
  FiscalMunicipalRegimeController({required this.fiscalMunicipalRegimeRepository});

  // general
  final _dbColumns = FiscalMunicipalRegimeModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FiscalMunicipalRegimeModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = fiscalMunicipalRegimeGridColumns();
  
  var _fiscalMunicipalRegimeModelList = <FiscalMunicipalRegimeModel>[];

  final _fiscalMunicipalRegimeModel = FiscalMunicipalRegimeModel().obs;
  FiscalMunicipalRegimeModel get fiscalMunicipalRegimeModel => _fiscalMunicipalRegimeModel.value;
  set fiscalMunicipalRegimeModel(value) => _fiscalMunicipalRegimeModel.value = value ?? FiscalMunicipalRegimeModel();

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
    for (var fiscalMunicipalRegimeModel in _fiscalMunicipalRegimeModelList) {
      plutoRowList.add(_getPlutoRow(fiscalMunicipalRegimeModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FiscalMunicipalRegimeModel fiscalMunicipalRegimeModel) {
    return PlutoRow(
      cells: _getPlutoCells(fiscalMunicipalRegimeModel: fiscalMunicipalRegimeModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FiscalMunicipalRegimeModel? fiscalMunicipalRegimeModel}) {
    return {
			"id": PlutoCell(value: fiscalMunicipalRegimeModel?.id ?? 0),
			"uf": PlutoCell(value: fiscalMunicipalRegimeModel?.uf ?? ''),
			"codigo": PlutoCell(value: fiscalMunicipalRegimeModel?.codigo ?? ''),
			"nome": PlutoCell(value: fiscalMunicipalRegimeModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _fiscalMunicipalRegimeModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      fiscalMunicipalRegimeModel.plutoRowToObject(plutoRow);
    } else {
      fiscalMunicipalRegimeModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Regime Municipal]';
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
    await Get.find<FiscalMunicipalRegimeController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await fiscalMunicipalRegimeRepository.getList(filter: filter).then( (data){ _fiscalMunicipalRegimeModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Regime Municipal',
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
      Get.toNamed(Routes.fiscalMunicipalRegimeEditPage)!.then((value) {
        if (fiscalMunicipalRegimeModel.id == 0) {
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
    fiscalMunicipalRegimeModel = FiscalMunicipalRegimeModel();
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
        if (await fiscalMunicipalRegimeRepository.delete(id: currentRow.cells['id']!.value)) {
          _fiscalMunicipalRegimeModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = fiscalMunicipalRegimeModel.id;
		plutoRow.cells['uf']?.value = fiscalMunicipalRegimeModel.uf;
		plutoRow.cells['codigo']?.value = fiscalMunicipalRegimeModel.codigo;
		plutoRow.cells['nome']?.value = fiscalMunicipalRegimeModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await fiscalMunicipalRegimeRepository.save(fiscalMunicipalRegimeModel: fiscalMunicipalRegimeModel); 
        if (result != null) {
          fiscalMunicipalRegimeModel = result;
          if (_isInserting) {
            _fiscalMunicipalRegimeModelList.add(result);
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
		functionName = "fiscal_municipal_regime";
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