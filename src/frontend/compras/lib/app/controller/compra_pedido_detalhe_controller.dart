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

class CompraPedidoDetalheController extends GetxController {

	// general
	final gridColumns = compraPedidoDetalheGridColumns();
	
	var compraPedidoDetalheModelList = <CompraPedidoDetalheModel>[];

	final _compraPedidoDetalheModel = CompraPedidoDetalheModel().obs;
	CompraPedidoDetalheModel get compraPedidoDetalheModel => _compraPedidoDetalheModel.value;
	set compraPedidoDetalheModel(value) => _compraPedidoDetalheModel.value = value ?? CompraPedidoDetalheModel();
	
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
		for (var compraPedidoDetalheModel in compraPedidoDetalheModelList) {
			plutoRowList.add(_getPlutoRow(compraPedidoDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CompraPedidoDetalheModel compraPedidoDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(compraPedidoDetalheModel: compraPedidoDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CompraPedidoDetalheModel? compraPedidoDetalheModel}) {
		return {
			"id": PlutoCell(value: compraPedidoDetalheModel?.id ?? 0),
			"produto": PlutoCell(value: compraPedidoDetalheModel?.produtoModel?.nome ?? ''),
			"quantidade": PlutoCell(value: compraPedidoDetalheModel?.quantidade ?? 0),
			"valorUnitario": PlutoCell(value: compraPedidoDetalheModel?.valorUnitario ?? 0),
			"valorSubtotal": PlutoCell(value: compraPedidoDetalheModel?.valorSubtotal ?? 0),
			"taxaDesconto": PlutoCell(value: compraPedidoDetalheModel?.taxaDesconto ?? 0),
			"valorDesconto": PlutoCell(value: compraPedidoDetalheModel?.valorDesconto ?? 0),
			"valorTotal": PlutoCell(value: compraPedidoDetalheModel?.valorTotal ?? 0),
			"cst": PlutoCell(value: compraPedidoDetalheModel?.cst ?? ''),
			"csosn": PlutoCell(value: compraPedidoDetalheModel?.csosn ?? ''),
			"cfop": PlutoCell(value: compraPedidoDetalheModel?.cfop ?? 0),
			"baseCalculoIcms": PlutoCell(value: compraPedidoDetalheModel?.baseCalculoIcms ?? 0),
			"valorIcms": PlutoCell(value: compraPedidoDetalheModel?.valorIcms ?? 0),
			"valorIpi": PlutoCell(value: compraPedidoDetalheModel?.valorIpi ?? 0),
			"aliquotaIcms": PlutoCell(value: compraPedidoDetalheModel?.aliquotaIcms ?? 0),
			"aliquotaIpi": PlutoCell(value: compraPedidoDetalheModel?.aliquotaIpi ?? 0),
			"idCompraPedido": PlutoCell(value: compraPedidoDetalheModel?.idCompraPedido ?? 0),
			"idProduto": PlutoCell(value: compraPedidoDetalheModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		compraPedidoDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return compraPedidoDetalheModelList;
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
			cstController.text = currentRow.cells['cst']?.value ?? '';
			csosnController.text = currentRow.cells['csosn']?.value ?? '';
			cfopController.text = currentRow.cells['cfop']?.value?.toString() ?? '';
			baseCalculoIcmsController.text = currentRow.cells['baseCalculoIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsController.text = currentRow.cells['valorIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIpiController.text = currentRow.cells['valorIpi']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsController.text = currentRow.cells['aliquotaIcms']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIpiController.text = currentRow.cells['aliquotaIpi']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CompraPedidoDetalheEditPage());
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
	final cstController = TextEditingController();
	final csosnController = TextEditingController();
	final cfopController = TextEditingController();
	final baseCalculoIcmsController = MoneyMaskedTextController();
	final valorIcmsController = MoneyMaskedTextController();
	final valorIpiController = MoneyMaskedTextController();
	final aliquotaIcmsController = MoneyMaskedTextController();
	final aliquotaIpiController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = compraPedidoDetalheModel.id;
		plutoRow.cells['idCompraPedido']?.value = compraPedidoDetalheModel.idCompraPedido;
		plutoRow.cells['idProduto']?.value = compraPedidoDetalheModel.idProduto;
		plutoRow.cells['produto']?.value = compraPedidoDetalheModel.produtoModel?.nome;
		plutoRow.cells['quantidade']?.value = compraPedidoDetalheModel.quantidade;
		plutoRow.cells['valorUnitario']?.value = compraPedidoDetalheModel.valorUnitario;
		plutoRow.cells['valorSubtotal']?.value = compraPedidoDetalheModel.valorSubtotal;
		plutoRow.cells['taxaDesconto']?.value = compraPedidoDetalheModel.taxaDesconto;
		plutoRow.cells['valorDesconto']?.value = compraPedidoDetalheModel.valorDesconto;
		plutoRow.cells['valorTotal']?.value = compraPedidoDetalheModel.valorTotal;
		plutoRow.cells['cst']?.value = compraPedidoDetalheModel.cst;
		plutoRow.cells['csosn']?.value = compraPedidoDetalheModel.csosn;
		plutoRow.cells['cfop']?.value = compraPedidoDetalheModel.cfop;
		plutoRow.cells['baseCalculoIcms']?.value = compraPedidoDetalheModel.baseCalculoIcms;
		plutoRow.cells['valorIcms']?.value = compraPedidoDetalheModel.valorIcms;
		plutoRow.cells['valorIpi']?.value = compraPedidoDetalheModel.valorIpi;
		plutoRow.cells['aliquotaIcms']?.value = compraPedidoDetalheModel.aliquotaIcms;
		plutoRow.cells['aliquotaIpi']?.value = compraPedidoDetalheModel.aliquotaIpi;
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
		compraPedidoDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CompraPedidoDetalheModel();
			model.plutoRowToObject(plutoRow);
			compraPedidoDetalheModelList.add(model);
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
			compraPedidoDetalheModel.idProduto = plutoRowResult.cells['id']!.value; 
			compraPedidoDetalheModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = compraPedidoDetalheModel.produtoModel?.nome ?? ''; 
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
		cstController.dispose();
		csosnController.dispose();
		cfopController.dispose();
		baseCalculoIcmsController.dispose();
		valorIcmsController.dispose();
		valorIpiController.dispose();
		aliquotaIcmsController.dispose();
		aliquotaIpiController.dispose();
		super.onClose();
	}
}