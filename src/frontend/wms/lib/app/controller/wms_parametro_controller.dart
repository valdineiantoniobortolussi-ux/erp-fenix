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
import 'package:wms/app/data/repository/wms_parametro_repository.dart';
import 'package:wms/app/page/shared_page/shared_page_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';
import 'package:wms/app/mixin/controller_base_mixin.dart';

class WmsParametroController extends GetxController with ControllerBaseMixin {
  final WmsParametroRepository wmsParametroRepository;
  WmsParametroController({required this.wmsParametroRepository});

  // general
  final _dbColumns = WmsParametroModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = WmsParametroModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = wmsParametroGridColumns();
  
  var _wmsParametroModelList = <WmsParametroModel>[];

  final _wmsParametroModel = WmsParametroModel().obs;
  WmsParametroModel get wmsParametroModel => _wmsParametroModel.value;
  set wmsParametroModel(value) => _wmsParametroModel.value = value ?? WmsParametroModel();

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
    for (var wmsParametroModel in _wmsParametroModelList) {
      plutoRowList.add(_getPlutoRow(wmsParametroModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(WmsParametroModel wmsParametroModel) {
    return PlutoRow(
      cells: _getPlutoCells(wmsParametroModel: wmsParametroModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ WmsParametroModel? wmsParametroModel}) {
    return {
			"id": PlutoCell(value: wmsParametroModel?.id ?? 0),
			"horaPorVolume": PlutoCell(value: wmsParametroModel?.horaPorVolume ?? 0),
			"pessoaPorVolume": PlutoCell(value: wmsParametroModel?.pessoaPorVolume ?? 0),
			"horaPorPeso": PlutoCell(value: wmsParametroModel?.horaPorPeso ?? 0),
			"pessoaPorPeso": PlutoCell(value: wmsParametroModel?.pessoaPorPeso ?? 0),
			"itemDiferenteCaixa": PlutoCell(value: wmsParametroModel?.itemDiferenteCaixa ?? ''),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _wmsParametroModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      wmsParametroModel.plutoRowToObject(plutoRow);
    } else {
      wmsParametroModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Parâmetros]';
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
    await Get.find<WmsParametroController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await wmsParametroRepository.getList(filter: filter).then( (data){ _wmsParametroModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Parâmetros',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			horaPorVolumeController.text = currentRow.cells['horaPorVolume']?.value?.toString() ?? '';
			pessoaPorVolumeController.text = currentRow.cells['pessoaPorVolume']?.value?.toString() ?? '';
			horaPorPesoController.text = currentRow.cells['horaPorPeso']?.value?.toString() ?? '';
			pessoaPorPesoController.text = currentRow.cells['pessoaPorPeso']?.value?.toString() ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.wmsParametroEditPage)!.then((value) {
        if (wmsParametroModel.id == 0) {
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
    wmsParametroModel = WmsParametroModel();
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
        if (await wmsParametroRepository.delete(id: currentRow.cells['id']!.value)) {
          _wmsParametroModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final horaPorVolumeController = TextEditingController();
	final pessoaPorVolumeController = TextEditingController();
	final horaPorPesoController = TextEditingController();
	final pessoaPorPesoController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsParametroModel.id;
		plutoRow.cells['horaPorVolume']?.value = wmsParametroModel.horaPorVolume;
		plutoRow.cells['pessoaPorVolume']?.value = wmsParametroModel.pessoaPorVolume;
		plutoRow.cells['horaPorPeso']?.value = wmsParametroModel.horaPorPeso;
		plutoRow.cells['pessoaPorPeso']?.value = wmsParametroModel.pessoaPorPeso;
		plutoRow.cells['itemDiferenteCaixa']?.value = wmsParametroModel.itemDiferenteCaixa;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await wmsParametroRepository.save(wmsParametroModel: wmsParametroModel); 
        if (result != null) {
          wmsParametroModel = result;
          if (_isInserting) {
            _wmsParametroModelList.add(result);
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
		functionName = "wms_parametro";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		horaPorVolumeController.dispose();
		pessoaPorVolumeController.dispose();
		horaPorPesoController.dispose();
		pessoaPorPesoController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}