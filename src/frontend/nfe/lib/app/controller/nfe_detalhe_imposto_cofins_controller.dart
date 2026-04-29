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

class NfeDetalheImpostoCofinsController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoCofinsGridColumns();
	
	var nfeDetalheImpostoCofinsModelList = <NfeDetalheImpostoCofinsModel>[];

	final _nfeDetalheImpostoCofinsModel = NfeDetalheImpostoCofinsModel().obs;
	NfeDetalheImpostoCofinsModel get nfeDetalheImpostoCofinsModel => _nfeDetalheImpostoCofinsModel.value;
	set nfeDetalheImpostoCofinsModel(value) => _nfeDetalheImpostoCofinsModel.value = value ?? NfeDetalheImpostoCofinsModel();
	
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
		for (var nfeDetalheImpostoCofinsModel in nfeDetalheImpostoCofinsModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoCofinsModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoCofinsModel nfeDetalheImpostoCofinsModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoCofinsModel: nfeDetalheImpostoCofinsModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoCofinsModel? nfeDetalheImpostoCofinsModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoCofinsModel?.id ?? 0),
			"cstCofins": PlutoCell(value: nfeDetalheImpostoCofinsModel?.cstCofins ?? ''),
			"baseCalculoCofins": PlutoCell(value: nfeDetalheImpostoCofinsModel?.baseCalculoCofins ?? 0),
			"aliquotaCofinsPercentual": PlutoCell(value: nfeDetalheImpostoCofinsModel?.aliquotaCofinsPercentual ?? 0),
			"quantidadeVendida": PlutoCell(value: nfeDetalheImpostoCofinsModel?.quantidadeVendida ?? 0),
			"aliquotaCofinsReais": PlutoCell(value: nfeDetalheImpostoCofinsModel?.aliquotaCofinsReais ?? 0),
			"valorCofins": PlutoCell(value: nfeDetalheImpostoCofinsModel?.valorCofins ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoCofinsModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoCofinsModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoCofinsModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			baseCalculoCofinsController.text = currentRow.cells['baseCalculoCofins']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCofinsPercentualController.text = currentRow.cells['aliquotaCofinsPercentual']?.value?.toStringAsFixed(2) ?? '';
			quantidadeVendidaController.text = currentRow.cells['quantidadeVendida']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCofinsReaisController.text = currentRow.cells['aliquotaCofinsReais']?.value?.toStringAsFixed(2) ?? '';
			valorCofinsController.text = currentRow.cells['valorCofins']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoCofinsEditPage());
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
	final baseCalculoCofinsController = MoneyMaskedTextController();
	final aliquotaCofinsPercentualController = MoneyMaskedTextController();
	final quantidadeVendidaController = MoneyMaskedTextController();
	final aliquotaCofinsReaisController = MoneyMaskedTextController();
	final valorCofinsController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoCofinsModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoCofinsModel.idNfeDetalhe;
		plutoRow.cells['cstCofins']?.value = nfeDetalheImpostoCofinsModel.cstCofins;
		plutoRow.cells['baseCalculoCofins']?.value = nfeDetalheImpostoCofinsModel.baseCalculoCofins;
		plutoRow.cells['aliquotaCofinsPercentual']?.value = nfeDetalheImpostoCofinsModel.aliquotaCofinsPercentual;
		plutoRow.cells['quantidadeVendida']?.value = nfeDetalheImpostoCofinsModel.quantidadeVendida;
		plutoRow.cells['aliquotaCofinsReais']?.value = nfeDetalheImpostoCofinsModel.aliquotaCofinsReais;
		plutoRow.cells['valorCofins']?.value = nfeDetalheImpostoCofinsModel.valorCofins;
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
		nfeDetalheImpostoCofinsModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoCofinsModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoCofinsModelList.add(model);
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
		baseCalculoCofinsController.dispose();
		aliquotaCofinsPercentualController.dispose();
		quantidadeVendidaController.dispose();
		aliquotaCofinsReaisController.dispose();
		valorCofinsController.dispose();
		super.onClose();
	}
}