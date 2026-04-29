import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CteMultimodalController extends GetxController {

	// general
	final gridColumns = cteMultimodalGridColumns();
	
	var cteMultimodalModelList = <CteMultimodalModel>[];

	final _cteMultimodalModel = CteMultimodalModel().obs;
	CteMultimodalModel get cteMultimodalModel => _cteMultimodalModel.value;
	set cteMultimodalModel(value) => _cteMultimodalModel.value = value ?? CteMultimodalModel();
	
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
		for (var cteMultimodalModel in cteMultimodalModelList) {
			plutoRowList.add(_getPlutoRow(cteMultimodalModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteMultimodalModel cteMultimodalModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteMultimodalModel: cteMultimodalModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteMultimodalModel? cteMultimodalModel}) {
		return {
			"id": PlutoCell(value: cteMultimodalModel?.id ?? 0),
			"cotm": PlutoCell(value: cteMultimodalModel?.cotm ?? ''),
			"indicadorNegociavel": PlutoCell(value: cteMultimodalModel?.indicadorNegociavel ?? ''),
			"idCteCabecalho": PlutoCell(value: cteMultimodalModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteMultimodalModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteMultimodalModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cotmController.text = currentRow.cells['cotm']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteMultimodalEditPage());
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
	final cotmController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteMultimodalModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteMultimodalModel.idCteCabecalho;
		plutoRow.cells['cotm']?.value = cteMultimodalModel.cotm;
		plutoRow.cells['indicadorNegociavel']?.value = cteMultimodalModel.indicadorNegociavel;
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
		cteMultimodalModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteMultimodalModel();
			model.plutoRowToObject(plutoRow);
			cteMultimodalModelList.add(model);
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
		cotmController.dispose();
		super.onClose();
	}
}