import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/page/page_imports.dart';
import 'package:mdfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';

class MdfeRodoviarioController extends GetxController {

	// general
	final gridColumns = mdfeRodoviarioGridColumns();
	
	var mdfeRodoviarioModelList = <MdfeRodoviarioModel>[];

	final _mdfeRodoviarioModel = MdfeRodoviarioModel().obs;
	MdfeRodoviarioModel get mdfeRodoviarioModel => _mdfeRodoviarioModel.value;
	set mdfeRodoviarioModel(value) => _mdfeRodoviarioModel.value = value ?? MdfeRodoviarioModel();
	
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
		for (var mdfeRodoviarioModel in mdfeRodoviarioModelList) {
			plutoRowList.add(_getPlutoRow(mdfeRodoviarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(MdfeRodoviarioModel mdfeRodoviarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(mdfeRodoviarioModel: mdfeRodoviarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ MdfeRodoviarioModel? mdfeRodoviarioModel}) {
		return {
			"id": PlutoCell(value: mdfeRodoviarioModel?.id ?? 0),
			"rntrc": PlutoCell(value: mdfeRodoviarioModel?.rntrc ?? ''),
			"codigoAgendamento": PlutoCell(value: mdfeRodoviarioModel?.codigoAgendamento ?? ''),
			"idMdfeCabecalho": PlutoCell(value: mdfeRodoviarioModel?.idMdfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		mdfeRodoviarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return mdfeRodoviarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			rntrcController.text = currentRow.cells['rntrc']?.value ?? '';
			codigoAgendamentoController.text = currentRow.cells['codigoAgendamento']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => MdfeRodoviarioEditPage());
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
	final rntrcController = TextEditingController();
	final codigoAgendamentoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeRodoviarioModel.id;
		plutoRow.cells['idMdfeCabecalho']?.value = mdfeRodoviarioModel.idMdfeCabecalho;
		plutoRow.cells['rntrc']?.value = mdfeRodoviarioModel.rntrc;
		plutoRow.cells['codigoAgendamento']?.value = mdfeRodoviarioModel.codigoAgendamento;
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
		mdfeRodoviarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = MdfeRodoviarioModel();
			model.plutoRowToObject(plutoRow);
			mdfeRodoviarioModelList.add(model);
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
		rntrcController.dispose();
		codigoAgendamentoController.dispose();
		super.onClose();
	}
}