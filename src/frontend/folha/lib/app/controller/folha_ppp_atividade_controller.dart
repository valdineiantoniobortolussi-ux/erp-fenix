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

class FolhaPppAtividadeController extends GetxController {

	// general
	final gridColumns = folhaPppAtividadeGridColumns();
	
	var folhaPppAtividadeModelList = <FolhaPppAtividadeModel>[];

	final _folhaPppAtividadeModel = FolhaPppAtividadeModel().obs;
	FolhaPppAtividadeModel get folhaPppAtividadeModel => _folhaPppAtividadeModel.value;
	set folhaPppAtividadeModel(value) => _folhaPppAtividadeModel.value = value ?? FolhaPppAtividadeModel();
	
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
		for (var folhaPppAtividadeModel in folhaPppAtividadeModelList) {
			plutoRowList.add(_getPlutoRow(folhaPppAtividadeModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaPppAtividadeModel folhaPppAtividadeModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaPppAtividadeModel: folhaPppAtividadeModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaPppAtividadeModel? folhaPppAtividadeModel}) {
		return {
			"id": PlutoCell(value: folhaPppAtividadeModel?.id ?? 0),
			"dataInicio": PlutoCell(value: folhaPppAtividadeModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: folhaPppAtividadeModel?.dataFim ?? ''),
			"descricao": PlutoCell(value: folhaPppAtividadeModel?.descricao ?? ''),
			"idFolhaPpp": PlutoCell(value: folhaPppAtividadeModel?.idFolhaPpp ?? 0),
		};
	}

	void plutoRowToObject() {
		folhaPppAtividadeModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return folhaPppAtividadeModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FolhaPppAtividadeEditPage());
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
	final descricaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaPppAtividadeModel.id;
		plutoRow.cells['idFolhaPpp']?.value = folhaPppAtividadeModel.idFolhaPpp;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(folhaPppAtividadeModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(folhaPppAtividadeModel.dataFim);
		plutoRow.cells['descricao']?.value = folhaPppAtividadeModel.descricao;
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
		folhaPppAtividadeModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FolhaPppAtividadeModel();
			model.plutoRowToObject(plutoRow);
			folhaPppAtividadeModelList.add(model);
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
		descricaoController.dispose();
		super.onClose();
	}
}