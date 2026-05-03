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

class NfeDetalheImpostoIcmsController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoIcmsGridColumns();
	
	var nfeDetalheImpostoIcmsModelList = <NfeDetalheImpostoIcmsModel>[];

	final _nfeDetalheImpostoIcmsModel = NfeDetalheImpostoIcmsModel().obs;
	NfeDetalheImpostoIcmsModel get nfeDetalheImpostoIcmsModel => _nfeDetalheImpostoIcmsModel.value;
	set nfeDetalheImpostoIcmsModel(value) => _nfeDetalheImpostoIcmsModel.value = value ?? NfeDetalheImpostoIcmsModel();
	
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
		for (var nfeDetalheImpostoIcmsModel in nfeDetalheImpostoIcmsModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoIcmsModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoIcmsModel nfeDetalheImpostoIcmsModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoIcmsModel: nfeDetalheImpostoIcmsModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoIcmsModel? nfeDetalheImpostoIcmsModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoIcmsModel?.id ?? 0),
			"origemMercadoria": PlutoCell(value: nfeDetalheImpostoIcmsModel?.origemMercadoria ?? ''),
			"cstIcms": PlutoCell(value: nfeDetalheImpostoIcmsModel?.cstIcms ?? ''),
			"csosn": PlutoCell(value: nfeDetalheImpostoIcmsModel?.csosn ?? ''),
			"modalidadeBcIcms": PlutoCell(value: nfeDetalheImpostoIcmsModel?.modalidadeBcIcms ?? ''),
			"percentualReducaoBcIcms": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualReducaoBcIcms ?? 0),
			"valorBcIcms": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorBcIcms ?? 0),
			"aliquotaIcms": PlutoCell(value: nfeDetalheImpostoIcmsModel?.aliquotaIcms ?? 0),
			"valorIcmsOperacao": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsOperacao ?? 0),
			"percentualDiferimento": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualDiferimento ?? 0),
			"valorIcmsDiferido": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsDiferido ?? 0),
			"valorIcms": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcms ?? 0),
			"baseCalculoFcp": PlutoCell(value: nfeDetalheImpostoIcmsModel?.baseCalculoFcp ?? 0),
			"percentualFcp": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualFcp ?? 0),
			"valorFcp": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorFcp ?? 0),
			"modalidadeBcIcmsSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.modalidadeBcIcmsSt ?? ''),
			"percentualMvaIcmsSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualMvaIcmsSt ?? 0),
			"percentualReducaoBcIcmsSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualReducaoBcIcmsSt ?? 0),
			"valorBaseCalculoIcmsSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorBaseCalculoIcmsSt ?? 0),
			"aliquotaIcmsSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.aliquotaIcmsSt ?? 0),
			"valorIcmsSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsSt ?? 0),
			"baseCalculoFcpSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.baseCalculoFcpSt ?? 0),
			"percentualFcpSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualFcpSt ?? 0),
			"valorFcpSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorFcpSt ?? 0),
			"ufSt": PlutoCell(value: nfeDetalheImpostoIcmsModel?.ufSt ?? ''),
			"percentualBcOperacaoPropria": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualBcOperacaoPropria ?? 0),
			"valorBcIcmsStRetido": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorBcIcmsStRetido ?? 0),
			"aliquotaSuportadaConsumidor": PlutoCell(value: nfeDetalheImpostoIcmsModel?.aliquotaSuportadaConsumidor ?? 0),
			"valorIcmsSubstituto": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsSubstituto ?? 0),
			"valorIcmsStRetido": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsStRetido ?? 0),
			"baseCalculoFcpStRetido": PlutoCell(value: nfeDetalheImpostoIcmsModel?.baseCalculoFcpStRetido ?? 0),
			"percentualFcpStRetido": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualFcpStRetido ?? 0),
			"valorFcpStRetido": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorFcpStRetido ?? 0),
			"motivoDesoneracaoIcms": PlutoCell(value: nfeDetalheImpostoIcmsModel?.motivoDesoneracaoIcms ?? ''),
			"valorIcmsDesonerado": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsDesonerado ?? 0),
			"aliquotaCreditoIcmsSn": PlutoCell(value: nfeDetalheImpostoIcmsModel?.aliquotaCreditoIcmsSn ?? 0),
			"valorCreditoIcmsSn": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorCreditoIcmsSn ?? 0),
			"valorBcIcmsStDestino": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorBcIcmsStDestino ?? 0),
			"valorIcmsStDestino": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsStDestino ?? 0),
			"percentualReducaoBcEfetivo": PlutoCell(value: nfeDetalheImpostoIcmsModel?.percentualReducaoBcEfetivo ?? 0),
			"valorBcEfetivo": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorBcEfetivo ?? 0),
			"aliquotaIcmsEfetivo": PlutoCell(value: nfeDetalheImpostoIcmsModel?.aliquotaIcmsEfetivo ?? 0),
			"valorIcmsEfetivo": PlutoCell(value: nfeDetalheImpostoIcmsModel?.valorIcmsEfetivo ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoIcmsModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoIcmsModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoIcmsModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			percentualReducaoBcIcmsController.text = currentRow.cells['percentualReducaoBcIcms']?.value?.toStringAsFixed(2) ?? '';
			valorBcIcmsController.text = currentRow.cells['valorBcIcms']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsController.text = currentRow.cells['aliquotaIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsOperacaoController.text = currentRow.cells['valorIcmsOperacao']?.value?.toStringAsFixed(2) ?? '';
			percentualDiferimentoController.text = currentRow.cells['percentualDiferimento']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsDiferidoController.text = currentRow.cells['valorIcmsDiferido']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsController.text = currentRow.cells['valorIcms']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoFcpController.text = currentRow.cells['baseCalculoFcp']?.value?.toStringAsFixed(2) ?? '';
			percentualFcpController.text = currentRow.cells['percentualFcp']?.value?.toStringAsFixed(2) ?? '';
			valorFcpController.text = currentRow.cells['valorFcp']?.value?.toStringAsFixed(2) ?? '';
			percentualMvaIcmsStController.text = currentRow.cells['percentualMvaIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			percentualReducaoBcIcmsStController.text = currentRow.cells['percentualReducaoBcIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorBaseCalculoIcmsStController.text = currentRow.cells['valorBaseCalculoIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsStController.text = currentRow.cells['aliquotaIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsStController.text = currentRow.cells['valorIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoFcpStController.text = currentRow.cells['baseCalculoFcpSt']?.value?.toStringAsFixed(2) ?? '';
			percentualFcpStController.text = currentRow.cells['percentualFcpSt']?.value?.toStringAsFixed(2) ?? '';
			valorFcpStController.text = currentRow.cells['valorFcpSt']?.value?.toStringAsFixed(2) ?? '';
			percentualBcOperacaoPropriaController.text = currentRow.cells['percentualBcOperacaoPropria']?.value?.toStringAsFixed(2) ?? '';
			valorBcIcmsStRetidoController.text = currentRow.cells['valorBcIcmsStRetido']?.value?.toStringAsFixed(2) ?? '';
			aliquotaSuportadaConsumidorController.text = currentRow.cells['aliquotaSuportadaConsumidor']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsSubstitutoController.text = currentRow.cells['valorIcmsSubstituto']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsStRetidoController.text = currentRow.cells['valorIcmsStRetido']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoFcpStRetidoController.text = currentRow.cells['baseCalculoFcpStRetido']?.value?.toStringAsFixed(2) ?? '';
			percentualFcpStRetidoController.text = currentRow.cells['percentualFcpStRetido']?.value?.toStringAsFixed(2) ?? '';
			valorFcpStRetidoController.text = currentRow.cells['valorFcpStRetido']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsDesoneradoController.text = currentRow.cells['valorIcmsDesonerado']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCreditoIcmsSnController.text = currentRow.cells['aliquotaCreditoIcmsSn']?.value?.toStringAsFixed(2) ?? '';
			valorCreditoIcmsSnController.text = currentRow.cells['valorCreditoIcmsSn']?.value?.toStringAsFixed(2) ?? '';
			valorBcIcmsStDestinoController.text = currentRow.cells['valorBcIcmsStDestino']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsStDestinoController.text = currentRow.cells['valorIcmsStDestino']?.value?.toStringAsFixed(2) ?? '';
			percentualReducaoBcEfetivoController.text = currentRow.cells['percentualReducaoBcEfetivo']?.value?.toStringAsFixed(2) ?? '';
			valorBcEfetivoController.text = currentRow.cells['valorBcEfetivo']?.value?.toStringAsFixed(2) ?? '';
			aliquotaIcmsEfetivoController.text = currentRow.cells['aliquotaIcmsEfetivo']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsEfetivoController.text = currentRow.cells['valorIcmsEfetivo']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoIcmsEditPage());
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
	final percentualReducaoBcIcmsController = MoneyMaskedTextController();
	final valorBcIcmsController = MoneyMaskedTextController();
	final aliquotaIcmsController = MoneyMaskedTextController();
	final valorIcmsOperacaoController = MoneyMaskedTextController();
	final percentualDiferimentoController = MoneyMaskedTextController();
	final valorIcmsDiferidoController = MoneyMaskedTextController();
	final valorIcmsController = MoneyMaskedTextController();
	final baseCalculoFcpController = MoneyMaskedTextController();
	final percentualFcpController = MoneyMaskedTextController();
	final valorFcpController = MoneyMaskedTextController();
	final percentualMvaIcmsStController = MoneyMaskedTextController();
	final percentualReducaoBcIcmsStController = MoneyMaskedTextController();
	final valorBaseCalculoIcmsStController = MoneyMaskedTextController();
	final aliquotaIcmsStController = MoneyMaskedTextController();
	final valorIcmsStController = MoneyMaskedTextController();
	final baseCalculoFcpStController = MoneyMaskedTextController();
	final percentualFcpStController = MoneyMaskedTextController();
	final valorFcpStController = MoneyMaskedTextController();
	final percentualBcOperacaoPropriaController = MoneyMaskedTextController();
	final valorBcIcmsStRetidoController = MoneyMaskedTextController();
	final aliquotaSuportadaConsumidorController = MoneyMaskedTextController();
	final valorIcmsSubstitutoController = MoneyMaskedTextController();
	final valorIcmsStRetidoController = MoneyMaskedTextController();
	final baseCalculoFcpStRetidoController = MoneyMaskedTextController();
	final percentualFcpStRetidoController = MoneyMaskedTextController();
	final valorFcpStRetidoController = MoneyMaskedTextController();
	final valorIcmsDesoneradoController = MoneyMaskedTextController();
	final aliquotaCreditoIcmsSnController = MoneyMaskedTextController();
	final valorCreditoIcmsSnController = MoneyMaskedTextController();
	final valorBcIcmsStDestinoController = MoneyMaskedTextController();
	final valorIcmsStDestinoController = MoneyMaskedTextController();
	final percentualReducaoBcEfetivoController = MoneyMaskedTextController();
	final valorBcEfetivoController = MoneyMaskedTextController();
	final aliquotaIcmsEfetivoController = MoneyMaskedTextController();
	final valorIcmsEfetivoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoIcmsModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoIcmsModel.idNfeDetalhe;
		plutoRow.cells['origemMercadoria']?.value = nfeDetalheImpostoIcmsModel.origemMercadoria;
		plutoRow.cells['cstIcms']?.value = nfeDetalheImpostoIcmsModel.cstIcms;
		plutoRow.cells['csosn']?.value = nfeDetalheImpostoIcmsModel.csosn;
		plutoRow.cells['modalidadeBcIcms']?.value = nfeDetalheImpostoIcmsModel.modalidadeBcIcms;
		plutoRow.cells['percentualReducaoBcIcms']?.value = nfeDetalheImpostoIcmsModel.percentualReducaoBcIcms;
		plutoRow.cells['valorBcIcms']?.value = nfeDetalheImpostoIcmsModel.valorBcIcms;
		plutoRow.cells['aliquotaIcms']?.value = nfeDetalheImpostoIcmsModel.aliquotaIcms;
		plutoRow.cells['valorIcmsOperacao']?.value = nfeDetalheImpostoIcmsModel.valorIcmsOperacao;
		plutoRow.cells['percentualDiferimento']?.value = nfeDetalheImpostoIcmsModel.percentualDiferimento;
		plutoRow.cells['valorIcmsDiferido']?.value = nfeDetalheImpostoIcmsModel.valorIcmsDiferido;
		plutoRow.cells['valorIcms']?.value = nfeDetalheImpostoIcmsModel.valorIcms;
		plutoRow.cells['baseCalculoFcp']?.value = nfeDetalheImpostoIcmsModel.baseCalculoFcp;
		plutoRow.cells['percentualFcp']?.value = nfeDetalheImpostoIcmsModel.percentualFcp;
		plutoRow.cells['valorFcp']?.value = nfeDetalheImpostoIcmsModel.valorFcp;
		plutoRow.cells['modalidadeBcIcmsSt']?.value = nfeDetalheImpostoIcmsModel.modalidadeBcIcmsSt;
		plutoRow.cells['percentualMvaIcmsSt']?.value = nfeDetalheImpostoIcmsModel.percentualMvaIcmsSt;
		plutoRow.cells['percentualReducaoBcIcmsSt']?.value = nfeDetalheImpostoIcmsModel.percentualReducaoBcIcmsSt;
		plutoRow.cells['valorBaseCalculoIcmsSt']?.value = nfeDetalheImpostoIcmsModel.valorBaseCalculoIcmsSt;
		plutoRow.cells['aliquotaIcmsSt']?.value = nfeDetalheImpostoIcmsModel.aliquotaIcmsSt;
		plutoRow.cells['valorIcmsSt']?.value = nfeDetalheImpostoIcmsModel.valorIcmsSt;
		plutoRow.cells['baseCalculoFcpSt']?.value = nfeDetalheImpostoIcmsModel.baseCalculoFcpSt;
		plutoRow.cells['percentualFcpSt']?.value = nfeDetalheImpostoIcmsModel.percentualFcpSt;
		plutoRow.cells['valorFcpSt']?.value = nfeDetalheImpostoIcmsModel.valorFcpSt;
		plutoRow.cells['ufSt']?.value = nfeDetalheImpostoIcmsModel.ufSt;
		plutoRow.cells['percentualBcOperacaoPropria']?.value = nfeDetalheImpostoIcmsModel.percentualBcOperacaoPropria;
		plutoRow.cells['valorBcIcmsStRetido']?.value = nfeDetalheImpostoIcmsModel.valorBcIcmsStRetido;
		plutoRow.cells['aliquotaSuportadaConsumidor']?.value = nfeDetalheImpostoIcmsModel.aliquotaSuportadaConsumidor;
		plutoRow.cells['valorIcmsSubstituto']?.value = nfeDetalheImpostoIcmsModel.valorIcmsSubstituto;
		plutoRow.cells['valorIcmsStRetido']?.value = nfeDetalheImpostoIcmsModel.valorIcmsStRetido;
		plutoRow.cells['baseCalculoFcpStRetido']?.value = nfeDetalheImpostoIcmsModel.baseCalculoFcpStRetido;
		plutoRow.cells['percentualFcpStRetido']?.value = nfeDetalheImpostoIcmsModel.percentualFcpStRetido;
		plutoRow.cells['valorFcpStRetido']?.value = nfeDetalheImpostoIcmsModel.valorFcpStRetido;
		plutoRow.cells['motivoDesoneracaoIcms']?.value = nfeDetalheImpostoIcmsModel.motivoDesoneracaoIcms;
		plutoRow.cells['valorIcmsDesonerado']?.value = nfeDetalheImpostoIcmsModel.valorIcmsDesonerado;
		plutoRow.cells['aliquotaCreditoIcmsSn']?.value = nfeDetalheImpostoIcmsModel.aliquotaCreditoIcmsSn;
		plutoRow.cells['valorCreditoIcmsSn']?.value = nfeDetalheImpostoIcmsModel.valorCreditoIcmsSn;
		plutoRow.cells['valorBcIcmsStDestino']?.value = nfeDetalheImpostoIcmsModel.valorBcIcmsStDestino;
		plutoRow.cells['valorIcmsStDestino']?.value = nfeDetalheImpostoIcmsModel.valorIcmsStDestino;
		plutoRow.cells['percentualReducaoBcEfetivo']?.value = nfeDetalheImpostoIcmsModel.percentualReducaoBcEfetivo;
		plutoRow.cells['valorBcEfetivo']?.value = nfeDetalheImpostoIcmsModel.valorBcEfetivo;
		plutoRow.cells['aliquotaIcmsEfetivo']?.value = nfeDetalheImpostoIcmsModel.aliquotaIcmsEfetivo;
		plutoRow.cells['valorIcmsEfetivo']?.value = nfeDetalheImpostoIcmsModel.valorIcmsEfetivo;
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
		nfeDetalheImpostoIcmsModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoIcmsModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoIcmsModelList.add(model);
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
		percentualReducaoBcIcmsController.dispose();
		valorBcIcmsController.dispose();
		aliquotaIcmsController.dispose();
		valorIcmsOperacaoController.dispose();
		percentualDiferimentoController.dispose();
		valorIcmsDiferidoController.dispose();
		valorIcmsController.dispose();
		baseCalculoFcpController.dispose();
		percentualFcpController.dispose();
		valorFcpController.dispose();
		percentualMvaIcmsStController.dispose();
		percentualReducaoBcIcmsStController.dispose();
		valorBaseCalculoIcmsStController.dispose();
		aliquotaIcmsStController.dispose();
		valorIcmsStController.dispose();
		baseCalculoFcpStController.dispose();
		percentualFcpStController.dispose();
		valorFcpStController.dispose();
		percentualBcOperacaoPropriaController.dispose();
		valorBcIcmsStRetidoController.dispose();
		aliquotaSuportadaConsumidorController.dispose();
		valorIcmsSubstitutoController.dispose();
		valorIcmsStRetidoController.dispose();
		baseCalculoFcpStRetidoController.dispose();
		percentualFcpStRetidoController.dispose();
		valorFcpStRetidoController.dispose();
		valorIcmsDesoneradoController.dispose();
		aliquotaCreditoIcmsSnController.dispose();
		valorCreditoIcmsSnController.dispose();
		valorBcIcmsStDestinoController.dispose();
		valorIcmsStDestinoController.dispose();
		percentualReducaoBcEfetivoController.dispose();
		valorBcEfetivoController.dispose();
		aliquotaIcmsEfetivoController.dispose();
		valorIcmsEfetivoController.dispose();
		super.onClose();
	}
}