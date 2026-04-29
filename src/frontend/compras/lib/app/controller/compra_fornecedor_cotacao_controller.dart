import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:compras/app/controller/controller_imports.dart';
import 'package:compras/app/routes/app_routes.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:compras/app/page/page_imports.dart';
import 'package:compras/app/page/grid_columns/grid_columns_imports.dart';
import 'package:compras/app/page/shared_widget/message_dialog.dart';

class CompraFornecedorCotacaoController extends GetxController {

	// general
	final gridColumns = compraFornecedorCotacaoGridColumns();
	
	var compraFornecedorCotacaoModelList = <CompraFornecedorCotacaoModel>[];

	final _compraFornecedorCotacaoModel = CompraFornecedorCotacaoModel().obs;
	CompraFornecedorCotacaoModel get compraFornecedorCotacaoModel => _compraFornecedorCotacaoModel.value;
	set compraFornecedorCotacaoModel(value) => _compraFornecedorCotacaoModel.value = value ?? CompraFornecedorCotacaoModel();
	
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
		for (var compraFornecedorCotacaoModel in compraFornecedorCotacaoModelList) {
			plutoRowList.add(_getPlutoRow(compraFornecedorCotacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CompraFornecedorCotacaoModel compraFornecedorCotacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(compraFornecedorCotacaoModel: compraFornecedorCotacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CompraFornecedorCotacaoModel? compraFornecedorCotacaoModel}) {
		return {
			"id": PlutoCell(value: compraFornecedorCotacaoModel?.id ?? 0),
			"viewPessoaFornecedor": PlutoCell(value: compraFornecedorCotacaoModel?.viewPessoaFornecedorModel?.nome ?? ''),
			"codigo": PlutoCell(value: compraFornecedorCotacaoModel?.codigo ?? ''),
			"prazoEntrega": PlutoCell(value: compraFornecedorCotacaoModel?.prazoEntrega ?? ''),
			"vendaCondicoesPagamento": PlutoCell(value: compraFornecedorCotacaoModel?.vendaCondicoesPagamento ?? ''),
			"valorSubtotal": PlutoCell(value: compraFornecedorCotacaoModel?.valorSubtotal ?? 0),
			"taxaDesconto": PlutoCell(value: compraFornecedorCotacaoModel?.taxaDesconto ?? 0),
			"valorDesconto": PlutoCell(value: compraFornecedorCotacaoModel?.valorDesconto ?? 0),
			"valorTotal": PlutoCell(value: compraFornecedorCotacaoModel?.valorTotal ?? 0),
			"idCompraCotacao": PlutoCell(value: compraFornecedorCotacaoModel?.idCompraCotacao ?? 0),
			"idFornecedor": PlutoCell(value: compraFornecedorCotacaoModel?.idFornecedor ?? 0),
		};
	}

	void plutoRowToObject() {
		compraFornecedorCotacaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return compraFornecedorCotacaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaFornecedorModelController.text = currentRow.cells['viewPessoaFornecedor']?.value ?? '';
			codigoController.text = currentRow.cells['codigo']?.value ?? '';
			prazoEntregaController.text = currentRow.cells['prazoEntrega']?.value ?? '';
			vendaCondicoesPagamentoController.text = currentRow.cells['vendaCondicoesPagamento']?.value ?? '';
			valorSubtotalController.text = currentRow.cells['valorSubtotal']?.value?.toStringAsFixed(2) ?? '';
			taxaDescontoController.text = currentRow.cells['taxaDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CompraFornecedorCotacaoEditPage());
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
	final viewPessoaFornecedorModelController = TextEditingController();
	final codigoController = TextEditingController();
	final prazoEntregaController = TextEditingController();
	final vendaCondicoesPagamentoController = TextEditingController();
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
		plutoRow.cells['id']?.value = compraFornecedorCotacaoModel.id;
		plutoRow.cells['idCompraCotacao']?.value = compraFornecedorCotacaoModel.idCompraCotacao;
		plutoRow.cells['idFornecedor']?.value = compraFornecedorCotacaoModel.idFornecedor;
		plutoRow.cells['viewPessoaFornecedor']?.value = compraFornecedorCotacaoModel.viewPessoaFornecedorModel?.nome;
		plutoRow.cells['codigo']?.value = compraFornecedorCotacaoModel.codigo;
		plutoRow.cells['prazoEntrega']?.value = compraFornecedorCotacaoModel.prazoEntrega;
		plutoRow.cells['vendaCondicoesPagamento']?.value = compraFornecedorCotacaoModel.vendaCondicoesPagamento;
		plutoRow.cells['valorSubtotal']?.value = compraFornecedorCotacaoModel.valorSubtotal;
		plutoRow.cells['taxaDesconto']?.value = compraFornecedorCotacaoModel.taxaDesconto;
		plutoRow.cells['valorDesconto']?.value = compraFornecedorCotacaoModel.valorDesconto;
		plutoRow.cells['valorTotal']?.value = compraFornecedorCotacaoModel.valorTotal;
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
		compraFornecedorCotacaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CompraFornecedorCotacaoModel();
			model.plutoRowToObject(plutoRow);
			compraFornecedorCotacaoModelList.add(model);
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

	Future callViewPessoaFornecedorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Fornecedor]'; 
		lookupController.route = '/view-pessoa-fornecedor/'; 
		lookupController.gridColumns = viewPessoaFornecedorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaFornecedorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaFornecedorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			compraFornecedorCotacaoModel.idFornecedor = plutoRowResult.cells['id']!.value; 
			compraFornecedorCotacaoModel.viewPessoaFornecedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaFornecedorModelController.text = compraFornecedorCotacaoModel.viewPessoaFornecedorModel?.nome ?? ''; 
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
		viewPessoaFornecedorModelController.dispose();
		codigoController.dispose();
		prazoEntregaController.dispose();
		vendaCondicoesPagamentoController.dispose();
		valorSubtotalController.dispose();
		taxaDescontoController.dispose();
		valorDescontoController.dispose();
		valorTotalController.dispose();
		super.onClose();
	}
}