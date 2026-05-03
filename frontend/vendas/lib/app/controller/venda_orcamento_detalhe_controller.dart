import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:vendas/app/controller/controller_imports.dart';
import 'package:vendas/app/routes/app_routes.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/page/page_imports.dart';
import 'package:vendas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:vendas/app/page/shared_widget/message_dialog.dart';

class VendaOrcamentoDetalheController extends GetxController {

	// general
	final gridColumns = vendaOrcamentoDetalheGridColumns();
	
	var vendaOrcamentoDetalheModelList = <VendaOrcamentoDetalheModel>[];

	final _vendaOrcamentoDetalheModel = VendaOrcamentoDetalheModel().obs;
	VendaOrcamentoDetalheModel get vendaOrcamentoDetalheModel => _vendaOrcamentoDetalheModel.value;
	set vendaOrcamentoDetalheModel(value) => _vendaOrcamentoDetalheModel.value = value ?? VendaOrcamentoDetalheModel();
	
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
		for (var vendaOrcamentoDetalheModel in vendaOrcamentoDetalheModelList) {
			plutoRowList.add(_getPlutoRow(vendaOrcamentoDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(VendaOrcamentoDetalheModel vendaOrcamentoDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(vendaOrcamentoDetalheModel: vendaOrcamentoDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ VendaOrcamentoDetalheModel? vendaOrcamentoDetalheModel}) {
		return {
			"id": PlutoCell(value: vendaOrcamentoDetalheModel?.id ?? 0),
			"produto": PlutoCell(value: vendaOrcamentoDetalheModel?.produtoModel?.nome ?? ''),
			"quantidade": PlutoCell(value: vendaOrcamentoDetalheModel?.quantidade ?? 0),
			"valorUnitario": PlutoCell(value: vendaOrcamentoDetalheModel?.valorUnitario ?? 0),
			"valorSubtotal": PlutoCell(value: vendaOrcamentoDetalheModel?.valorSubtotal ?? 0),
			"taxaDesconto": PlutoCell(value: vendaOrcamentoDetalheModel?.taxaDesconto ?? 0),
			"valorDesconto": PlutoCell(value: vendaOrcamentoDetalheModel?.valorDesconto ?? 0),
			"valorTotal": PlutoCell(value: vendaOrcamentoDetalheModel?.valorTotal ?? 0),
			"idVendaOrcamentoCabecalho": PlutoCell(value: vendaOrcamentoDetalheModel?.idVendaOrcamentoCabecalho ?? 0),
			"idProduto": PlutoCell(value: vendaOrcamentoDetalheModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		vendaOrcamentoDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return vendaOrcamentoDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toStringAsFixed(2) ?? '';
			valorUnitarioController.text = currentRow.cells['valorUnitario']?.value?.toStringAsFixed(2) ?? '';
			valorSubtotalController.text = currentRow.cells['valorSubtotal']?.value?.toStringAsFixed(2) ?? '';
			taxaDescontoController.text = currentRow.cells['taxaDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => VendaOrcamentoDetalheEditPage());
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
	final quantidadeController = MoneyMaskedTextController();
	final valorUnitarioController = MoneyMaskedTextController();
	final valorSubtotalController = MoneyMaskedTextController();
	final taxaDescontoController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = vendaOrcamentoDetalheModel.id;
		plutoRow.cells['idVendaOrcamentoCabecalho']?.value = vendaOrcamentoDetalheModel.idVendaOrcamentoCabecalho;
		plutoRow.cells['idProduto']?.value = vendaOrcamentoDetalheModel.idProduto;
		plutoRow.cells['produto']?.value = vendaOrcamentoDetalheModel.produtoModel?.nome;
		plutoRow.cells['quantidade']?.value = vendaOrcamentoDetalheModel.quantidade;
		plutoRow.cells['valorUnitario']?.value = vendaOrcamentoDetalheModel.valorUnitario;
		plutoRow.cells['valorSubtotal']?.value = vendaOrcamentoDetalheModel.valorSubtotal;
		plutoRow.cells['taxaDesconto']?.value = vendaOrcamentoDetalheModel.taxaDesconto;
		plutoRow.cells['valorDesconto']?.value = vendaOrcamentoDetalheModel.valorDesconto;
		plutoRow.cells['valorTotal']?.value = vendaOrcamentoDetalheModel.valorTotal;
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
		vendaOrcamentoDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = VendaOrcamentoDetalheModel();
			model.plutoRowToObject(plutoRow);
			vendaOrcamentoDetalheModelList.add(model);
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
			vendaOrcamentoDetalheModel.idProduto = plutoRowResult.cells['id']!.value; 
			vendaOrcamentoDetalheModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = vendaOrcamentoDetalheModel.produtoModel?.nome ?? ''; 
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
		quantidadeController.dispose();
		valorUnitarioController.dispose();
		valorSubtotalController.dispose();
		taxaDescontoController.dispose();
		valorDescontoController.dispose();
		valorTotalController.dispose();
		super.onClose();
	}
}