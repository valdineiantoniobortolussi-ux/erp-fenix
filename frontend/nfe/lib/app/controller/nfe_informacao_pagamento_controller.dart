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

class NfeInformacaoPagamentoController extends GetxController {

	// general
	final gridColumns = nfeInformacaoPagamentoGridColumns();
	
	var nfeInformacaoPagamentoModelList = <NfeInformacaoPagamentoModel>[];

	final _nfeInformacaoPagamentoModel = NfeInformacaoPagamentoModel().obs;
	NfeInformacaoPagamentoModel get nfeInformacaoPagamentoModel => _nfeInformacaoPagamentoModel.value;
	set nfeInformacaoPagamentoModel(value) => _nfeInformacaoPagamentoModel.value = value ?? NfeInformacaoPagamentoModel();
	
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
		for (var nfeInformacaoPagamentoModel in nfeInformacaoPagamentoModelList) {
			plutoRowList.add(_getPlutoRow(nfeInformacaoPagamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeInformacaoPagamentoModel nfeInformacaoPagamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeInformacaoPagamentoModel: nfeInformacaoPagamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeInformacaoPagamentoModel? nfeInformacaoPagamentoModel}) {
		return {
			"id": PlutoCell(value: nfeInformacaoPagamentoModel?.id ?? 0),
			"indicadorPagamento": PlutoCell(value: nfeInformacaoPagamentoModel?.indicadorPagamento ?? ''),
			"meioPagamento": PlutoCell(value: nfeInformacaoPagamentoModel?.meioPagamento ?? ''),
			"valor": PlutoCell(value: nfeInformacaoPagamentoModel?.valor ?? 0),
			"tipoIntegracao": PlutoCell(value: nfeInformacaoPagamentoModel?.tipoIntegracao ?? ''),
			"cnpjOperadoraCartao": PlutoCell(value: nfeInformacaoPagamentoModel?.cnpjOperadoraCartao ?? ''),
			"bandeira": PlutoCell(value: nfeInformacaoPagamentoModel?.bandeira ?? ''),
			"numeroAutorizacao": PlutoCell(value: nfeInformacaoPagamentoModel?.numeroAutorizacao ?? ''),
			"troco": PlutoCell(value: nfeInformacaoPagamentoModel?.troco ?? 0),
			"idNfeCabecalho": PlutoCell(value: nfeInformacaoPagamentoModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeInformacaoPagamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeInformacaoPagamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			cnpjOperadoraCartaoController.text = currentRow.cells['cnpjOperadoraCartao']?.value ?? '';
			numeroAutorizacaoController.text = currentRow.cells['numeroAutorizacao']?.value ?? '';
			trocoController.text = currentRow.cells['troco']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeInformacaoPagamentoEditPage());
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
	final valorController = MoneyMaskedTextController();
	final cnpjOperadoraCartaoController = MaskedTextController(mask: '00.000.000/0000-00',);
	final numeroAutorizacaoController = TextEditingController();
	final trocoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeInformacaoPagamentoModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeInformacaoPagamentoModel.idNfeCabecalho;
		plutoRow.cells['indicadorPagamento']?.value = nfeInformacaoPagamentoModel.indicadorPagamento;
		plutoRow.cells['meioPagamento']?.value = nfeInformacaoPagamentoModel.meioPagamento;
		plutoRow.cells['valor']?.value = nfeInformacaoPagamentoModel.valor;
		plutoRow.cells['tipoIntegracao']?.value = nfeInformacaoPagamentoModel.tipoIntegracao;
		plutoRow.cells['cnpjOperadoraCartao']?.value = nfeInformacaoPagamentoModel.cnpjOperadoraCartao;
		plutoRow.cells['bandeira']?.value = nfeInformacaoPagamentoModel.bandeira;
		plutoRow.cells['numeroAutorizacao']?.value = nfeInformacaoPagamentoModel.numeroAutorizacao;
		plutoRow.cells['troco']?.value = nfeInformacaoPagamentoModel.troco;
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
		nfeInformacaoPagamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeInformacaoPagamentoModel();
			model.plutoRowToObject(plutoRow);
			nfeInformacaoPagamentoModelList.add(model);
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
		valorController.dispose();
		cnpjOperadoraCartaoController.dispose();
		numeroAutorizacaoController.dispose();
		trocoController.dispose();
		super.onClose();
	}
}