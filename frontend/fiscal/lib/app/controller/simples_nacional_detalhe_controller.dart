import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/page_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';

class SimplesNacionalDetalheController extends GetxController {

	// general
	final gridColumns = simplesNacionalDetalheGridColumns();
	
	var simplesNacionalDetalheModelList = <SimplesNacionalDetalheModel>[];

	final _simplesNacionalDetalheModel = SimplesNacionalDetalheModel().obs;
	SimplesNacionalDetalheModel get simplesNacionalDetalheModel => _simplesNacionalDetalheModel.value;
	set simplesNacionalDetalheModel(value) => _simplesNacionalDetalheModel.value = value ?? SimplesNacionalDetalheModel();
	
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
		for (var simplesNacionalDetalheModel in simplesNacionalDetalheModelList) {
			plutoRowList.add(_getPlutoRow(simplesNacionalDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(SimplesNacionalDetalheModel simplesNacionalDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(simplesNacionalDetalheModel: simplesNacionalDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ SimplesNacionalDetalheModel? simplesNacionalDetalheModel}) {
		return {
			"id": PlutoCell(value: simplesNacionalDetalheModel?.id ?? 0),
			"faixa": PlutoCell(value: simplesNacionalDetalheModel?.faixa ?? 0),
			"valorInicial": PlutoCell(value: simplesNacionalDetalheModel?.valorInicial ?? 0),
			"valorFinal": PlutoCell(value: simplesNacionalDetalheModel?.valorFinal ?? 0),
			"aliquota": PlutoCell(value: simplesNacionalDetalheModel?.aliquota ?? 0),
			"irpj": PlutoCell(value: simplesNacionalDetalheModel?.irpj ?? 0),
			"csll": PlutoCell(value: simplesNacionalDetalheModel?.csll ?? 0),
			"cofins": PlutoCell(value: simplesNacionalDetalheModel?.cofins ?? 0),
			"pisPasep": PlutoCell(value: simplesNacionalDetalheModel?.pisPasep ?? 0),
			"cpp": PlutoCell(value: simplesNacionalDetalheModel?.cpp ?? 0),
			"icms": PlutoCell(value: simplesNacionalDetalheModel?.icms ?? 0),
			"ipi": PlutoCell(value: simplesNacionalDetalheModel?.ipi ?? 0),
			"iss": PlutoCell(value: simplesNacionalDetalheModel?.iss ?? 0),
			"idSimplesNacionalCabecalho": PlutoCell(value: simplesNacionalDetalheModel?.idSimplesNacionalCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		simplesNacionalDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return simplesNacionalDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			faixaController.text = currentRow.cells['faixa']?.value?.toString() ?? '';
			valorInicialController.text = currentRow.cells['valorInicial']?.value?.toStringAsFixed(2) ?? '';
			valorFinalController.text = currentRow.cells['valorFinal']?.value?.toStringAsFixed(2) ?? '';
			aliquotaController.text = currentRow.cells['aliquota']?.value?.toStringAsFixed(2) ?? '';
			irpjController.text = currentRow.cells['irpj']?.value?.toStringAsFixed(2) ?? '';
			csllController.text = currentRow.cells['csll']?.value?.toStringAsFixed(2) ?? '';
			cofinsController.text = currentRow.cells['cofins']?.value?.toStringAsFixed(2) ?? '';
			pisPasepController.text = currentRow.cells['pisPasep']?.value?.toStringAsFixed(2) ?? '';
			cppController.text = currentRow.cells['cpp']?.value?.toStringAsFixed(2) ?? '';
			icmsController.text = currentRow.cells['icms']?.value?.toStringAsFixed(2) ?? '';
			ipiController.text = currentRow.cells['ipi']?.value?.toStringAsFixed(2) ?? '';
			issController.text = currentRow.cells['iss']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => SimplesNacionalDetalheEditPage());
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
	final faixaController = TextEditingController();
	final valorInicialController = MoneyMaskedTextController();
	final valorFinalController = MoneyMaskedTextController();
	final aliquotaController = MoneyMaskedTextController();
	final irpjController = MoneyMaskedTextController();
	final csllController = MoneyMaskedTextController();
	final cofinsController = MoneyMaskedTextController();
	final pisPasepController = MoneyMaskedTextController();
	final cppController = MoneyMaskedTextController();
	final icmsController = MoneyMaskedTextController();
	final ipiController = MoneyMaskedTextController();
	final issController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = simplesNacionalDetalheModel.id;
		plutoRow.cells['idSimplesNacionalCabecalho']?.value = simplesNacionalDetalheModel.idSimplesNacionalCabecalho;
		plutoRow.cells['faixa']?.value = simplesNacionalDetalheModel.faixa;
		plutoRow.cells['valorInicial']?.value = simplesNacionalDetalheModel.valorInicial;
		plutoRow.cells['valorFinal']?.value = simplesNacionalDetalheModel.valorFinal;
		plutoRow.cells['aliquota']?.value = simplesNacionalDetalheModel.aliquota;
		plutoRow.cells['irpj']?.value = simplesNacionalDetalheModel.irpj;
		plutoRow.cells['csll']?.value = simplesNacionalDetalheModel.csll;
		plutoRow.cells['cofins']?.value = simplesNacionalDetalheModel.cofins;
		plutoRow.cells['pisPasep']?.value = simplesNacionalDetalheModel.pisPasep;
		plutoRow.cells['cpp']?.value = simplesNacionalDetalheModel.cpp;
		plutoRow.cells['icms']?.value = simplesNacionalDetalheModel.icms;
		plutoRow.cells['ipi']?.value = simplesNacionalDetalheModel.ipi;
		plutoRow.cells['iss']?.value = simplesNacionalDetalheModel.iss;
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
		simplesNacionalDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = SimplesNacionalDetalheModel();
			model.plutoRowToObject(plutoRow);
			simplesNacionalDetalheModelList.add(model);
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
		faixaController.dispose();
		valorInicialController.dispose();
		valorFinalController.dispose();
		aliquotaController.dispose();
		irpjController.dispose();
		csllController.dispose();
		cofinsController.dispose();
		pisPasepController.dispose();
		cppController.dispose();
		icmsController.dispose();
		ipiController.dispose();
		issController.dispose();
		super.onClose();
	}
}