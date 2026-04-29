import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/controller/controller_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';

import 'package:nfe/app/routes/app_routes.dart';
import 'package:nfe/app/data/repository/nfe_transporte_volume_lacre_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeTransporteVolumeLacreController extends GetxController with ControllerBaseMixin {
  final NfeTransporteVolumeLacreRepository nfeTransporteVolumeLacreRepository;
  NfeTransporteVolumeLacreController({required this.nfeTransporteVolumeLacreRepository});

  // general
  final _dbColumns = NfeTransporteVolumeLacreModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeTransporteVolumeLacreModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeTransporteVolumeLacreGridColumns();
  
  var _nfeTransporteVolumeLacreModelList = <NfeTransporteVolumeLacreModel>[];

  final _nfeTransporteVolumeLacreModel = NfeTransporteVolumeLacreModel().obs;
  NfeTransporteVolumeLacreModel get nfeTransporteVolumeLacreModel => _nfeTransporteVolumeLacreModel.value;
  set nfeTransporteVolumeLacreModel(value) => _nfeTransporteVolumeLacreModel.value = value ?? NfeTransporteVolumeLacreModel();

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
    for (var nfeTransporteVolumeLacreModel in _nfeTransporteVolumeLacreModelList) {
      plutoRowList.add(_getPlutoRow(nfeTransporteVolumeLacreModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeTransporteVolumeLacreModel nfeTransporteVolumeLacreModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeTransporteVolumeLacreModel: nfeTransporteVolumeLacreModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeTransporteVolumeLacreModel? nfeTransporteVolumeLacreModel}) {
    return {
			"id": PlutoCell(value: nfeTransporteVolumeLacreModel?.id ?? 0),
			"nfeTransporteVolume": PlutoCell(value: nfeTransporteVolumeLacreModel?.nfeTransporteVolumeModel?.numeracao ?? ''),
			"numero": PlutoCell(value: nfeTransporteVolumeLacreModel?.numero ?? ''),
			"idNfeTransporteVolume": PlutoCell(value: nfeTransporteVolumeLacreModel?.idNfeTransporteVolume ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeTransporteVolumeLacreModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeTransporteVolumeLacreModel.plutoRowToObject(plutoRow);
    } else {
      nfeTransporteVolumeLacreModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Nfe Transporte Volume Lacre]';
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
    await Get.find<NfeTransporteVolumeLacreController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeTransporteVolumeLacreRepository.getList(filter: filter).then( (data){ _nfeTransporteVolumeLacreModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Nfe Transporte Volume Lacre',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeTransporteVolumeModelController.text = currentRow.cells['nfeTransporteVolume']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeTransporteVolumeLacreEditPage)!.then((value) {
        if (nfeTransporteVolumeLacreModel.id == 0) {
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
    nfeTransporteVolumeLacreModel = NfeTransporteVolumeLacreModel();
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
        if (await nfeTransporteVolumeLacreRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeTransporteVolumeLacreModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeTransporteVolumeModelController = TextEditingController();
	final numeroController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeTransporteVolumeLacreModel.id;
		plutoRow.cells['idNfeTransporteVolume']?.value = nfeTransporteVolumeLacreModel.idNfeTransporteVolume;
		plutoRow.cells['nfeTransporteVolume']?.value = nfeTransporteVolumeLacreModel.nfeTransporteVolumeModel?.numeracao;
		plutoRow.cells['numero']?.value = nfeTransporteVolumeLacreModel.numero;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeTransporteVolumeLacreRepository.save(nfeTransporteVolumeLacreModel: nfeTransporteVolumeLacreModel); 
        if (result != null) {
          nfeTransporteVolumeLacreModel = result;
          if (_isInserting) {
            _nfeTransporteVolumeLacreModelList.add(result);
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

	Future callNfeTransporteVolumeLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Nfe Transporte Volume]'; 
		lookupController.route = '/nfe-transporte-volume/'; 
		lookupController.gridColumns = nfeTransporteVolumeGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeTransporteVolumeModel.aliasColumns; 
		lookupController.dbColumns = NfeTransporteVolumeModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeTransporteVolumeLacreModel.idNfeTransporteVolume = plutoRowResult.cells['id']!.value; 
			nfeTransporteVolumeLacreModel.nfeTransporteVolumeModel!.plutoRowToObject(plutoRowResult); 
			nfeTransporteVolumeModelController.text = nfeTransporteVolumeLacreModel.nfeTransporteVolumeModel?.numeracao ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nfe_transporte_volume_lacre";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeTransporteVolumeModelController.dispose();
		numeroController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}