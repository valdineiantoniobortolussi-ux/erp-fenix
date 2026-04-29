import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:ordem_servico/app/controller/controller_imports.dart';
import 'package:ordem_servico/app/routes/app_routes.dart';

import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/page/page_imports.dart';
import 'package:ordem_servico/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ordem_servico/app/page/shared_widget/message_dialog.dart';

class OsAberturaEquipamentoController extends GetxController {

	// general
	final gridColumns = osAberturaEquipamentoGridColumns();
	
	var osAberturaEquipamentoModelList = <OsAberturaEquipamentoModel>[];

	final _osAberturaEquipamentoModel = OsAberturaEquipamentoModel().obs;
	OsAberturaEquipamentoModel get osAberturaEquipamentoModel => _osAberturaEquipamentoModel.value;
	set osAberturaEquipamentoModel(value) => _osAberturaEquipamentoModel.value = value ?? OsAberturaEquipamentoModel();
	
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
		for (var osAberturaEquipamentoModel in osAberturaEquipamentoModelList) {
			plutoRowList.add(_getPlutoRow(osAberturaEquipamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(OsAberturaEquipamentoModel osAberturaEquipamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(osAberturaEquipamentoModel: osAberturaEquipamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ OsAberturaEquipamentoModel? osAberturaEquipamentoModel}) {
		return {
			"id": PlutoCell(value: osAberturaEquipamentoModel?.id ?? 0),
			"osEquipamento": PlutoCell(value: osAberturaEquipamentoModel?.osEquipamentoModel?.nome ?? ''),
			"tipoCobertura": PlutoCell(value: osAberturaEquipamentoModel?.tipoCobertura ?? ''),
			"numeroSerie": PlutoCell(value: osAberturaEquipamentoModel?.numeroSerie ?? ''),
			"idOsAbertura": PlutoCell(value: osAberturaEquipamentoModel?.idOsAbertura ?? 0),
			"idOsEquipamento": PlutoCell(value: osAberturaEquipamentoModel?.idOsEquipamento ?? 0),
		};
	}

	void plutoRowToObject() {
		osAberturaEquipamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return osAberturaEquipamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			osEquipamentoModelController.text = currentRow.cells['osEquipamento']?.value ?? '';
			numeroSerieController.text = currentRow.cells['numeroSerie']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => OsAberturaEquipamentoEditPage());
		} else {
			showInfoSnackBar(message: 'message_select_one_to_edited'.tr);
		}
	}

	void callEditPageToInsert() {
		_plutoGridStateManager.prependNewRows(); 
		final cell = _plutoGridStateManager.rows.first.cells.entries.elementAt(0).value;
		_plutoGridStateManager.setCurrentCell(cell, 0); 
		callEditPage();	 
	}

	void handleKeyboard(PlutoKeyManagerEvent event) {
		if (event.isKeyDownEvent && event.event.logicalKey.keyId == LogicalKeyboardKey.enter.keyId) {
			callEditPage();
		}
	} 

	Future delete() async {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			showDeleteDialog(() async {
				_plutoGridStateManager.removeCurrentRow();
				userMadeChanges = true;
				refreshList();
			});
		} else {
			showInfoSnackBar(message: 'message_select_one_to_delete'.tr);
		}
	}

	// edit page
	final scrollController = ScrollController();
	final osEquipamentoModelController = TextEditingController();
	final numeroSerieController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = osAberturaEquipamentoModel.id;
		plutoRow.cells['idOsAbertura']?.value = osAberturaEquipamentoModel.idOsAbertura;
		plutoRow.cells['idOsEquipamento']?.value = osAberturaEquipamentoModel.idOsEquipamento;
		plutoRow.cells['osEquipamento']?.value = osAberturaEquipamentoModel.osEquipamentoModel?.nome;
		plutoRow.cells['tipoCobertura']?.value = osAberturaEquipamentoModel.tipoCobertura;
		plutoRow.cells['numeroSerie']?.value = osAberturaEquipamentoModel.numeroSerie;
	}

	Future<void> save() async {
		final FormState form = formKey.currentState!;
		if (!form.validate()) {
			showErrorSnackBar(message: 'validator_form_message'.tr);
		} else {
			if (formWasChanged) {
				userMadeChanges = true;		 
				objectToPlutoRow();
				refreshList();
				Get.back();
			} else {
				Get.back();
			}
		}
	}

  void refreshList() {
		osAberturaEquipamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = OsAberturaEquipamentoModel();
			model.plutoRowToObject(plutoRow);
			osAberturaEquipamentoModelList.add(model);
		}
  }

	void preventDataLoss() {
		if (formWasChanged) {
			showQuestionDialog('message_data_loss'.tr, () => Get.back());
		} else {
			formWasChanged = false;
			Get.back();
		}
	}	

	Future callOsEquipamentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Equipamento]'; 
		lookupController.route = '/os-equipamento/'; 
		lookupController.gridColumns = osEquipamentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = OsEquipamentoModel.aliasColumns; 
		lookupController.dbColumns = OsEquipamentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			osAberturaEquipamentoModel.idOsEquipamento = plutoRowResult.cells['id']!.value; 
			osAberturaEquipamentoModel.osEquipamentoModel!.plutoRowToObject(plutoRowResult); 
			osEquipamentoModelController.text = osAberturaEquipamentoModel.osEquipamentoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}


	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		keyboardListener = const Stream.empty().listen((event) { });
		super.onInit();
	}

	@override
	void onClose() {
		keyboardListener.cancel();
		scrollController.dispose();		 
		osEquipamentoModelController.dispose();
		numeroSerieController.dispose();
		super.onClose();
	}
}