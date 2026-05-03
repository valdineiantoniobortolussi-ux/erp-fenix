import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeCanaController extends GetxController {

	// general
	final gridColumns = nfeCanaGridColumns();
	
	var nfeCanaModelList = <NfeCanaModel>[];

	final _nfeCanaModel = NfeCanaModel().obs;
	NfeCanaModel get nfeCanaModel => _nfeCanaModel.value;
	set nfeCanaModel(value) => _nfeCanaModel.value = value ?? NfeCanaModel();
	
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
		for (var nfeCanaModel in nfeCanaModelList) {
			plutoRowList.add(_getPlutoRow(nfeCanaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeCanaModel nfeCanaModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeCanaModel: nfeCanaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeCanaModel? nfeCanaModel}) {
		return {
			"id": PlutoCell(value: nfeCanaModel?.id ?? 0),
			"safra": PlutoCell(value: nfeCanaModel?.safra ?? ''),
			"mesAnoReferencia": PlutoCell(value: nfeCanaModel?.mesAnoReferencia ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeCanaModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeCanaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeCanaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			safraController.text = currentRow.cells['safra']?.value ?? '';
			mesAnoReferenciaController.text = currentRow.cells['mesAnoReferencia']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeCanaEditPage());
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
	final safraController = TextEditingController();
	final mesAnoReferenciaController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeCanaModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeCanaModel.idNfeCabecalho;
		plutoRow.cells['safra']?.value = nfeCanaModel.safra;
		plutoRow.cells['mesAnoReferencia']?.value = nfeCanaModel.mesAnoReferencia;
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
		nfeCanaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeCanaModel();
			model.plutoRowToObject(plutoRow);
			nfeCanaModelList.add(model);
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
		safraController.dispose();
		mesAnoReferenciaController.dispose();
		super.onClose();
	}
}