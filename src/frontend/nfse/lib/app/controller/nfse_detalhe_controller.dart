import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:nfse/app/controller/controller_imports.dart';
import 'package:nfse/app/routes/app_routes.dart';

import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/data/model/model_imports.dart';
import 'package:nfse/app/page/page_imports.dart';
import 'package:nfse/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfse/app/page/shared_widget/message_dialog.dart';

class NfseDetalheController extends GetxController {

	// general
	final gridColumns = nfseDetalheGridColumns();
	
	var nfseDetalheModelList = <NfseDetalheModel>[];

	final _nfseDetalheModel = NfseDetalheModel().obs;
	NfseDetalheModel get nfseDetalheModel => _nfseDetalheModel.value;
	set nfseDetalheModel(value) => _nfseDetalheModel.value = value ?? NfseDetalheModel();
	
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
		for (var nfseDetalheModel in nfseDetalheModelList) {
			plutoRowList.add(_getPlutoRow(nfseDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfseDetalheModel nfseDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfseDetalheModel: nfseDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfseDetalheModel? nfseDetalheModel}) {
		return {
			"id": PlutoCell(value: nfseDetalheModel?.id ?? 0),
			"nfseListaServico": PlutoCell(value: nfseDetalheModel?.nfseListaServicoModel?.descricao ?? ''),
			"codigoCnae": PlutoCell(value: nfseDetalheModel?.codigoCnae ?? ''),
			"codigoTributacaoMunicipio": PlutoCell(value: nfseDetalheModel?.codigoTributacaoMunicipio ?? ''),
			"valorServicos": PlutoCell(value: nfseDetalheModel?.valorServicos ?? 0),
			"valorDeducoes": PlutoCell(value: nfseDetalheModel?.valorDeducoes ?? 0),
			"valorPis": PlutoCell(value: nfseDetalheModel?.valorPis ?? 0),
			"valorCofins": PlutoCell(value: nfseDetalheModel?.valorCofins ?? 0),
			"valorInss": PlutoCell(value: nfseDetalheModel?.valorInss ?? 0),
			"valorIr": PlutoCell(value: nfseDetalheModel?.valorIr ?? 0),
			"valorCsll": PlutoCell(value: nfseDetalheModel?.valorCsll ?? 0),
			"valorBaseCalculo": PlutoCell(value: nfseDetalheModel?.valorBaseCalculo ?? 0),
			"aliquota": PlutoCell(value: nfseDetalheModel?.aliquota ?? 0),
			"valorIss": PlutoCell(value: nfseDetalheModel?.valorIss ?? 0),
			"valorLiquido": PlutoCell(value: nfseDetalheModel?.valorLiquido ?? 0),
			"outrasRetencoes": PlutoCell(value: nfseDetalheModel?.outrasRetencoes ?? 0),
			"valorCredito": PlutoCell(value: nfseDetalheModel?.valorCredito ?? 0),
			"issRetido": PlutoCell(value: nfseDetalheModel?.issRetido ?? ''),
			"valorIssRetido": PlutoCell(value: nfseDetalheModel?.valorIssRetido ?? 0),
			"valorDescontoCondicionado": PlutoCell(value: nfseDetalheModel?.valorDescontoCondicionado ?? 0),
			"valorDescontoIncondicionado": PlutoCell(value: nfseDetalheModel?.valorDescontoIncondicionado ?? 0),
			"municipioPrestacao": PlutoCell(value: nfseDetalheModel?.municipioPrestacao ?? 0),
			"discriminacao": PlutoCell(value: nfseDetalheModel?.discriminacao ?? ''),
			"idNfseCabecalho": PlutoCell(value: nfseDetalheModel?.idNfseCabecalho ?? 0),
			"idNfseListaServico": PlutoCell(value: nfseDetalheModel?.idNfseListaServico ?? 0),
		};
	}

	void plutoRowToObject() {
		nfseDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfseDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nfseListaServicoModelController.text = currentRow.cells['nfseListaServico']?.value ?? '';
			codigoCnaeController.text = currentRow.cells['codigoCnae']?.value ?? '';
			codigoTributacaoMunicipioController.text = currentRow.cells['codigoTributacaoMunicipio']?.value ?? '';
			valorServicosController.text = currentRow.cells['valorServicos']?.value?.toStringAsFixed(2) ?? '';
			valorDeducoesController.text = currentRow.cells['valorDeducoes']?.value?.toStringAsFixed(2) ?? '';
			valorPisController.text = currentRow.cells['valorPis']?.value?.toStringAsFixed(2) ?? '';
			valorCofinsController.text = currentRow.cells['valorCofins']?.value?.toStringAsFixed(2) ?? '';
			valorInssController.text = currentRow.cells['valorInss']?.value?.toStringAsFixed(2) ?? '';
			valorIrController.text = currentRow.cells['valorIr']?.value?.toStringAsFixed(2) ?? '';
			valorCsllController.text = currentRow.cells['valorCsll']?.value?.toStringAsFixed(2) ?? '';
			valorBaseCalculoController.text = currentRow.cells['valorBaseCalculo']?.value?.toStringAsFixed(2) ?? '';
			aliquotaController.text = currentRow.cells['aliquota']?.value?.toStringAsFixed(2) ?? '';
			valorIssController.text = currentRow.cells['valorIss']?.value?.toStringAsFixed(2) ?? '';
			valorLiquidoController.text = currentRow.cells['valorLiquido']?.value?.toStringAsFixed(2) ?? '';
			outrasRetencoesController.text = currentRow.cells['outrasRetencoes']?.value?.toStringAsFixed(2) ?? '';
			valorCreditoController.text = currentRow.cells['valorCredito']?.value?.toStringAsFixed(2) ?? '';
			valorIssRetidoController.text = currentRow.cells['valorIssRetido']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoCondicionadoController.text = currentRow.cells['valorDescontoCondicionado']?.value?.toStringAsFixed(2) ?? '';
			valorDescontoIncondicionadoController.text = currentRow.cells['valorDescontoIncondicionado']?.value?.toStringAsFixed(2) ?? '';
			municipioPrestacaoController.text = currentRow.cells['municipioPrestacao']?.value?.toString() ?? '';
			discriminacaoController.text = currentRow.cells['discriminacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfseDetalheEditPage());
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
	final nfseListaServicoModelController = TextEditingController();
	final codigoCnaeController = TextEditingController();
	final codigoTributacaoMunicipioController = TextEditingController();
	final valorServicosController = MoneyMaskedTextController();
	final valorDeducoesController = MoneyMaskedTextController();
	final valorPisController = MoneyMaskedTextController();
	final valorCofinsController = MoneyMaskedTextController();
	final valorInssController = MoneyMaskedTextController();
	final valorIrController = MoneyMaskedTextController();
	final valorCsllController = MoneyMaskedTextController();
	final valorBaseCalculoController = MoneyMaskedTextController();
	final aliquotaController = MoneyMaskedTextController();
	final valorIssController = MoneyMaskedTextController();
	final valorLiquidoController = MoneyMaskedTextController();
	final outrasRetencoesController = MoneyMaskedTextController();
	final valorCreditoController = MoneyMaskedTextController();
	final valorIssRetidoController = MoneyMaskedTextController();
	final valorDescontoCondicionadoController = MoneyMaskedTextController();
	final valorDescontoIncondicionadoController = MoneyMaskedTextController();
	final municipioPrestacaoController = TextEditingController();
	final discriminacaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfseDetalheModel.id;
		plutoRow.cells['idNfseCabecalho']?.value = nfseDetalheModel.idNfseCabecalho;
		plutoRow.cells['idNfseListaServico']?.value = nfseDetalheModel.idNfseListaServico;
		plutoRow.cells['nfseListaServico']?.value = nfseDetalheModel.nfseListaServicoModel?.descricao;
		plutoRow.cells['codigoCnae']?.value = nfseDetalheModel.codigoCnae;
		plutoRow.cells['codigoTributacaoMunicipio']?.value = nfseDetalheModel.codigoTributacaoMunicipio;
		plutoRow.cells['valorServicos']?.value = nfseDetalheModel.valorServicos;
		plutoRow.cells['valorDeducoes']?.value = nfseDetalheModel.valorDeducoes;
		plutoRow.cells['valorPis']?.value = nfseDetalheModel.valorPis;
		plutoRow.cells['valorCofins']?.value = nfseDetalheModel.valorCofins;
		plutoRow.cells['valorInss']?.value = nfseDetalheModel.valorInss;
		plutoRow.cells['valorIr']?.value = nfseDetalheModel.valorIr;
		plutoRow.cells['valorCsll']?.value = nfseDetalheModel.valorCsll;
		plutoRow.cells['valorBaseCalculo']?.value = nfseDetalheModel.valorBaseCalculo;
		plutoRow.cells['aliquota']?.value = nfseDetalheModel.aliquota;
		plutoRow.cells['valorIss']?.value = nfseDetalheModel.valorIss;
		plutoRow.cells['valorLiquido']?.value = nfseDetalheModel.valorLiquido;
		plutoRow.cells['outrasRetencoes']?.value = nfseDetalheModel.outrasRetencoes;
		plutoRow.cells['valorCredito']?.value = nfseDetalheModel.valorCredito;
		plutoRow.cells['issRetido']?.value = nfseDetalheModel.issRetido;
		plutoRow.cells['valorIssRetido']?.value = nfseDetalheModel.valorIssRetido;
		plutoRow.cells['valorDescontoCondicionado']?.value = nfseDetalheModel.valorDescontoCondicionado;
		plutoRow.cells['valorDescontoIncondicionado']?.value = nfseDetalheModel.valorDescontoIncondicionado;
		plutoRow.cells['municipioPrestacao']?.value = nfseDetalheModel.municipioPrestacao;
		plutoRow.cells['discriminacao']?.value = nfseDetalheModel.discriminacao;
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
		nfseDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfseDetalheModel();
			model.plutoRowToObject(plutoRow);
			nfseDetalheModelList.add(model);
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

	Future callNfseListaServicoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Lista Serviço]'; 
		lookupController.route = '/nfse-lista-servico/'; 
		lookupController.gridColumns = nfseListaServicoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NfseListaServicoModel.aliasColumns; 
		lookupController.dbColumns = NfseListaServicoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			nfseDetalheModel.idNfseListaServico = plutoRowResult.cells['id']!.value; 
			nfseDetalheModel.nfseListaServicoModel!.plutoRowToObject(plutoRowResult); 
			nfseListaServicoModelController.text = nfseDetalheModel.nfseListaServicoModel?.descricao ?? ''; 
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
		nfseListaServicoModelController.dispose();
		codigoCnaeController.dispose();
		codigoTributacaoMunicipioController.dispose();
		valorServicosController.dispose();
		valorDeducoesController.dispose();
		valorPisController.dispose();
		valorCofinsController.dispose();
		valorInssController.dispose();
		valorIrController.dispose();
		valorCsllController.dispose();
		valorBaseCalculoController.dispose();
		aliquotaController.dispose();
		valorIssController.dispose();
		valorLiquidoController.dispose();
		outrasRetencoesController.dispose();
		valorCreditoController.dispose();
		valorIssRetidoController.dispose();
		valorDescontoCondicionadoController.dispose();
		valorDescontoIncondicionadoController.dispose();
		municipioPrestacaoController.dispose();
		discriminacaoController.dispose();
		super.onClose();
	}
}