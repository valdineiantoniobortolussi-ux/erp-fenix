import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/page_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';

class FolhaPppCatController extends GetxController {

	// general
	final gridColumns = folhaPppCatGridColumns();
	
	var folhaPppCatModelList = <FolhaPppCatModel>[];

	final _folhaPppCatModel = FolhaPppCatModel().obs;
	FolhaPppCatModel get folhaPppCatModel => _folhaPppCatModel.value;
	set folhaPppCatModel(value) => _folhaPppCatModel.value = value ?? FolhaPppCatModel();
	
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
		for (var folhaPppCatModel in folhaPppCatModelList) {
			plutoRowList.add(_getPlutoRow(folhaPppCatModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaPppCatModel folhaPppCatModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaPppCatModel: folhaPppCatModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaPppCatModel? folhaPppCatModel}) {
		return {
			"id": PlutoCell(value: folhaPppCatModel?.id ?? 0),
			"numeroCat": PlutoCell(value: folhaPppCatModel?.numeroCat ?? 0),
			"dataAfastamento": PlutoCell(value: folhaPppCatModel?.dataAfastamento ?? ''),
			"dataRegistro": PlutoCell(value: folhaPppCatModel?.dataRegistro ?? ''),
			"idFolhaPpp": PlutoCell(value: folhaPppCatModel?.idFolhaPpp ?? 0),
		};
	}

	void plutoRowToObject() {
		folhaPppCatModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return folhaPppCatModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroCatController.text = currentRow.cells['numeroCat']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FolhaPppCatEditPage());
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
	final numeroCatController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaPppCatModel.id;
		plutoRow.cells['idFolhaPpp']?.value = folhaPppCatModel.idFolhaPpp;
		plutoRow.cells['numeroCat']?.value = folhaPppCatModel.numeroCat;
		plutoRow.cells['dataAfastamento']?.value = Util.formatDate(folhaPppCatModel.dataAfastamento);
		plutoRow.cells['dataRegistro']?.value = Util.formatDate(folhaPppCatModel.dataRegistro);
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
		folhaPppCatModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FolhaPppCatModel();
			model.plutoRowToObject(plutoRow);
			folhaPppCatModelList.add(model);
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
		numeroCatController.dispose();
		super.onClose();
	}
}