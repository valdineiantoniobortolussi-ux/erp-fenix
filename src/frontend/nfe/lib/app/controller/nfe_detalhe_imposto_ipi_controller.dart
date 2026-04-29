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

class NfeDetalheImpostoIpiController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoIpiGridColumns();
	
	var nfeDetalheImpostoIpiModelList = <NfeDetalheImpostoIpiModel>[];

	final _nfeDetalheImpostoIpiModel = NfeDetalheImpostoIpiModel().obs;
	NfeDetalheImpostoIpiModel get nfeDetalheImpostoIpiModel => _nfeDetalheImpostoIpiModel.value;
	set nfeDetalheImpostoIpiModel(value) => _nfeDetalheImpostoIpiModel.value = value ?? NfeDetalheImpostoIpiModel();
	
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
		for (var nfeDetalheImpostoIpiModel in nfeDetalheImpostoIpiModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoIpiModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoIpiModel nfeDetalheImpostoIpiModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoIpiModel: nfeDetalheImpostoIpiModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoIpiModel? nfeDetalheImpostoIpiModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoIpiModel?.id ?? 0),
			"cnpjProdutor": PlutoCell(value: nfeDetalheImpostoIpiModel?.cnpjProdutor ?? ''),
			"codigoSeloIpi": PlutoCell(value: nfeDetalheImpostoIpiModel?.codigoSeloIpi ?? ''),
			"quantidadeSeloIpi": PlutoCell(value: nfeDetalheImpostoIpiModel?.quantidadeSeloIpi ?? 0),
			"enquadramentoLegalIpi": PlutoCell(value: nfeDetalheImpostoIpiModel?.enquadramentoLegalIpi ?? ''),
			"cstIpi": PlutoCell(value: nfeDetalheImpostoIpiModel?.cstIpi ?? ''),
			"valorBaseCalculoIpi": PlutoCell(value: nfeDetalheImpostoIpiModel?.valorBaseCalculoIpi ?? 0),
			"quantidadeUnidadeTributavel": PlutoCell(value: nfeDetalheImpostoIpiModel?.quantidadeUnidadeTributavel ?? 0),
			"valorUnidadeTributavel": PlutoCell(value: nfeDetalheImpostoIpiModel?.valorUnidadeTributavel ?? 0),
			"aliquotaIpi": PlutoCell(value: nfeDetalheImpostoIpiModel?.aliquotaIpi ?? 0),
			"valorIpi": PlutoCell(value: nfeDetalheImpostoIpiModel?.valorIpi ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoIpiModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoIpiModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoIpiModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjProdutorController.text = currentRow.cells['cnpjProdutor']?.value ?? '';
			codigoSeloIpiController.text = currentRow.cells['codigoSeloIpi']?.value ?? '';
			quantidadeSeloIpiController.text = currentRow.cells['quantidadeSeloIpi']?.value?.toString() ?? '';
			valorBaseCalculoIpiController.text = currentRow.cells['valorBaseCalculoIpi']?.value?.toStringAsFixed(2) ?? '';
			quantidadeUnidadeTributavelController.text = currentRow.cells['quantidadeUnidadeTributavel']?.value?.toStringAsFixed(2) ?? '';
			valorUnidadeTributavelController.text = currentRow.cells['valorUnidadeTributavel']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIpiController.text = currentRow.cells['aliquotaIpi']?.value?.toStringAsFixed(2) ?? '';
			valorIpiController.text = currentRow.cells['valorIpi']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoIpiEditPage());
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
	final cnpjProdutorController = MaskedTextController(mask: '00.000.000/0000-00',);
	final codigoSeloIpiController = TextEditingController();
	final quantidadeSeloIpiController = TextEditingController();
	final valorBaseCalculoIpiController = MoneyMaskedTextController();
	final quantidadeUnidadeTributavelController = MoneyMaskedTextController();
	final valorUnidadeTributavelController = MoneyMaskedTextController();
	final aliquotaIpiController = MoneyMaskedTextController();
	final valorIpiController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoIpiModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoIpiModel.idNfeDetalhe;
		plutoRow.cells['cnpjProdutor']?.value = nfeDetalheImpostoIpiModel.cnpjProdutor;
		plutoRow.cells['codigoSeloIpi']?.value = nfeDetalheImpostoIpiModel.codigoSeloIpi;
		plutoRow.cells['quantidadeSeloIpi']?.value = nfeDetalheImpostoIpiModel.quantidadeSeloIpi;
		plutoRow.cells['enquadramentoLegalIpi']?.value = nfeDetalheImpostoIpiModel.enquadramentoLegalIpi;
		plutoRow.cells['cstIpi']?.value = nfeDetalheImpostoIpiModel.cstIpi;
		plutoRow.cells['valorBaseCalculoIpi']?.value = nfeDetalheImpostoIpiModel.valorBaseCalculoIpi;
		plutoRow.cells['quantidadeUnidadeTributavel']?.value = nfeDetalheImpostoIpiModel.quantidadeUnidadeTributavel;
		plutoRow.cells['valorUnidadeTributavel']?.value = nfeDetalheImpostoIpiModel.valorUnidadeTributavel;
		plutoRow.cells['aliquotaIpi']?.value = nfeDetalheImpostoIpiModel.aliquotaIpi;
		plutoRow.cells['valorIpi']?.value = nfeDetalheImpostoIpiModel.valorIpi;
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
		nfeDetalheImpostoIpiModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoIpiModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoIpiModelList.add(model);
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
		cnpjProdutorController.dispose();
		codigoSeloIpiController.dispose();
		quantidadeSeloIpiController.dispose();
		valorBaseCalculoIpiController.dispose();
		quantidadeUnidadeTributavelController.dispose();
		valorUnidadeTributavelController.dispose();
		aliquotaIpiController.dispose();
		valorIpiController.dispose();
		super.onClose();
	}
}