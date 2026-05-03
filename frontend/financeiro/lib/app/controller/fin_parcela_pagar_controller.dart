import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:financeiro/app/controller/controller_imports.dart';
import 'package:financeiro/app/routes/app_routes.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/page/page_imports.dart';
import 'package:financeiro/app/page/grid_columns/grid_columns_imports.dart';
import 'package:financeiro/app/page/shared_widget/message_dialog.dart';

class FinParcelaPagarController extends GetxController {

	// general
	final gridColumns = finParcelaPagarGridColumns();
	
	var finParcelaPagarModelList = <FinParcelaPagarModel>[];

	final _finParcelaPagarModel = FinParcelaPagarModel().obs;
	FinParcelaPagarModel get finParcelaPagarModel => _finParcelaPagarModel.value;
	set finParcelaPagarModel(value) => _finParcelaPagarModel.value = value ?? FinParcelaPagarModel();
	
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
		for (var finParcelaPagarModel in finParcelaPagarModelList) {
			plutoRowList.add(_getPlutoRow(finParcelaPagarModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FinParcelaPagarModel finParcelaPagarModel) {
		return PlutoRow(
			cells: _getPlutoCells(finParcelaPagarModel: finParcelaPagarModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FinParcelaPagarModel? finParcelaPagarModel}) {
		return {
			"id": PlutoCell(value: finParcelaPagarModel?.id ?? 0),
			"finStatusParcela": PlutoCell(value: finParcelaPagarModel?.finStatusParcelaModel?.descricao ?? ''),
			"finTipoPagamento": PlutoCell(value: finParcelaPagarModel?.finTipoPagamentoModel?.descricao ?? ''),
			"numeroParcela": PlutoCell(value: finParcelaPagarModel?.numeroParcela ?? 0),
			"dataEmissao": PlutoCell(value: finParcelaPagarModel?.dataEmissao ?? ''),
			"dataVencimento": PlutoCell(value: finParcelaPagarModel?.dataVencimento ?? ''),
			"dataPagamento": PlutoCell(value: finParcelaPagarModel?.dataPagamento ?? ''),
			"descontoAte": PlutoCell(value: finParcelaPagarModel?.descontoAte ?? ''),
			"valor": PlutoCell(value: finParcelaPagarModel?.valor ?? 0),
			"taxaJuro": PlutoCell(value: finParcelaPagarModel?.taxaJuro ?? 0),
			"taxaMulta": PlutoCell(value: finParcelaPagarModel?.taxaMulta ?? 0),
			"taxaDesconto": PlutoCell(value: finParcelaPagarModel?.taxaDesconto ?? 0),
			"valorJuro": PlutoCell(value: finParcelaPagarModel?.valorJuro ?? 0),
			"valorMulta": PlutoCell(value: finParcelaPagarModel?.valorMulta ?? 0),
			"valorDesconto": PlutoCell(value: finParcelaPagarModel?.valorDesconto ?? 0),
			"valorPago": PlutoCell(value: finParcelaPagarModel?.valorPago ?? 0),
			"historico": PlutoCell(value: finParcelaPagarModel?.historico ?? ''),
			"idFinLancamentoPagar": PlutoCell(value: finParcelaPagarModel?.idFinLancamentoPagar ?? 0),
			"idFinChequeEmitido": PlutoCell(value: finParcelaPagarModel?.idFinChequeEmitido ?? 0),
			"idFinStatusParcela": PlutoCell(value: finParcelaPagarModel?.idFinStatusParcela ?? 0),
			"idFinTipoPagamento": PlutoCell(value: finParcelaPagarModel?.idFinTipoPagamento ?? 0),
		};
	}

	void plutoRowToObject() {
		finParcelaPagarModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return finParcelaPagarModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			finStatusParcelaModelController.text = currentRow.cells['finStatusParcela']?.value ?? '';
			finTipoPagamentoModelController.text = currentRow.cells['finTipoPagamento']?.value ?? '';
			numeroParcelaController.text = currentRow.cells['numeroParcela']?.value?.toString() ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			taxaJuroController.text = currentRow.cells['taxaJuro']?.value?.toStringAsFixed(2) ?? '';
			taxaMultaController.text = currentRow.cells['taxaMulta']?.value?.toStringAsFixed(2) ?? '';
			taxaDescontoController.text = currentRow.cells['taxaDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorJuroController.text = currentRow.cells['valorJuro']?.value?.toStringAsFixed(2) ?? '';
			valorMultaController.text = currentRow.cells['valorMulta']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorPagoController.text = currentRow.cells['valorPago']?.value?.toStringAsFixed(2) ?? '';
			historicoController.text = currentRow.cells['historico']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FinParcelaPagarEditPage());
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
	final finStatusParcelaModelController = TextEditingController();
	final finTipoPagamentoModelController = TextEditingController();
	final numeroParcelaController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final taxaJuroController = MoneyMaskedTextController();
	final taxaMultaController = MoneyMaskedTextController();
	final taxaDescontoController = MoneyMaskedTextController();
	final valorJuroController = MoneyMaskedTextController();
	final valorMultaController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final valorPagoController = MoneyMaskedTextController();
	final historicoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = finParcelaPagarModel.id;
		plutoRow.cells['idFinLancamentoPagar']?.value = finParcelaPagarModel.idFinLancamentoPagar;
		plutoRow.cells['idFinChequeEmitido']?.value = finParcelaPagarModel.idFinChequeEmitido;
		plutoRow.cells['idFinStatusParcela']?.value = finParcelaPagarModel.idFinStatusParcela;
		plutoRow.cells['finStatusParcela']?.value = finParcelaPagarModel.finStatusParcelaModel?.descricao;
		plutoRow.cells['idFinTipoPagamento']?.value = finParcelaPagarModel.idFinTipoPagamento;
		plutoRow.cells['finTipoPagamento']?.value = finParcelaPagarModel.finTipoPagamentoModel?.descricao;
		plutoRow.cells['numeroParcela']?.value = finParcelaPagarModel.numeroParcela;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(finParcelaPagarModel.dataEmissao);
		plutoRow.cells['dataVencimento']?.value = Util.formatDate(finParcelaPagarModel.dataVencimento);
		plutoRow.cells['dataPagamento']?.value = Util.formatDate(finParcelaPagarModel.dataPagamento);
		plutoRow.cells['descontoAte']?.value = Util.formatDate(finParcelaPagarModel.descontoAte);
		plutoRow.cells['valor']?.value = finParcelaPagarModel.valor;
		plutoRow.cells['taxaJuro']?.value = finParcelaPagarModel.taxaJuro;
		plutoRow.cells['taxaMulta']?.value = finParcelaPagarModel.taxaMulta;
		plutoRow.cells['taxaDesconto']?.value = finParcelaPagarModel.taxaDesconto;
		plutoRow.cells['valorJuro']?.value = finParcelaPagarModel.valorJuro;
		plutoRow.cells['valorMulta']?.value = finParcelaPagarModel.valorMulta;
		plutoRow.cells['valorDesconto']?.value = finParcelaPagarModel.valorDesconto;
		plutoRow.cells['valorPago']?.value = finParcelaPagarModel.valorPago;
		plutoRow.cells['historico']?.value = finParcelaPagarModel.historico;
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
		finParcelaPagarModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FinParcelaPagarModel();
			model.plutoRowToObject(plutoRow);
			finParcelaPagarModelList.add(model);
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

	Future callFinStatusParcelaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Status Parcela]'; 
		lookupController.route = '/fin-status-parcela/'; 
		lookupController.gridColumns = finStatusParcelaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FinStatusParcelaModel.aliasColumns; 
		lookupController.dbColumns = FinStatusParcelaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finParcelaPagarModel.idFinStatusParcela = plutoRowResult.cells['id']!.value; 
			finParcelaPagarModel.finStatusParcelaModel!.plutoRowToObject(plutoRowResult); 
			finStatusParcelaModelController.text = finParcelaPagarModel.finStatusParcelaModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFinTipoPagamentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Pagamento]'; 
		lookupController.route = '/fin-tipo-pagamento/'; 
		lookupController.gridColumns = finTipoPagamentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FinTipoPagamentoModel.aliasColumns; 
		lookupController.dbColumns = FinTipoPagamentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finParcelaPagarModel.idFinTipoPagamento = plutoRowResult.cells['id']!.value; 
			finParcelaPagarModel.finTipoPagamentoModel!.plutoRowToObject(plutoRowResult); 
			finTipoPagamentoModelController.text = finParcelaPagarModel.finTipoPagamentoModel?.descricao ?? ''; 
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
		finStatusParcelaModelController.dispose();
		finTipoPagamentoModelController.dispose();
		numeroParcelaController.dispose();
		valorController.dispose();
		taxaJuroController.dispose();
		taxaMultaController.dispose();
		taxaDescontoController.dispose();
		valorJuroController.dispose();
		valorMultaController.dispose();
		valorDescontoController.dispose();
		valorPagoController.dispose();
		historicoController.dispose();
		super.onClose();
	}
}