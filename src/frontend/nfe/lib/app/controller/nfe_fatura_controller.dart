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

class NfeFaturaController extends GetxController {

	// general
	final gridColumns = nfeFaturaGridColumns();
	
	var nfeFaturaModelList = <NfeFaturaModel>[];

	final _nfeFaturaModel = NfeFaturaModel().obs;
	NfeFaturaModel get nfeFaturaModel => _nfeFaturaModel.value;
	set nfeFaturaModel(value) => _nfeFaturaModel.value = value ?? NfeFaturaModel();
	
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
		for (var nfeFaturaModel in nfeFaturaModelList) {
			plutoRowList.add(_getPlutoRow(nfeFaturaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeFaturaModel nfeFaturaModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeFaturaModel: nfeFaturaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeFaturaModel? nfeFaturaModel}) {
		return {
			"id": PlutoCell(value: nfeFaturaModel?.id ?? 0),
			"numero": PlutoCell(value: nfeFaturaModel?.numero ?? ''),
			"valorOriginal": PlutoCell(value: nfeFaturaModel?.valorOriginal ?? 0),
			"valorDesconto": PlutoCell(value: nfeFaturaModel?.valorDesconto ?? 0),
			"valorLiquido": PlutoCell(value: nfeFaturaModel?.valorLiquido ?? 0),
			"idNfeCabecalho": PlutoCell(value: nfeFaturaModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeFaturaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeFaturaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			valorOriginalController.text = currentRow.cells['valorOriginal']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorLiquidoController.text = currentRow.cells['valorLiquido']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeFaturaEditPage());
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
	final valorOriginalController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorLiquidoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeFaturaModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeFaturaModel.idNfeCabecalho;
		plutoRow.cells['numero']?.value = nfeFaturaModel.numero;
		plutoRow.cells['valorOriginal']?.value = nfeFaturaModel.valorOriginal;
		plutoRow.cells['valorDesconto']?.value = nfeFaturaModel.valorDesconto;
		plutoRow.cells['valorLiquido']?.value = nfeFaturaModel.valorLiquido;
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
		nfeFaturaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeFaturaModel();
			model.plutoRowToObject(plutoRow);
			nfeFaturaModelList.add(model);
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
		valorOriginalController.dispose();
		valorDescontoController.dispose();
		valorLiquidoController.dispose();
		super.onClose();
	}
}