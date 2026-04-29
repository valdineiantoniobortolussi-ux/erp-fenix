import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/controller/controller_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/page/grid_columns/grid_columns_imports.dart';

import 'package:wms/app/routes/app_routes.dart';
import 'package:wms/app/data/repository/wms_expedicao_repository.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';
import 'package:wms/app/mixin/controller_base_mixin.dart';

class WmsExpedicaoController extends GetxController with ControllerBaseMixin {
  final WmsExpedicaoRepository wmsExpedicaoRepository;
  WmsExpedicaoController({required this.wmsExpedicaoRepository});

  // general
  final _dbColumns = WmsExpedicaoModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = WmsExpedicaoModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = wmsExpedicaoGridColumns();
  
  var _wmsExpedicaoModelList = <WmsExpedicaoModel>[];

  final _wmsExpedicaoModel = WmsExpedicaoModel().obs;
  WmsExpedicaoModel get wmsExpedicaoModel => _wmsExpedicaoModel.value;
  set wmsExpedicaoModel(value) => _wmsExpedicaoModel.value = value ?? WmsExpedicaoModel();

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
    for (var wmsExpedicaoModel in _wmsExpedicaoModelList) {
      plutoRowList.add(_getPlutoRow(wmsExpedicaoModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(WmsExpedicaoModel wmsExpedicaoModel) {
    return PlutoRow(
      cells: _getPlutoCells(wmsExpedicaoModel: wmsExpedicaoModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ WmsExpedicaoModel? wmsExpedicaoModel}) {
    return {
			"id": PlutoCell(value: wmsExpedicaoModel?.id ?? 0),
			"wmsOrdemSeparacaoDet": PlutoCell(value: wmsExpedicaoModel?.wmsOrdemSeparacaoDetModel?.id ?? ''),
			"wmsArmazenamento": PlutoCell(value: wmsExpedicaoModel?.wmsArmazenamentoModel?.id ?? ''),
			"quantidade": PlutoCell(value: wmsExpedicaoModel?.quantidade ?? 0),
			"dataSaida": PlutoCell(value: wmsExpedicaoModel?.dataSaida ?? ''),
			"idWmsOrdemSeparacaoDet": PlutoCell(value: wmsExpedicaoModel?.idWmsOrdemSeparacaoDet ?? 0),
			"idWmsArmazenamento": PlutoCell(value: wmsExpedicaoModel?.idWmsArmazenamento ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _wmsExpedicaoModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      wmsExpedicaoModel.plutoRowToObject(plutoRow);
    } else {
      wmsExpedicaoModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Expedição]';
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
    await Get.find<WmsExpedicaoController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await wmsExpedicaoRepository.getList(filter: filter).then( (data){ _wmsExpedicaoModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Expedição',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			wmsOrdemSeparacaoDetModelController.text = currentRow.cells['wmsOrdemSeparacaoDet']?.value ?? '';
			wmsArmazenamentoModelController.text = currentRow.cells['wmsArmazenamento']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.wmsExpedicaoEditPage)!.then((value) {
        if (wmsExpedicaoModel.id == 0) {
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
    wmsExpedicaoModel = WmsExpedicaoModel();
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
        if (await wmsExpedicaoRepository.delete(id: currentRow.cells['id']!.value)) {
          _wmsExpedicaoModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final wmsOrdemSeparacaoDetModelController = TextEditingController();
	final wmsArmazenamentoModelController = TextEditingController();
	final quantidadeController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsExpedicaoModel.id;
		plutoRow.cells['idWmsOrdemSeparacaoDet']?.value = wmsExpedicaoModel.idWmsOrdemSeparacaoDet;
		plutoRow.cells['wmsOrdemSeparacaoDet']?.value = wmsExpedicaoModel.wmsOrdemSeparacaoDetModel?.id;
		plutoRow.cells['idWmsArmazenamento']?.value = wmsExpedicaoModel.idWmsArmazenamento;
		plutoRow.cells['wmsArmazenamento']?.value = wmsExpedicaoModel.wmsArmazenamentoModel?.id;
		plutoRow.cells['quantidade']?.value = wmsExpedicaoModel.quantidade;
		plutoRow.cells['dataSaida']?.value = Util.formatDate(wmsExpedicaoModel.dataSaida);
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await wmsExpedicaoRepository.save(wmsExpedicaoModel: wmsExpedicaoModel); 
        if (result != null) {
          wmsExpedicaoModel = result;
          if (_isInserting) {
            _wmsExpedicaoModelList.add(result);
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

	Future callWmsOrdemSeparacaoDetLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Ordem Separação]'; 
		lookupController.route = '/wms-ordem-separacao-det/'; 
		lookupController.gridColumns = wmsOrdemSeparacaoDetGridColumns(isForLookup: true); 
		lookupController.aliasColumns = WmsOrdemSeparacaoDetModel.aliasColumns; 
		lookupController.dbColumns = WmsOrdemSeparacaoDetModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			wmsExpedicaoModel.idWmsOrdemSeparacaoDet = plutoRowResult.cells['id']!.value; 
			wmsExpedicaoModel.wmsOrdemSeparacaoDetModel!.plutoRowToObject(plutoRowResult); 
			wmsOrdemSeparacaoDetModelController.text = wmsExpedicaoModel.wmsOrdemSeparacaoDetModel?.id?.toString() ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callWmsArmazenamentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Armazenamento]'; 
		lookupController.route = '/wms-armazenamento/'; 
		lookupController.gridColumns = wmsArmazenamentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = WmsArmazenamentoModel.aliasColumns; 
		lookupController.dbColumns = WmsArmazenamentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			wmsExpedicaoModel.idWmsArmazenamento = plutoRowResult.cells['id']!.value; 
			wmsExpedicaoModel.wmsArmazenamentoModel!.plutoRowToObject(plutoRowResult); 
			wmsArmazenamentoModelController.text = wmsExpedicaoModel.wmsArmazenamentoModel?.id?.toString() ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "wms_expedicao";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		wmsOrdemSeparacaoDetModelController.dispose();
		wmsArmazenamentoModelController.dispose();
		quantidadeController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}