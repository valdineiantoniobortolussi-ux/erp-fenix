import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/page_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';

class EmpresaTransporteItinerarioController extends GetxController {

	// general
	final gridColumns = empresaTransporteItinerarioGridColumns();
	
	var empresaTransporteItinerarioModelList = <EmpresaTransporteItinerarioModel>[];

	final _empresaTransporteItinerarioModel = EmpresaTransporteItinerarioModel().obs;
	EmpresaTransporteItinerarioModel get empresaTransporteItinerarioModel => _empresaTransporteItinerarioModel.value;
	set empresaTransporteItinerarioModel(value) => _empresaTransporteItinerarioModel.value = value ?? EmpresaTransporteItinerarioModel();
	
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
		for (var empresaTransporteItinerarioModel in empresaTransporteItinerarioModelList) {
			plutoRowList.add(_getPlutoRow(empresaTransporteItinerarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(EmpresaTransporteItinerarioModel empresaTransporteItinerarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(empresaTransporteItinerarioModel: empresaTransporteItinerarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ EmpresaTransporteItinerarioModel? empresaTransporteItinerarioModel}) {
		return {
			"id": PlutoCell(value: empresaTransporteItinerarioModel?.id ?? 0),
			"nome": PlutoCell(value: empresaTransporteItinerarioModel?.nome ?? ''),
			"tarifa": PlutoCell(value: empresaTransporteItinerarioModel?.tarifa ?? 0),
			"trajeto": PlutoCell(value: empresaTransporteItinerarioModel?.trajeto ?? ''),
			"idEmpresaTransporte": PlutoCell(value: empresaTransporteItinerarioModel?.idEmpresaTransporte ?? 0),
		};
	}

	void plutoRowToObject() {
		empresaTransporteItinerarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return empresaTransporteItinerarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			tarifaController.text = currentRow.cells['tarifa']?.value?.toStringAsFixed(2) ?? '';
			trajetoController.text = currentRow.cells['trajeto']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => EmpresaTransporteItinerarioEditPage());
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
	final nomeController = TextEditingController();
	final tarifaController = MoneyMaskedTextController();
	final trajetoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = empresaTransporteItinerarioModel.id;
		plutoRow.cells['idEmpresaTransporte']?.value = empresaTransporteItinerarioModel.idEmpresaTransporte;
		plutoRow.cells['nome']?.value = empresaTransporteItinerarioModel.nome;
		plutoRow.cells['tarifa']?.value = empresaTransporteItinerarioModel.tarifa;
		plutoRow.cells['trajeto']?.value = empresaTransporteItinerarioModel.trajeto;
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
		empresaTransporteItinerarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = EmpresaTransporteItinerarioModel();
			model.plutoRowToObject(plutoRow);
			empresaTransporteItinerarioModelList.add(model);
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
		nomeController.dispose();
		tarifaController.dispose();
		trajetoController.dispose();
		super.onClose();
	}
}