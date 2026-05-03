import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/routes/app_routes.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/page_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';

class RateioCentroResultadoDetController extends GetxController {

	// general
	final gridColumns = rateioCentroResultadoDetGridColumns();
	
	var rateioCentroResultadoDetModelList = <RateioCentroResultadoDetModel>[];

	final _rateioCentroResultadoDetModel = RateioCentroResultadoDetModel().obs;
	RateioCentroResultadoDetModel get rateioCentroResultadoDetModel => _rateioCentroResultadoDetModel.value;
	set rateioCentroResultadoDetModel(value) => _rateioCentroResultadoDetModel.value = value ?? RateioCentroResultadoDetModel();
	
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
		for (var rateioCentroResultadoDetModel in rateioCentroResultadoDetModelList) {
			plutoRowList.add(_getPlutoRow(rateioCentroResultadoDetModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(RateioCentroResultadoDetModel rateioCentroResultadoDetModel) {
		return PlutoRow(
			cells: _getPlutoCells(rateioCentroResultadoDetModel: rateioCentroResultadoDetModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ RateioCentroResultadoDetModel? rateioCentroResultadoDetModel}) {
		return {
			"id": PlutoCell(value: rateioCentroResultadoDetModel?.id ?? 0),
			"centroResultado": PlutoCell(value: rateioCentroResultadoDetModel?.centroResultadoModel?.descricao ?? ''),
			"porcentoRateio": PlutoCell(value: rateioCentroResultadoDetModel?.porcentoRateio ?? 0),
			"idRateioCentroResulCab": PlutoCell(value: rateioCentroResultadoDetModel?.idRateioCentroResulCab ?? 0),
			"idCentroResultadoDestino": PlutoCell(value: rateioCentroResultadoDetModel?.idCentroResultadoDestino ?? 0),
		};
	}

	void plutoRowToObject() {
		rateioCentroResultadoDetModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return rateioCentroResultadoDetModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			centroResultadoModelController.text = currentRow.cells['centroResultado']?.value ?? '';
			porcentoRateioController.text = currentRow.cells['porcentoRateio']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => RateioCentroResultadoDetEditPage());
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
	final centroResultadoModelController = TextEditingController();
	final porcentoRateioController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = rateioCentroResultadoDetModel.id;
		plutoRow.cells['idRateioCentroResulCab']?.value = rateioCentroResultadoDetModel.idRateioCentroResulCab;
		plutoRow.cells['idCentroResultadoDestino']?.value = rateioCentroResultadoDetModel.idCentroResultadoDestino;
		plutoRow.cells['centroResultado']?.value = rateioCentroResultadoDetModel.centroResultadoModel?.descricao;
		plutoRow.cells['porcentoRateio']?.value = rateioCentroResultadoDetModel.porcentoRateio;
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
		rateioCentroResultadoDetModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = RateioCentroResultadoDetModel();
			model.plutoRowToObject(plutoRow);
			rateioCentroResultadoDetModelList.add(model);
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

	Future callCentroResultadoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Centro Resultado Destino]'; 
		lookupController.route = '/centro-resultado/'; 
		lookupController.gridColumns = centroResultadoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = CentroResultadoModel.aliasColumns; 
		lookupController.dbColumns = CentroResultadoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			rateioCentroResultadoDetModel.idCentroResultadoDestino = plutoRowResult.cells['id']!.value; 
			rateioCentroResultadoDetModel.centroResultadoModel!.plutoRowToObject(plutoRowResult); 
			centroResultadoModelController.text = rateioCentroResultadoDetModel.centroResultadoModel?.descricao ?? ''; 
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
		centroResultadoModelController.dispose();
		porcentoRateioController.dispose();
		super.onClose();
	}
}