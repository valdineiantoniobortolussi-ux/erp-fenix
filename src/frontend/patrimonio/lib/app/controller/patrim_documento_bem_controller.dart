import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/page_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';

class PatrimDocumentoBemController extends GetxController {

	// general
	final gridColumns = patrimDocumentoBemGridColumns();
	
	var patrimDocumentoBemModelList = <PatrimDocumentoBemModel>[];

	final _patrimDocumentoBemModel = PatrimDocumentoBemModel().obs;
	PatrimDocumentoBemModel get patrimDocumentoBemModel => _patrimDocumentoBemModel.value;
	set patrimDocumentoBemModel(value) => _patrimDocumentoBemModel.value = value ?? PatrimDocumentoBemModel();
	
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
		for (var patrimDocumentoBemModel in patrimDocumentoBemModelList) {
			plutoRowList.add(_getPlutoRow(patrimDocumentoBemModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PatrimDocumentoBemModel patrimDocumentoBemModel) {
		return PlutoRow(
			cells: _getPlutoCells(patrimDocumentoBemModel: patrimDocumentoBemModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PatrimDocumentoBemModel? patrimDocumentoBemModel}) {
		return {
			"id": PlutoCell(value: patrimDocumentoBemModel?.id ?? 0),
			"nome": PlutoCell(value: patrimDocumentoBemModel?.nome ?? ''),
			"descricao": PlutoCell(value: patrimDocumentoBemModel?.descricao ?? ''),
			"imagem": PlutoCell(value: patrimDocumentoBemModel?.imagem ?? ''),
			"idPatrimBem": PlutoCell(value: patrimDocumentoBemModel?.idPatrimBem ?? 0),
		};
	}

	void plutoRowToObject() {
		patrimDocumentoBemModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return patrimDocumentoBemModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			imagemController.text = currentRow.cells['imagem']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PatrimDocumentoBemEditPage());
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
	final descricaoController = TextEditingController();
	final imagemController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimDocumentoBemModel.id;
		plutoRow.cells['idPatrimBem']?.value = patrimDocumentoBemModel.idPatrimBem;
		plutoRow.cells['nome']?.value = patrimDocumentoBemModel.nome;
		plutoRow.cells['descricao']?.value = patrimDocumentoBemModel.descricao;
		plutoRow.cells['imagem']?.value = patrimDocumentoBemModel.imagem;
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
		patrimDocumentoBemModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PatrimDocumentoBemModel();
			model.plutoRowToObject(plutoRow);
			patrimDocumentoBemModelList.add(model);
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
		descricaoController.dispose();
		imagemController.dispose();
		super.onClose();
	}
}