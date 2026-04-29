import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/page/page_imports.dart';
import 'package:vendas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:vendas/app/page/shared_widget/message_dialog.dart';

class VendaCondicoesParcelasController extends GetxController {

	// general
	final gridColumns = vendaCondicoesParcelasGridColumns();
	
	var vendaCondicoesParcelasModelList = <VendaCondicoesParcelasModel>[];

	final _vendaCondicoesParcelasModel = VendaCondicoesParcelasModel().obs;
	VendaCondicoesParcelasModel get vendaCondicoesParcelasModel => _vendaCondicoesParcelasModel.value;
	set vendaCondicoesParcelasModel(value) => _vendaCondicoesParcelasModel.value = value ?? VendaCondicoesParcelasModel();
	
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
		for (var vendaCondicoesParcelasModel in vendaCondicoesParcelasModelList) {
			plutoRowList.add(_getPlutoRow(vendaCondicoesParcelasModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(VendaCondicoesParcelasModel vendaCondicoesParcelasModel) {
		return PlutoRow(
			cells: _getPlutoCells(vendaCondicoesParcelasModel: vendaCondicoesParcelasModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ VendaCondicoesParcelasModel? vendaCondicoesParcelasModel}) {
		return {
			"id": PlutoCell(value: vendaCondicoesParcelasModel?.id ?? 0),
			"parcela": PlutoCell(value: vendaCondicoesParcelasModel?.parcela ?? 0),
			"dias": PlutoCell(value: vendaCondicoesParcelasModel?.dias ?? 0),
			"taxa": PlutoCell(value: vendaCondicoesParcelasModel?.taxa ?? 0),
			"idVendaCondicoesPagamento": PlutoCell(value: vendaCondicoesParcelasModel?.idVendaCondicoesPagamento ?? 0),
		};
	}

	void plutoRowToObject() {
		vendaCondicoesParcelasModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return vendaCondicoesParcelasModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			parcelaController.text = currentRow.cells['parcela']?.value?.toString() ?? '';
			diasController.text = currentRow.cells['dias']?.value?.toString() ?? '';
			taxaController.text = currentRow.cells['taxa']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => VendaCondicoesParcelasEditPage());
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
	final parcelaController = TextEditingController();
	final diasController = TextEditingController();
	final taxaController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = vendaCondicoesParcelasModel.id;
		plutoRow.cells['idVendaCondicoesPagamento']?.value = vendaCondicoesParcelasModel.idVendaCondicoesPagamento;
		plutoRow.cells['parcela']?.value = vendaCondicoesParcelasModel.parcela;
		plutoRow.cells['dias']?.value = vendaCondicoesParcelasModel.dias;
		plutoRow.cells['taxa']?.value = vendaCondicoesParcelasModel.taxa;
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
		vendaCondicoesParcelasModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = VendaCondicoesParcelasModel();
			model.plutoRowToObject(plutoRow);
			vendaCondicoesParcelasModelList.add(model);
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
		parcelaController.dispose();
		diasController.dispose();
		taxaController.dispose();
		super.onClose();
	}
}