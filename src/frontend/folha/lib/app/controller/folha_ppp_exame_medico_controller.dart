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

class FolhaPppExameMedicoController extends GetxController {

	// general
	final gridColumns = folhaPppExameMedicoGridColumns();
	
	var folhaPppExameMedicoModelList = <FolhaPppExameMedicoModel>[];

	final _folhaPppExameMedicoModel = FolhaPppExameMedicoModel().obs;
	FolhaPppExameMedicoModel get folhaPppExameMedicoModel => _folhaPppExameMedicoModel.value;
	set folhaPppExameMedicoModel(value) => _folhaPppExameMedicoModel.value = value ?? FolhaPppExameMedicoModel();
	
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
		for (var folhaPppExameMedicoModel in folhaPppExameMedicoModelList) {
			plutoRowList.add(_getPlutoRow(folhaPppExameMedicoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaPppExameMedicoModel folhaPppExameMedicoModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaPppExameMedicoModel: folhaPppExameMedicoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaPppExameMedicoModel? folhaPppExameMedicoModel}) {
		return {
			"id": PlutoCell(value: folhaPppExameMedicoModel?.id ?? 0),
			"dataUltimo": PlutoCell(value: folhaPppExameMedicoModel?.dataUltimo ?? ''),
			"tipo": PlutoCell(value: folhaPppExameMedicoModel?.tipo ?? ''),
			"exame": PlutoCell(value: folhaPppExameMedicoModel?.exame ?? ''),
			"natureza": PlutoCell(value: folhaPppExameMedicoModel?.natureza ?? ''),
			"indicacaoResultados": PlutoCell(value: folhaPppExameMedicoModel?.indicacaoResultados ?? ''),
			"idFolhaPpp": PlutoCell(value: folhaPppExameMedicoModel?.idFolhaPpp ?? 0),
		};
	}

	void plutoRowToObject() {
		folhaPppExameMedicoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return folhaPppExameMedicoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			naturezaController.text = currentRow.cells['natureza']?.value ?? '';
			indicacaoResultadosController.text = currentRow.cells['indicacaoResultados']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FolhaPppExameMedicoEditPage());
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
	final naturezaController = TextEditingController();
	final indicacaoResultadosController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaPppExameMedicoModel.id;
		plutoRow.cells['idFolhaPpp']?.value = folhaPppExameMedicoModel.idFolhaPpp;
		plutoRow.cells['dataUltimo']?.value = Util.formatDate(folhaPppExameMedicoModel.dataUltimo);
		plutoRow.cells['tipo']?.value = folhaPppExameMedicoModel.tipo;
		plutoRow.cells['exame']?.value = folhaPppExameMedicoModel.exame;
		plutoRow.cells['natureza']?.value = folhaPppExameMedicoModel.natureza;
		plutoRow.cells['indicacaoResultados']?.value = folhaPppExameMedicoModel.indicacaoResultados;
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
		folhaPppExameMedicoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FolhaPppExameMedicoModel();
			model.plutoRowToObject(plutoRow);
			folhaPppExameMedicoModelList.add(model);
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
		naturezaController.dispose();
		indicacaoResultadosController.dispose();
		super.onClose();
	}
}