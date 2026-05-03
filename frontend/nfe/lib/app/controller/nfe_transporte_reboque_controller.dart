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
import 'package:nfe/app/data/repository/nfe_transporte_reboque_repository.dart';
import 'package:nfe/app/page/shared_page/shared_page_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';
import 'package:nfe/app/mixin/controller_base_mixin.dart';

class NfeTransporteReboqueController extends GetxController with ControllerBaseMixin {
  final NfeTransporteReboqueRepository nfeTransporteReboqueRepository;
  NfeTransporteReboqueController({required this.nfeTransporteReboqueRepository});

  // general
  final _dbColumns = NfeTransporteReboqueModel.dbColumns;
  get dbColumns => _dbColumns;

  final _aliasColumns = NfeTransporteReboqueModel.aliasColumns;
  get aliasColumns => _aliasColumns;

  final gridColumns = nfeTransporteReboqueGridColumns();
  
  var _nfeTransporteReboqueModelList = <NfeTransporteReboqueModel>[];

  final _nfeTransporteReboqueModel = NfeTransporteReboqueModel().obs;
  NfeTransporteReboqueModel get nfeTransporteReboqueModel => _nfeTransporteReboqueModel.value;
  set nfeTransporteReboqueModel(value) => _nfeTransporteReboqueModel.value = value ?? NfeTransporteReboqueModel();

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
    for (var nfeTransporteReboqueModel in _nfeTransporteReboqueModelList) {
      plutoRowList.add(_getPlutoRow(nfeTransporteReboqueModel));
    }
    return plutoRowList;
  }

  PlutoRow _getPlutoRow(NfeTransporteReboqueModel nfeTransporteReboqueModel) {
    return PlutoRow(
      cells: _getPlutoCells(nfeTransporteReboqueModel: nfeTransporteReboqueModel),
    );
  }

  Map<String, PlutoCell> _getPlutoCells({ NfeTransporteReboqueModel? nfeTransporteReboqueModel}) {
    return {
			"id": PlutoCell(value: nfeTransporteReboqueModel?.id ?? 0),
			"nfeTransporte": PlutoCell(value: nfeTransporteReboqueModel?.nfeTransporteModel?.cnpj ?? ''),
			"placa": PlutoCell(value: nfeTransporteReboqueModel?.placa ?? ''),
			"uf": PlutoCell(value: nfeTransporteReboqueModel?.uf ?? ''),
			"rntc": PlutoCell(value: nfeTransporteReboqueModel?.rntc ?? ''),
			"vagao": PlutoCell(value: nfeTransporteReboqueModel?.vagao ?? ''),
			"balsa": PlutoCell(value: nfeTransporteReboqueModel?.balsa ?? ''),
			"idNfeTransporte": PlutoCell(value: nfeTransporteReboqueModel?.idNfeTransporte ?? 0),
    };
  }

  void plutoRowToObject() {
    final modelFromRow = _nfeTransporteReboqueModelList.where( ((t) => t.id == plutoRow.cells['id']!.value) ).toList();
    if (modelFromRow.isEmpty) {
      nfeTransporteReboqueModel.plutoRowToObject(plutoRow);
    } else {
      nfeTransporteReboqueModel = modelFromRow[0];
    }
  }

  Future callFilter() async {
    final filterController = Get.find<FilterController>();
    filterController.title = '${'filter_page_title'.tr} [Nfe Transporte Reboque]';
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
    await Get.find<NfeTransporteReboqueController>().getList(filter: filter);
    _plutoGridStateManager.appendRows(plutoRows());
    _plutoGridStateManager.setShowLoading(false);
  }

  Future getList({Filter? filter}) async {
    await nfeTransporteReboqueRepository.getList(filter: filter).then( (data){ _nfeTransporteReboqueModelList = data; } );
  }

  void printReport() {
    Get.dialog(AlertDialog(
      content: ReportPage(
        title: 'Nfe Transporte Reboque',
        columns: gridColumns.map((column) => column.title).toList(),
        plutoRows: plutoRows(),
      ),
    ));
  }

  void callEditPage() {
    final currentRow = _plutoGridStateManager.currentRow;
    if (currentRow != null) {
			nfeTransporteModelController.text = currentRow.cells['nfeTransporte']?.value ?? '';
			placaController.text = currentRow.cells['placa']?.value ?? '';
			rntcController.text = currentRow.cells['rntc']?.value ?? '';
			vagaoController.text = currentRow.cells['vagao']?.value ?? '';
			balsaController.text = currentRow.cells['balsa']?.value ?? '';

      plutoRow = currentRow;
      formWasChanged = false;
      plutoRowToObject();
      Get.toNamed(Routes.nfeTransporteReboqueEditPage)!.then((value) {
        if (nfeTransporteReboqueModel.id == 0) {
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
    nfeTransporteReboqueModel = NfeTransporteReboqueModel();
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
        if (await nfeTransporteReboqueRepository.delete(id: currentRow.cells['id']!.value)) {
          _nfeTransporteReboqueModelList.removeWhere( ((t) => t.id == currentRow.cells['id']!.value) );
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
	final nfeTransporteModelController = TextEditingController();
	final placaController = TextEditingController();
	final rntcController = TextEditingController();
	final vagaoController = TextEditingController();
	final balsaController = TextEditingController();

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeTransporteReboqueModel.id;
		plutoRow.cells['idNfeTransporte']?.value = nfeTransporteReboqueModel.idNfeTransporte;
		plutoRow.cells['nfeTransporte']?.value = nfeTransporteReboqueModel.nfeTransporteModel?.cnpj;
		plutoRow.cells['placa']?.value = nfeTransporteReboqueModel.placa;
		plutoRow.cells['uf']?.value = nfeTransporteReboqueModel.uf;
		plutoRow.cells['rntc']?.value = nfeTransporteReboqueModel.rntc;
		plutoRow.cells['vagao']?.value = nfeTransporteReboqueModel.vagao;
		plutoRow.cells['balsa']?.value = nfeTransporteReboqueModel.balsa;
  }

  Future<void> save() async {
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      if (formWasChanged) {
        final result = await nfeTransporteReboqueRepository.save(nfeTransporteReboqueModel: nfeTransporteReboqueModel); 
        if (result != null) {
          nfeTransporteReboqueModel = result;
          if (_isInserting) {
            _nfeTransporteReboqueModelList.add(result);
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

	Future callNfeTransporteLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Nfe Transporte]'; 
		lookupController.route = '/nfe-transporte/'; 
		lookupController.gridColumns = nfeTransporteGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfeTransporteModel.aliasColumns; 
		lookupController.dbColumns = NfeTransporteModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfeTransporteReboqueModel.idNfeTransporte = plutoRowResult.cells['id']!.value; 
			nfeTransporteReboqueModel.nfeTransporteModel!.plutoRowToObject(plutoRowResult); 
			nfeTransporteModelController.text = nfeTransporteReboqueModel.nfeTransporteModel?.cnpj ?? ''; 
			formWasChanged = true; 
		}
	}


  // override
  @override
  void onInit() {
    bootstrapGridParameters(
      gutterSize: Constants.flutterBootstrapGutterSize,
    );
		functionName = "nfe_transporte_reboque";
    setPrivilege();		
    super.onInit();
  }

  @override
  void onClose() {
		nfeTransporteModelController.dispose();
		placaController.dispose();
		rntcController.dispose();
		vagaoController.dispose();
		balsaController.dispose();
    keyboardListener.cancel();
    scrollController.dispose(); 
    super.onClose();
  }
}