import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CteInformacaoNfOutrosController extends GetxController {

	// general
	final gridColumns = cteInformacaoNfOutrosGridColumns();
	
	var cteInformacaoNfOutrosModelList = <CteInformacaoNfOutrosModel>[];

	final _cteInformacaoNfOutrosModel = CteInformacaoNfOutrosModel().obs;
	CteInformacaoNfOutrosModel get cteInformacaoNfOutrosModel => _cteInformacaoNfOutrosModel.value;
	set cteInformacaoNfOutrosModel(value) => _cteInformacaoNfOutrosModel.value = value ?? CteInformacaoNfOutrosModel();
	
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
		for (var cteInformacaoNfOutrosModel in cteInformacaoNfOutrosModelList) {
			plutoRowList.add(_getPlutoRow(cteInformacaoNfOutrosModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteInformacaoNfOutrosModel cteInformacaoNfOutrosModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteInformacaoNfOutrosModel: cteInformacaoNfOutrosModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteInformacaoNfOutrosModel? cteInformacaoNfOutrosModel}) {
		return {
			"id": PlutoCell(value: cteInformacaoNfOutrosModel?.id ?? 0),
			"numeroRomaneio": PlutoCell(value: cteInformacaoNfOutrosModel?.numeroRomaneio ?? ''),
			"numeroPedido": PlutoCell(value: cteInformacaoNfOutrosModel?.numeroPedido ?? ''),
			"chaveAcessoNfe": PlutoCell(value: cteInformacaoNfOutrosModel?.chaveAcessoNfe ?? ''),
			"codigoModelo": PlutoCell(value: cteInformacaoNfOutrosModel?.codigoModelo ?? ''),
			"serie": PlutoCell(value: cteInformacaoNfOutrosModel?.serie ?? ''),
			"numero": PlutoCell(value: cteInformacaoNfOutrosModel?.numero ?? ''),
			"dataEmissao": PlutoCell(value: cteInformacaoNfOutrosModel?.dataEmissao ?? ''),
			"ufEmitente": PlutoCell(value: cteInformacaoNfOutrosModel?.ufEmitente ?? 0),
			"baseCalculoIcms": PlutoCell(value: cteInformacaoNfOutrosModel?.baseCalculoIcms ?? 0),
			"valorIcms": PlutoCell(value: cteInformacaoNfOutrosModel?.valorIcms ?? 0),
			"baseCalculoIcmsSt": PlutoCell(value: cteInformacaoNfOutrosModel?.baseCalculoIcmsSt ?? 0),
			"valorIcmsSt": PlutoCell(value: cteInformacaoNfOutrosModel?.valorIcmsSt ?? 0),
			"valorTotalProdutos": PlutoCell(value: cteInformacaoNfOutrosModel?.valorTotalProdutos ?? 0),
			"valorTotal": PlutoCell(value: cteInformacaoNfOutrosModel?.valorTotal ?? 0),
			"cfopPredominante": PlutoCell(value: cteInformacaoNfOutrosModel?.cfopPredominante ?? 0),
			"pesoTotalKg": PlutoCell(value: cteInformacaoNfOutrosModel?.pesoTotalKg ?? 0),
			"pinSuframa": PlutoCell(value: cteInformacaoNfOutrosModel?.pinSuframa ?? 0),
			"dataPrevistaEntrega": PlutoCell(value: cteInformacaoNfOutrosModel?.dataPrevistaEntrega ?? ''),
			"outroTipoDocOrig": PlutoCell(value: cteInformacaoNfOutrosModel?.outroTipoDocOrig ?? ''),
			"outroDescricao": PlutoCell(value: cteInformacaoNfOutrosModel?.outroDescricao ?? ''),
			"outroValorDocumento": PlutoCell(value: cteInformacaoNfOutrosModel?.outroValorDocumento ?? 0),
			"idCteCabecalho": PlutoCell(value: cteInformacaoNfOutrosModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteInformacaoNfOutrosModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteInformacaoNfOutrosModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroRomaneioController.text = currentRow.cells['numeroRomaneio']?.value ?? '';
			numeroPedidoController.text = currentRow.cells['numeroPedido']?.value ?? '';
			chaveAcessoNfeController.text = currentRow.cells['chaveAcessoNfe']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			ufEmitenteController.text = currentRow.cells['ufEmitente']?.value?.toString() ?? '';
			baseCalculoIcmsController.text = currentRow.cells['baseCalculoIcms']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsController.text = currentRow.cells['valorIcms']?.value?.toStringAsFixed(2) ?? '';
			baseCalculoIcmsStController.text = currentRow.cells['baseCalculoIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorIcmsStController.text = currentRow.cells['valorIcmsSt']?.value?.toStringAsFixed(2) ?? '';
			valorTotalProdutosController.text = currentRow.cells['valorTotalProdutos']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			cfopPredominanteController.text = currentRow.cells['cfopPredominante']?.value?.toString() ?? '';
			pesoTotalKgController.text = currentRow.cells['pesoTotalKg']?.value?.toStringAsFixed(2) ?? '';
			pinSuframaController.text = currentRow.cells['pinSuframa']?.value?.toString() ?? '';
			outroDescricaoController.text = currentRow.cells['outroDescricao']?.value ?? '';
			outroValorDocumentoController.text = currentRow.cells['outroValorDocumento']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteInformacaoNfOutrosEditPage());
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
	final numeroRomaneioController = TextEditingController();
	final numeroPedidoController = TextEditingController();
	final chaveAcessoNfeController = TextEditingController();
	final numeroController = TextEditingController();
	final ufEmitenteController = TextEditingController();
	final baseCalculoIcmsController = MoneyMaskedTextController();
	final valorIcmsController = MoneyMaskedTextController();
	final baseCalculoIcmsStController = MoneyMaskedTextController();
	final valorIcmsStController = MoneyMaskedTextController();
	final valorTotalProdutosController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();
	final cfopPredominanteController = TextEditingController();
	final pesoTotalKgController = MoneyMaskedTextController();
	final pinSuframaController = TextEditingController();
	final outroDescricaoController = TextEditingController();
	final outroValorDocumentoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteInformacaoNfOutrosModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteInformacaoNfOutrosModel.idCteCabecalho;
		plutoRow.cells['numeroRomaneio']?.value = cteInformacaoNfOutrosModel.numeroRomaneio;
		plutoRow.cells['numeroPedido']?.value = cteInformacaoNfOutrosModel.numeroPedido;
		plutoRow.cells['chaveAcessoNfe']?.value = cteInformacaoNfOutrosModel.chaveAcessoNfe;
		plutoRow.cells['codigoModelo']?.value = cteInformacaoNfOutrosModel.codigoModelo;
		plutoRow.cells['serie']?.value = cteInformacaoNfOutrosModel.serie;
		plutoRow.cells['numero']?.value = cteInformacaoNfOutrosModel.numero;
		plutoRow.cells['dataEmissao']?.value = Util.formatDate(cteInformacaoNfOutrosModel.dataEmissao);
		plutoRow.cells['ufEmitente']?.value = cteInformacaoNfOutrosModel.ufEmitente;
		plutoRow.cells['baseCalculoIcms']?.value = cteInformacaoNfOutrosModel.baseCalculoIcms;
		plutoRow.cells['valorIcms']?.value = cteInformacaoNfOutrosModel.valorIcms;
		plutoRow.cells['baseCalculoIcmsSt']?.value = cteInformacaoNfOutrosModel.baseCalculoIcmsSt;
		plutoRow.cells['valorIcmsSt']?.value = cteInformacaoNfOutrosModel.valorIcmsSt;
		plutoRow.cells['valorTotalProdutos']?.value = cteInformacaoNfOutrosModel.valorTotalProdutos;
		plutoRow.cells['valorTotal']?.value = cteInformacaoNfOutrosModel.valorTotal;
		plutoRow.cells['cfopPredominante']?.value = cteInformacaoNfOutrosModel.cfopPredominante;
		plutoRow.cells['pesoTotalKg']?.value = cteInformacaoNfOutrosModel.pesoTotalKg;
		plutoRow.cells['pinSuframa']?.value = cteInformacaoNfOutrosModel.pinSuframa;
		plutoRow.cells['dataPrevistaEntrega']?.value = Util.formatDate(cteInformacaoNfOutrosModel.dataPrevistaEntrega);
		plutoRow.cells['outroTipoDocOrig']?.value = cteInformacaoNfOutrosModel.outroTipoDocOrig;
		plutoRow.cells['outroDescricao']?.value = cteInformacaoNfOutrosModel.outroDescricao;
		plutoRow.cells['outroValorDocumento']?.value = cteInformacaoNfOutrosModel.outroValorDocumento;
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
		cteInformacaoNfOutrosModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteInformacaoNfOutrosModel();
			model.plutoRowToObject(plutoRow);
			cteInformacaoNfOutrosModelList.add(model);
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
		numeroRomaneioController.dispose();
		numeroPedidoController.dispose();
		chaveAcessoNfeController.dispose();
		numeroController.dispose();
		ufEmitenteController.dispose();
		baseCalculoIcmsController.dispose();
		valorIcmsController.dispose();
		baseCalculoIcmsStController.dispose();
		valorIcmsStController.dispose();
		valorTotalProdutosController.dispose();
		valorTotalController.dispose();
		cfopPredominanteController.dispose();
		pesoTotalKgController.dispose();
		pinSuframaController.dispose();
		outroDescricaoController.dispose();
		outroValorDocumentoController.dispose();
		super.onClose();
	}
}