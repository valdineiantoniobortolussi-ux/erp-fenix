import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/page_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';

class ChequeController extends GetxController {

	// general
	final gridColumns = chequeGridColumns();
	
	var chequeModelList = <ChequeModel>[];

	final _chequeModel = ChequeModel().obs;
	ChequeModel get chequeModel => _chequeModel.value;
	set chequeModel(value) => _chequeModel.value = value ?? ChequeModel();
	
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
		for (var chequeModel in chequeModelList) {
			plutoRowList.add(_getPlutoRow(chequeModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ChequeModel chequeModel) {
		return PlutoRow(
			cells: _getPlutoCells(chequeModel: chequeModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ChequeModel? chequeModel}) {
		return {
			"id": PlutoCell(value: chequeModel?.id ?? 0),
			"numero": PlutoCell(value: chequeModel?.numero ?? 0),
			"statusCheque": PlutoCell(value: chequeModel?.statusCheque ?? ''),
			"dataStatus": PlutoCell(value: chequeModel?.dataStatus ?? ''),
			"idTalonarioCheque": PlutoCell(value: chequeModel?.idTalonarioCheque ?? 0),
		};
	}

	void plutoRowToObject() {
		chequeModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return chequeModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ChequeEditPage());
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
	final numeroController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = chequeModel.id;
		plutoRow.cells['idTalonarioCheque']?.value = chequeModel.idTalonarioCheque;
		plutoRow.cells['numero']?.value = chequeModel.numero;
		plutoRow.cells['statusCheque']?.value = chequeModel.statusCheque;
		plutoRow.cells['dataStatus']?.value = Util.formatDate(chequeModel.dataStatus);
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
		chequeModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ChequeModel();
			model.plutoRowToObject(plutoRow);
			chequeModelList.add(model);
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
		numeroController.dispose();
		super.onClose();
	}
}