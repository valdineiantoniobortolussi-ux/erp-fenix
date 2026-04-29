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
import 'package:fiscal/app/data/repository/fiscal_estadual_porte_repository.dart';
import 'package:fiscal/app/page/shared_page/shared_page_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';
import 'package:fiscal/app/mixin/controller_base_mixin.dart';

class FiscalEstadualPorteController extends GetxController with ControllerBaseMixin {
  final FiscalEstadualPorteRepository fiscalEstadualPorteRepository;
  FiscalEstadualPorteController({required this.fiscalEstadualPorteRepository});

  // general
  final _dbColumns = FiscalEstadualPorteModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = FiscalEstadualPorteModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = fiscalEstadualPorteGridColumns();
  
  var _fiscalEstadualPorteModelList = <FiscalEstadualPorteModel>[];

  final _fiscalEstadualPorteModel = FiscalEstadualPorteModel().obs;
  FiscalEstadualPorteModel get fiscalEstadualPorteModel => _fiscalEstadualPorteModel.value;
  set fiscalEstadualPorteModel(value) => _fiscalEstadualPorteModel.value = value ?? FiscalEstadualPorteModel();

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
    for (var fiscalEstadualPorteModel in _fiscalEstadualPorteModelList) {
      plutoRowList.add(_getPlutoRow(fiscalEstadualPorteModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(FiscalEstadualPorteModel fiscalEstadualPorteModel) {
    return PlutoRow(
      cells: _getPlutoCells(fiscalEstadualPorteModel: fiscalEstadualPorteModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ FiscalEstadualPorteModel? fiscalEstadualPorteModel}) {
    return {
			"id": PlutoCell(value: fiscalEstadualPorteModel?.id ?? 0),
			"uf": PlutoCell(value: fiscalEstadualPorteModel?.uf ?? ''),
			"codigo": PlutoCell(value: fiscalEstadualPorteModel?.codigo ?? ''),
			"nome": PlutoCell(value: fiscalEstadualPorteModel?.nome ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _fiscalEstadualPorteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      fiscalEstadualPorteModel.plutoRowToObject(plutoRow);
    } else {
      fiscalEstadualPorteModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Porte Estadual]';
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
    await Get.find<FiscalEstadualPorteController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await fiscalEstadualPorteRepository.getList(filter: filter).then( (data){ _fiscalEstadualPorteModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Porte Estadual',
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
      Get.toNamed(Routes.fiscalEstadualPorteEditPage)!.then((value) {
        if (fiscalEstadualPorteModel.id == 0) {
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
    fiscalEstadualPorteModel = FiscalEstadualPorteModel();
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
        if (await fiscalEstadualPorteRepository.delete(id: currentRow.cells['id']!.value)) {
          _fiscalEstadualPorteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
		plutoRow.cells['id']?.value = fiscalEstadualPorteModel.id;
		plutoRow.cells['uf']?.value = fiscalEstadualPorteModel.uf;
		plutoRow.cells['codigo']?.value = fiscalEstadualPorteModel.codigo;
		plutoRow.cells['nome']?.value = fiscalEstadualPorteModel.nome;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await fiscalEstadualPorteRepository.save(fiscalEstadualPorteModel: fiscalEstadualPorteModel); 
        if (result != null) {
          fiscalEstadualPorteModel = result;
          if (_isInserting) {
            _fiscalEstadualPorteModelList.add(result);
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
		functionName = "fiscal_estadual_porte";
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