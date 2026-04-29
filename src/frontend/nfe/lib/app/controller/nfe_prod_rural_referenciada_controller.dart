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

class NfeProdRuralReferenciadaController extends GetxController {

	// general
	final gridColumns = nfeProdRuralReferenciadaGridColumns();
	
	var nfeProdRuralReferenciadaModelList = <NfeProdRuralReferenciadaModel>[];

	final _nfeProdRuralReferenciadaModel = NfeProdRuralReferenciadaModel().obs;
	NfeProdRuralReferenciadaModel get nfeProdRuralReferenciadaModel => _nfeProdRuralReferenciadaModel.value;
	set nfeProdRuralReferenciadaModel(value) => _nfeProdRuralReferenciadaModel.value = value ?? NfeProdRuralReferenciadaModel();
	
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
		for (var nfeProdRuralReferenciadaModel in nfeProdRuralReferenciadaModelList) {
			plutoRowList.add(_getPlutoRow(nfeProdRuralReferenciadaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeProdRuralReferenciadaModel nfeProdRuralReferenciadaModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeProdRuralReferenciadaModel: nfeProdRuralReferenciadaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeProdRuralReferenciadaModel? nfeProdRuralReferenciadaModel}) {
		return {
			"id": PlutoCell(value: nfeProdRuralReferenciadaModel?.id ?? 0),
			"codigoUf": PlutoCell(value: nfeProdRuralReferenciadaModel?.codigoUf ?? 0),
			"anoMes": PlutoCell(value: nfeProdRuralReferenciadaModel?.anoMes ?? ''),
			"cnpj": PlutoCell(value: nfeProdRuralReferenciadaModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: nfeProdRuralReferenciadaModel?.cpf ?? ''),
			"inscricaoEstadual": PlutoCell(value: nfeProdRuralReferenciadaModel?.inscricaoEstadual ?? ''),
			"modelo": PlutoCell(value: nfeProdRuralReferenciadaModel?.modelo ?? ''),
			"serie": PlutoCell(value: nfeProdRuralReferenciadaModel?.serie ?? ''),
			"numeroNf": PlutoCell(value: nfeProdRuralReferenciadaModel?.numeroNf ?? 0),
			"idNfeCabecalho": PlutoCell(value: nfeProdRuralReferenciadaModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeProdRuralReferenciadaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeProdRuralReferenciadaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			codigoUfController.text = currentRow.cells['codigoUf']?.value?.toString() ?? '';
			anoMesController.text = currentRow.cells['anoMes']?.value ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			inscricaoEstadualController.text = currentRow.cells['inscricaoEstadual']?.value ?? '';
			numeroNfController.text = currentRow.cells['numeroNf']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeProdRuralReferenciadaEditPage());
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
	final codigoUfController = TextEditingController();
	final anoMesController = TextEditingController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final inscricaoEstadualController = TextEditingController();
	final numeroNfController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeProdRuralReferenciadaModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeProdRuralReferenciadaModel.idNfeCabecalho;
		plutoRow.cells['codigoUf']?.value = nfeProdRuralReferenciadaModel.codigoUf;
		plutoRow.cells['anoMes']?.value = nfeProdRuralReferenciadaModel.anoMes;
		plutoRow.cells['cnpj']?.value = nfeProdRuralReferenciadaModel.cnpj;
		plutoRow.cells['cpf']?.value = nfeProdRuralReferenciadaModel.cpf;
		plutoRow.cells['inscricaoEstadual']?.value = nfeProdRuralReferenciadaModel.inscricaoEstadual;
		plutoRow.cells['modelo']?.value = nfeProdRuralReferenciadaModel.modelo;
		plutoRow.cells['serie']?.value = nfeProdRuralReferenciadaModel.serie;
		plutoRow.cells['numeroNf']?.value = nfeProdRuralReferenciadaModel.numeroNf;
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
		nfeProdRuralReferenciadaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeProdRuralReferenciadaModel();
			model.plutoRowToObject(plutoRow);
			nfeProdRuralReferenciadaModelList.add(model);
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
		codigoUfController.dispose();
		anoMesController.dispose();
		cnpjController.dispose();
		cpfController.dispose();
		inscricaoEstadualController.dispose();
		numeroNfController.dispose();
		super.onClose();
	}
}