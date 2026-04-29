import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeDetalheImpostoIiController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoIiGridColumns();
	
	var nfeDetalheImpostoIiModelList = <NfeDetalheImpostoIiModel>[];

	final _nfeDetalheImpostoIiModel = NfeDetalheImpostoIiModel().obs;
	NfeDetalheImpostoIiModel get nfeDetalheImpostoIiModel => _nfeDetalheImpostoIiModel.value;
	set nfeDetalheImpostoIiModel(value) => _nfeDetalheImpostoIiModel.value = value ?? NfeDetalheImpostoIiModel();
	
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
		for (var nfeDetalheImpostoIiModel in nfeDetalheImpostoIiModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoIiModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoIiModel nfeDetalheImpostoIiModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoIiModel: nfeDetalheImpostoIiModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoIiModel? nfeDetalheImpostoIiModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoIiModel?.id ?? 0),
			"valorBcIi": PlutoCell(value: nfeDetalheImpostoIiModel?.valorBcIi ?? 0),
			"valorDespesasAduaneiras": PlutoCell(value: nfeDetalheImpostoIiModel?.valorDespesasAduaneiras ?? 0),
			"valorImpostoImportacao": PlutoCell(value: nfeDetalheImpostoIiModel?.valorImpostoImportacao ?? 0),
			"valorIof": PlutoCell(value: nfeDetalheImpostoIiModel?.valorIof ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoIiModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoIiModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoIiModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorBcIiController.text = currentRow.cells['valorBcIi']?.value?.toStringAsFixed(2) ?? '';
			valorDespesasAduaneirasController.text = currentRow.cells['valorDespesasAduaneiras']?.value?.toStringAsFixed(2) ?? '';
			valorImpostoImportacaoController.text = currentRow.cells['valorImpostoImportacao']?.value?.toStringAsFixed(2) ?? '';
			valorIofController.text = currentRow.cells['valorIof']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoIiEditPage());
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
	final valorBcIiController = MoneyMaskedTextController();
	final valorDespesasAduaneirasController = MoneyMaskedTextController();
	final valorImpostoImportacaoController = MoneyMaskedTextController();
	final valorIofController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoIiModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoIiModel.idNfeDetalhe;
		plutoRow.cells['valorBcIi']?.value = nfeDetalheImpostoIiModel.valorBcIi;
		plutoRow.cells['valorDespesasAduaneiras']?.value = nfeDetalheImpostoIiModel.valorDespesasAduaneiras;
		plutoRow.cells['valorImpostoImportacao']?.value = nfeDetalheImpostoIiModel.valorImpostoImportacao;
		plutoRow.cells['valorIof']?.value = nfeDetalheImpostoIiModel.valorIof;
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
		nfeDetalheImpostoIiModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoIiModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoIiModelList.add(model);
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
		valorBcIiController.dispose();
		valorDespesasAduaneirasController.dispose();
		valorImpostoImportacaoController.dispose();
		valorIofController.dispose();
		super.onClose();
	}
}