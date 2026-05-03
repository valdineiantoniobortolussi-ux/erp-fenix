import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CteDutoviarioController extends GetxController {

	// general
	final gridColumns = cteDutoviarioGridColumns();
	
	var cteDutoviarioModelList = <CteDutoviarioModel>[];

	final _cteDutoviarioModel = CteDutoviarioModel().obs;
	CteDutoviarioModel get cteDutoviarioModel => _cteDutoviarioModel.value;
	set cteDutoviarioModel(value) => _cteDutoviarioModel.value = value ?? CteDutoviarioModel();
	
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
		for (var cteDutoviarioModel in cteDutoviarioModelList) {
			plutoRowList.add(_getPlutoRow(cteDutoviarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteDutoviarioModel cteDutoviarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteDutoviarioModel: cteDutoviarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteDutoviarioModel? cteDutoviarioModel}) {
		return {
			"id": PlutoCell(value: cteDutoviarioModel?.id ?? 0),
			"valorTarifa": PlutoCell(value: cteDutoviarioModel?.valorTarifa ?? 0),
			"dataInicio": PlutoCell(value: cteDutoviarioModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: cteDutoviarioModel?.dataFim ?? ''),
			"idCteCabecalho": PlutoCell(value: cteDutoviarioModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteDutoviarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteDutoviarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorTarifaController.text = currentRow.cells['valorTarifa']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteDutoviarioEditPage());
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
	final valorTarifaController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteDutoviarioModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteDutoviarioModel.idCteCabecalho;
		plutoRow.cells['valorTarifa']?.value = cteDutoviarioModel.valorTarifa;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(cteDutoviarioModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(cteDutoviarioModel.dataFim);
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
		cteDutoviarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteDutoviarioModel();
			model.plutoRowToObject(plutoRow);
			cteDutoviarioModelList.add(model);
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
		valorTarifaController.dispose();
		super.onClose();
	}
}