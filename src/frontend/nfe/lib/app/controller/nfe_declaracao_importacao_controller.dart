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

class NfeDeclaracaoImportacaoController extends GetxController {

	// general
	final gridColumns = nfeDeclaracaoImportacaoGridColumns();
	
	var nfeDeclaracaoImportacaoModelList = <NfeDeclaracaoImportacaoModel>[];

	final _nfeDeclaracaoImportacaoModel = NfeDeclaracaoImportacaoModel().obs;
	NfeDeclaracaoImportacaoModel get nfeDeclaracaoImportacaoModel => _nfeDeclaracaoImportacaoModel.value;
	set nfeDeclaracaoImportacaoModel(value) => _nfeDeclaracaoImportacaoModel.value = value ?? NfeDeclaracaoImportacaoModel();
	
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
		for (var nfeDeclaracaoImportacaoModel in nfeDeclaracaoImportacaoModelList) {
			plutoRowList.add(_getPlutoRow(nfeDeclaracaoImportacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDeclaracaoImportacaoModel nfeDeclaracaoImportacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDeclaracaoImportacaoModel: nfeDeclaracaoImportacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDeclaracaoImportacaoModel? nfeDeclaracaoImportacaoModel}) {
		return {
			"id": PlutoCell(value: nfeDeclaracaoImportacaoModel?.id ?? 0),
			"numeroDocumento": PlutoCell(value: nfeDeclaracaoImportacaoModel?.numeroDocumento ?? ''),
			"dataRegistro": PlutoCell(value: nfeDeclaracaoImportacaoModel?.dataRegistro ?? ''),
			"localDesembaraco": PlutoCell(value: nfeDeclaracaoImportacaoModel?.localDesembaraco ?? ''),
			"ufDesembaraco": PlutoCell(value: nfeDeclaracaoImportacaoModel?.ufDesembaraco ?? ''),
			"dataDesembaraco": PlutoCell(value: nfeDeclaracaoImportacaoModel?.dataDesembaraco ?? ''),
			"viaTransporte": PlutoCell(value: nfeDeclaracaoImportacaoModel?.viaTransporte ?? ''),
			"valorAfrmm": PlutoCell(value: nfeDeclaracaoImportacaoModel?.valorAfrmm ?? 0),
			"formaIntermediacao": PlutoCell(value: nfeDeclaracaoImportacaoModel?.formaIntermediacao ?? ''),
			"cnpj": PlutoCell(value: nfeDeclaracaoImportacaoModel?.cnpj ?? ''),
			"ufTerceiro": PlutoCell(value: nfeDeclaracaoImportacaoModel?.ufTerceiro ?? ''),
			"codigoExportador": PlutoCell(value: nfeDeclaracaoImportacaoModel?.codigoExportador ?? ''),
			"idNfeDetalhe": PlutoCell(value: nfeDeclaracaoImportacaoModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDeclaracaoImportacaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDeclaracaoImportacaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroDocumentoController.text = currentRow.cells['numeroDocumento']?.value ?? '';
			localDesembaracoController.text = currentRow.cells['localDesembaraco']?.value ?? '';
			valorAfrmmController.text = currentRow.cells['valorAfrmm']?.value?.toStringAsFixed(2) ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			codigoExportadorController.text = currentRow.cells['codigoExportador']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDeclaracaoImportacaoEditPage());
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
	final numeroDocumentoController = TextEditingController();
	final localDesembaracoController = TextEditingController();
	final valorAfrmmController = MoneyMaskedTextController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final codigoExportadorController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDeclaracaoImportacaoModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDeclaracaoImportacaoModel.idNfeDetalhe;
		plutoRow.cells['numeroDocumento']?.value = nfeDeclaracaoImportacaoModel.numeroDocumento;
		plutoRow.cells['dataRegistro']?.value = Util.formatDate(nfeDeclaracaoImportacaoModel.dataRegistro);
		plutoRow.cells['localDesembaraco']?.value = nfeDeclaracaoImportacaoModel.localDesembaraco;
		plutoRow.cells['ufDesembaraco']?.value = nfeDeclaracaoImportacaoModel.ufDesembaraco;
		plutoRow.cells['dataDesembaraco']?.value = Util.formatDate(nfeDeclaracaoImportacaoModel.dataDesembaraco);
		plutoRow.cells['viaTransporte']?.value = nfeDeclaracaoImportacaoModel.viaTransporte;
		plutoRow.cells['valorAfrmm']?.value = nfeDeclaracaoImportacaoModel.valorAfrmm;
		plutoRow.cells['formaIntermediacao']?.value = nfeDeclaracaoImportacaoModel.formaIntermediacao;
		plutoRow.cells['cnpj']?.value = nfeDeclaracaoImportacaoModel.cnpj;
		plutoRow.cells['ufTerceiro']?.value = nfeDeclaracaoImportacaoModel.ufTerceiro;
		plutoRow.cells['codigoExportador']?.value = nfeDeclaracaoImportacaoModel.codigoExportador;
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
		nfeDeclaracaoImportacaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDeclaracaoImportacaoModel();
			model.plutoRowToObject(plutoRow);
			nfeDeclaracaoImportacaoModelList.add(model);
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
		numeroDocumentoController.dispose();
		localDesembaracoController.dispose();
		valorAfrmmController.dispose();
		cnpjController.dispose();
		codigoExportadorController.dispose();
		super.onClose();
	}
}