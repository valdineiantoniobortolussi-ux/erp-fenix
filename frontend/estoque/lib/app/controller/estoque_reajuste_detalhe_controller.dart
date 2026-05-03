import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:estoque/app/controller/controller_imports.dart';
import 'package:estoque/app/routes/app_routes.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/page/page_imports.dart';
import 'package:estoque/app/page/grid_columns/grid_columns_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';

class EstoqueReajusteDetalheController extends GetxController {

	// general
	final gridColumns = estoqueReajusteDetalheGridColumns();
	
	var estoqueReajusteDetalheModelList = <EstoqueReajusteDetalheModel>[];

	final _estoqueReajusteDetalheModel = EstoqueReajusteDetalheModel().obs;
	EstoqueReajusteDetalheModel get estoqueReajusteDetalheModel => _estoqueReajusteDetalheModel.value;
	set estoqueReajusteDetalheModel(value) => _estoqueReajusteDetalheModel.value = value ?? EstoqueReajusteDetalheModel();
	
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
		for (var estoqueReajusteDetalheModel in estoqueReajusteDetalheModelList) {
			plutoRowList.add(_getPlutoRow(estoqueReajusteDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(EstoqueReajusteDetalheModel estoqueReajusteDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(estoqueReajusteDetalheModel: estoqueReajusteDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ EstoqueReajusteDetalheModel? estoqueReajusteDetalheModel}) {
		return {
			"id": PlutoCell(value: estoqueReajusteDetalheModel?.id ?? 0),
			"produto": PlutoCell(value: estoqueReajusteDetalheModel?.produtoModel?.nome ?? ''),
			"valorOriginal": PlutoCell(value: estoqueReajusteDetalheModel?.valorOriginal ?? 0),
			"valorReajuste": PlutoCell(value: estoqueReajusteDetalheModel?.valorReajuste ?? 0),
			"idEstoqueReajusteCabecalho": PlutoCell(value: estoqueReajusteDetalheModel?.idEstoqueReajusteCabecalho ?? 0),
			"idProduto": PlutoCell(value: estoqueReajusteDetalheModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		estoqueReajusteDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return estoqueReajusteDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			valorOriginalController.text = currentRow.cells['valorOriginal']?.value?.toStringAsFixed(2) ?? '';
			valorReajusteController.text = currentRow.cells['valorReajuste']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => EstoqueReajusteDetalheEditPage());
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
	final produtoModelController = TextEditingController();
	final valorOriginalController = MoneyMaskedTextController();
	final valorReajusteController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = estoqueReajusteDetalheModel.id;
		plutoRow.cells['idEstoqueReajusteCabecalho']?.value = estoqueReajusteDetalheModel.idEstoqueReajusteCabecalho;
		plutoRow.cells['idProduto']?.value = estoqueReajusteDetalheModel.idProduto;
		plutoRow.cells['produto']?.value = estoqueReajusteDetalheModel.produtoModel?.nome;
		plutoRow.cells['valorOriginal']?.value = estoqueReajusteDetalheModel.valorOriginal;
		plutoRow.cells['valorReajuste']?.value = estoqueReajusteDetalheModel.valorReajuste;
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
		estoqueReajusteDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = EstoqueReajusteDetalheModel();
			model.plutoRowToObject(plutoRow);
			estoqueReajusteDetalheModelList.add(model);
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

	Future callProdutoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Produto]'; 
		lookupController.route = '/produto/'; 
		lookupController.gridColumns = produtoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoModel.aliasColumns; 
		lookupController.dbColumns = ProdutoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			estoqueReajusteDetalheModel.idProduto = plutoRowResult.cells['id']!.value; 
			estoqueReajusteDetalheModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = estoqueReajusteDetalheModel.produtoModel?.nome ?? ''; 
			formWasChanged = true; 
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
		produtoModelController.dispose();
		valorOriginalController.dispose();
		valorReajusteController.dispose();
		super.onClose();
	}
}