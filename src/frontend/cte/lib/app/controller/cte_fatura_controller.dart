import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CteFaturaController extends GetxController {

	// general
	final gridColumns = cteFaturaGridColumns();
	
	var cteFaturaModelList = <CteFaturaModel>[];

	final _cteFaturaModel = CteFaturaModel().obs;
	CteFaturaModel get cteFaturaModel => _cteFaturaModel.value;
	set cteFaturaModel(value) => _cteFaturaModel.value = value ?? CteFaturaModel();
	
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
		for (var cteFaturaModel in cteFaturaModelList) {
			plutoRowList.add(_getPlutoRow(cteFaturaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteFaturaModel cteFaturaModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteFaturaModel: cteFaturaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteFaturaModel? cteFaturaModel}) {
		return {
			"id": PlutoCell(value: cteFaturaModel?.id ?? 0),
			"numero": PlutoCell(value: cteFaturaModel?.numero ?? ''),
			"valorOriginal": PlutoCell(value: cteFaturaModel?.valorOriginal ?? 0),
			"valorDesconto": PlutoCell(value: cteFaturaModel?.valorDesconto ?? 0),
			"valorLiquido": PlutoCell(value: cteFaturaModel?.valorLiquido ?? 0),
			"idCteCabecalho": PlutoCell(value: cteFaturaModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteFaturaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteFaturaModelList;
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
			Get.to(() => CteFaturaEditPage());
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
		plutoRow.cells['id']?.value = cteFaturaModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteFaturaModel.idCteCabecalho;
		plutoRow.cells['numero']?.value = cteFaturaModel.numero;
		plutoRow.cells['valorOriginal']?.value = cteFaturaModel.valorOriginal;
		plutoRow.cells['valorDesconto']?.value = cteFaturaModel.valorDesconto;
		plutoRow.cells['valorLiquido']?.value = cteFaturaModel.valorLiquido;
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
		cteFaturaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteFaturaModel();
			model.plutoRowToObject(plutoRow);
			cteFaturaModelList.add(model);
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