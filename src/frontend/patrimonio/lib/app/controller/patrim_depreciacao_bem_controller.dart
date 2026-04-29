import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/page_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';

class PatrimDepreciacaoBemController extends GetxController {

	// general
	final gridColumns = patrimDepreciacaoBemGridColumns();
	
	var patrimDepreciacaoBemModelList = <PatrimDepreciacaoBemModel>[];

	final _patrimDepreciacaoBemModel = PatrimDepreciacaoBemModel().obs;
	PatrimDepreciacaoBemModel get patrimDepreciacaoBemModel => _patrimDepreciacaoBemModel.value;
	set patrimDepreciacaoBemModel(value) => _patrimDepreciacaoBemModel.value = value ?? PatrimDepreciacaoBemModel();
	
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
		for (var patrimDepreciacaoBemModel in patrimDepreciacaoBemModelList) {
			plutoRowList.add(_getPlutoRow(patrimDepreciacaoBemModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PatrimDepreciacaoBemModel patrimDepreciacaoBemModel) {
		return PlutoRow(
			cells: _getPlutoCells(patrimDepreciacaoBemModel: patrimDepreciacaoBemModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PatrimDepreciacaoBemModel? patrimDepreciacaoBemModel}) {
		return {
			"id": PlutoCell(value: patrimDepreciacaoBemModel?.id ?? 0),
			"dataDepreciacao": PlutoCell(value: patrimDepreciacaoBemModel?.dataDepreciacao ?? ''),
			"dias": PlutoCell(value: patrimDepreciacaoBemModel?.dias ?? 0),
			"taxa": PlutoCell(value: patrimDepreciacaoBemModel?.taxa ?? 0),
			"indice": PlutoCell(value: patrimDepreciacaoBemModel?.indice ?? 0),
			"valor": PlutoCell(value: patrimDepreciacaoBemModel?.valor ?? 0),
			"depreciacaoAcumulada": PlutoCell(value: patrimDepreciacaoBemModel?.depreciacaoAcumulada ?? 0),
			"idPatrimBem": PlutoCell(value: patrimDepreciacaoBemModel?.idPatrimBem ?? 0),
		};
	}

	void plutoRowToObject() {
		patrimDepreciacaoBemModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return patrimDepreciacaoBemModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			diasController.text = currentRow.cells['dias']?.value?.toString() ?? '';
			taxaController.text = currentRow.cells['taxa']?.value?.toStringAsFixed(2) ?? '';
			indiceController.text = currentRow.cells['indice']?.value?.toStringAsFixed(2) ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			depreciacaoAcumuladaController.text = currentRow.cells['depreciacaoAcumulada']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PatrimDepreciacaoBemEditPage());
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
	final diasController = TextEditingController();
	final taxaController = MoneyMaskedTextController();
	final indiceController = MoneyMaskedTextController();
	final valorController = MoneyMaskedTextController();
	final depreciacaoAcumuladaController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimDepreciacaoBemModel.id;
		plutoRow.cells['idPatrimBem']?.value = patrimDepreciacaoBemModel.idPatrimBem;
		plutoRow.cells['dataDepreciacao']?.value = Util.formatDate(patrimDepreciacaoBemModel.dataDepreciacao);
		plutoRow.cells['dias']?.value = patrimDepreciacaoBemModel.dias;
		plutoRow.cells['taxa']?.value = patrimDepreciacaoBemModel.taxa;
		plutoRow.cells['indice']?.value = patrimDepreciacaoBemModel.indice;
		plutoRow.cells['valor']?.value = patrimDepreciacaoBemModel.valor;
		plutoRow.cells['depreciacaoAcumulada']?.value = patrimDepreciacaoBemModel.depreciacaoAcumulada;
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
		patrimDepreciacaoBemModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PatrimDepreciacaoBemModel();
			model.plutoRowToObject(plutoRow);
			patrimDepreciacaoBemModelList.add(model);
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
		diasController.dispose();
		taxaController.dispose();
		indiceController.dispose();
		valorController.dispose();
		depreciacaoAcumuladaController.dispose();
		super.onClose();
	}
}