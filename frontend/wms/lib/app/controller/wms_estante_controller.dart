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
import 'package:wms/app/data/repository/wms_estante_repository.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';
import 'package:wms/app/mixin/controller_base_mixin.dart';

class WmsEstanteController extends GetxController with ControllerBaseMixin {
  final WmsEstanteRepository wmsEstanteRepository;
  WmsEstanteController({required this.wmsEstanteRepository});

  // general
  final _dbColumns = WmsEstanteModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = WmsEstanteModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = wmsEstanteGridColumns();
  
  var _wmsEstanteModelList = <WmsEstanteModel>[];

  final _wmsEstanteModel = WmsEstanteModel().obs;
  WmsEstanteModel get wmsEstanteModel => _wmsEstanteModel.value;
  set wmsEstanteModel(value) => _wmsEstanteModel.value = value ?? WmsEstanteModel();

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
    for (var wmsEstanteModel in _wmsEstanteModelList) {
      plutoRowList.add(_getPlutoRow(wmsEstanteModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(WmsEstanteModel wmsEstanteModel) {
    return PlutoRow(
      cells: _getPlutoCells(wmsEstanteModel: wmsEstanteModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ WmsEstanteModel? wmsEstanteModel}) {
    return {
			"id": PlutoCell(value: wmsEstanteModel?.id ?? 0),
			"wmsRua": PlutoCell(value: wmsEstanteModel?.wmsRuaModel?.nome ?? ''),
			"codigo": PlutoCell(value: wmsEstanteModel?.codigo ?? ''),
			"quantidadeCaixa": PlutoCell(value: wmsEstanteModel?.quantidadeCaixa ?? 0),
			"idWmsRua": PlutoCell(value: wmsEstanteModel?.idWmsRua ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _wmsEstanteModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      wmsEstanteModel.plutoRowToObject(plutoRow);
    } else {
      wmsEstanteModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Estante]';
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
    await Get.find<WmsEstanteController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await wmsEstanteRepository.getList(filter: filter).then( (data){ _wmsEstanteModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Estante',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			wmsRuaModelController.text = currentRow.cells['wmsRua']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			quantidadeCaixaController.text = currentRow.cells['quantidadeCaixa']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.wmsEstanteEditPage)!.then((value) {
        if (wmsEstanteModel.id == 0) {
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
    wmsEstanteModel = WmsEstanteModel();
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
        if (await wmsEstanteRepository.delete(id: currentRow.cells['id']!.value)) {
          _wmsEstanteModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final wmsRuaModelController = TextEditingController();
	final codigoController = TextEditingController();
	final quantidadeCaixaController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsEstanteModel.id;
		plutoRow.cells['idWmsRua']?.value = wmsEstanteModel.idWmsRua;
		plutoRow.cells['wmsRua']?.value = wmsEstanteModel.wmsRuaModel?.nome;
		plutoRow.cells['codigo']?.value = wmsEstanteModel.codigo;
		plutoRow.cells['quantidadeCaixa']?.value = wmsEstanteModel.quantidadeCaixa;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await wmsEstanteRepository.save(wmsEstanteModel: wmsEstanteModel); 
        if (result != null) {
          wmsEstanteModel = result;
          if (_isInserting) {
            _wmsEstanteModelList.add(result);
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

	Future callWmsRuaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Rua]'; 
		lookupController.route = '/wms-rua/'; 
		lookupController.gridColumns = wmsRuaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = WmsRuaModel.aliasColumns; 
		lookupController.dbColumns = WmsRuaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			wmsEstanteModel.idWmsRua = plutoRowResult.cells['id']!.value; 
			wmsEstanteModel.wmsRuaModel!.plutoRowToObject(plutoRowResult); 
			wmsRuaModelController.text = wmsEstanteModel.wmsRuaModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "wms_estante";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		wmsRuaModelController.dispose();
		codigoController.dispose();
		quantidadeCaixaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}