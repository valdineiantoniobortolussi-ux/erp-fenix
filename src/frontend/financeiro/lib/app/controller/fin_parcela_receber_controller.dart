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

class FinParcelaReceberController extends GetxController {

	// general
	final gridColumns = finParcelaReceberGridColumns();
	
	var finParcelaReceberModelList = <FinParcelaReceberModel>[];

	final _finParcelaReceberModel = FinParcelaReceberModel().obs;
	FinParcelaReceberModel get finParcelaReceberModel => _finParcelaReceberModel.value;
	set finParcelaReceberModel(value) => _finParcelaReceberModel.value = value ?? FinParcelaReceberModel();
	
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
		for (var finParcelaReceberModel in finParcelaReceberModelList) {
			plutoRowList.add(_getPlutoRow(finParcelaReceberModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FinParcelaReceberModel finParcelaReceberModel) {
		return PlutoRow(
			cells: _getPlutoCells(finParcelaReceberModel: finParcelaReceberModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FinParcelaReceberModel? finParcelaReceberModel}) {
		return {
			"id": PlutoCell(value: finParcelaReceberModel?.id ?? 0),
			"finStatusParcela": PlutoCell(value: finParcelaReceberModel?.finStatusParcelaModel?.descricao ?? ''),
			"finTipoRecebimento": PlutoCell(value: finParcelaReceberModel?.finTipoRecebimentoModel?.descricao ?? ''),
			"numeroParcela": PlutoCell(value: finParcelaReceberModel?.numeroParcela ?? 0),
			"dataEmissao": PlutoCell(value: finParcelaReceberModel?.dataEmissao ?? ''),
			"dataVencimento": PlutoCell(value: finParcelaReceberModel?.dataVencimento ?? ''),
			"dataRecebimento": PlutoCell(value: finParcelaReceberModel?.dataRecebimento ?? ''),
			"descontoAte": PlutoCell(value: finParcelaReceberModel?.descontoAte ?? ''),
			"valor": PlutoCell(value: finParcelaReceberModel?.valor ?? 0),
			"taxaJuro": PlutoCell(value: finParcelaReceberModel?.taxaJuro ?? 0),
			"taxaMulta": PlutoCell(value: finParcelaReceberModel?.taxaMulta ?? 0),
			"taxaDesconto": PlutoCell(value: finParcelaReceberModel?.taxaDesconto ?? 0),
			"valorJuro": PlutoCell(value: finParcelaReceberModel?.valorJuro ?? 0),
			"valorMulta": PlutoCell(value: finParcelaReceberModel?.valorMulta ?? 0),
			"valorDesconto": PlutoCell(value: finParcelaReceberModel?.valorDesconto ?? 0),
			"emitiuBoleto": PlutoCell(value: finParcelaReceberModel?.emitiuBoleto ?? ''),
			"boletoNossoNumero": PlutoCell(value: finParcelaReceberModel?.boletoNossoNumero ?? ''),
			"valorRecebido": PlutoCell(value: finParcelaReceberModel?.valorRecebido ?? 0),
			"historico": PlutoCell(value: finParcelaReceberModel?.historico ?? ''),
			"idFinLancamentoReceber": PlutoCell(value: finParcelaReceberModel?.idFinLancamentoReceber ?? 0),
			"idFinChequeRecebido": PlutoCell(value: finParcelaReceberModel?.idFinChequeRecebido ?? 0),
			"idFinStatusParcela": PlutoCell(value: finParcelaReceberModel?.idFinStatusParcela ?? 0),
			"idFinTipoRecebimento": PlutoCell(value: finParcelaReceberModel?.idFinTipoRecebimento ?? 0),
		};
	}

	void plutoRowToObject() {
		finParcelaReceberModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return finParcelaReceberModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			finStatusParcelaModelController.text = currentRow.cells['finStatusParcela']?.value ?? '';
			finTipoRecebimentoModelController.text = currentRow.cells['finTipoRecebimento']?.value ?? '';
			numeroParcelaController.text = currentRow.cells['numeroParcela']?.value?.toString() ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			taxaJuroController.text = currentRow.cells['taxaJuro']?.value?.toStringAsFixed(2) ?? '';
			taxaMultaController.text = currentRow.cells['taxaMulta']?.value?.toStringAsFixed(2) ?? '';
			taxaDescontoController.text = currentRow.cells['taxaDesconto']?.value?.toStringAsFixed(2) ?? '';
			valorJuroController.text = currentRow.cells['valorJuro']?.value?.toStringAsFixed(2) ?? '';
			valorMultaController.text = currentRow.cells['valorMulta']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoController.text = currentRow.cells['valorDesconto']?.value?.toStringAsFixed(2) ?? '';
			boletoNossoNumeroController.text = currentRow.cells['boletoNossoNumero']?.value ?? '';
			valorRecebidoController.text = currentRow.cells['valorRecebido']?.value?.toStringAsFixed(2) ?? '';
			historicoController.text = currentRow.cells['historico']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FinParcelaReceberEditPage());
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
	final finTipoRecebimentoModelController = TextEditingController();
	final numeroParcelaController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final taxaJuroController = MoneyMaskedTextController();
	final taxaMultaController = MoneyMaskedTextController();
	final taxaDescontoController = MoneyMaskedTextController();
	final valorJuroController = MoneyMaskedTextController();
	final valorMultaController = MoneyMaskedTextController();
	final valorDescontoController = MoneyMaskedTextController();
	final boletoNossoNumeroController = TextEditingController();
	final valorRecebidoController = MoneyMaskedTextController();
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
		plutoRow.cells['id']?.value = finParcelaReceberModel.id;
		plutoRow.cells['idFinLancamentoReceber']?.value = finParcelaReceberModel.idFinLancamentoReceber;
		plutoRow.cells['idFinChequeRecebido']?.value = finParcelaReceberModel.idFinChequeRecebido;
		plutoRow.cells['idFinStatusParcela']?.value = finParcelaReceberModel.idFinStatusParcela;
		plutoRow.cells['finStatusParcela']?.value = finParcelaReceberModel.finStatusParcelaModel?.descricao;
		plutoRow.cells['idFinTipoRecebimento']?.value = finParcelaReceberModel.idFinTipoRecebimento;
		plutoRow.cells['finTipoRecebimento']?.value = finParcelaReceberModel.finTipoRecebimentoModel?.descricao;
		plutoRow.cells['numeroParcela']?.value = finParcelaReceberModel.numeroParcela;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(finParcelaReceberModel.dataEmissao);
		plutoRow.cells['dataVencimento']?.value = Util.formatDate(finParcelaReceberModel.dataVencimento);
		plutoRow.cells['dataRecebimento']?.value = Util.formatDate(finParcelaReceberModel.dataRecebimento);
		plutoRow.cells['descontoAte']?.value = Util.formatDate(finParcelaReceberModel.descontoAte);
		plutoRow.cells['valor']?.value = finParcelaReceberModel.valor;
		plutoRow.cells['taxaJuro']?.value = finParcelaReceberModel.taxaJuro;
		plutoRow.cells['taxaMulta']?.value = finParcelaReceberModel.taxaMulta;
		plutoRow.cells['taxaDesconto']?.value = finParcelaReceberModel.taxaDesconto;
		plutoRow.cells['valorJuro']?.value = finParcelaReceberModel.valorJuro;
		plutoRow.cells['valorMulta']?.value = finParcelaReceberModel.valorMulta;
		plutoRow.cells['valorDesconto']?.value = finParcelaReceberModel.valorDesconto;
		plutoRow.cells['emitiuBoleto']?.value = finParcelaReceberModel.emitiuBoleto;
		plutoRow.cells['boletoNossoNumero']?.value = finParcelaReceberModel.boletoNossoNumero;
		plutoRow.cells['valorRecebido']?.value = finParcelaReceberModel.valorRecebido;
		plutoRow.cells['historico']?.value = finParcelaReceberModel.historico;
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
		finParcelaReceberModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FinParcelaReceberModel();
			model.plutoRowToObject(plutoRow);
			finParcelaReceberModelList.add(model);
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
			finParcelaReceberModel.idFinStatusParcela = plutoRowResult.cells['id']!.value; 
			finParcelaReceberModel.finStatusParcelaModel!.plutoRowToObject(plutoRowResult); 
			finStatusParcelaModelController.text = finParcelaReceberModel.finStatusParcelaModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callFinTipoRecebimentoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Recebimento]'; 
		lookupController.route = '/fin-tipo-recebimento/'; 
		lookupController.gridColumns = finTipoRecebimentoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FinTipoRecebimentoModel.aliasColumns; 
		lookupController.dbColumns = FinTipoRecebimentoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			finParcelaReceberModel.idFinTipoRecebimento = plutoRowResult.cells['id']!.value; 
			finParcelaReceberModel.finTipoRecebimentoModel!.plutoRowToObject(plutoRowResult); 
			finTipoRecebimentoModelController.text = finParcelaReceberModel.finTipoRecebimentoModel?.descricao ?? ''; 
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
		finTipoRecebimentoModelController.dispose();
		numeroParcelaController.dispose();
		valorController.dispose();
		taxaJuroController.dispose();
		taxaMultaController.dispose();
		taxaDescontoController.dispose();
		valorJuroController.dispose();
		valorMultaController.dispose();
		valorDescontoController.dispose();
		boletoNossoNumeroController.dispose();
		valorRecebidoController.dispose();
		historicoController.dispose();
		super.onClose();
	}
}