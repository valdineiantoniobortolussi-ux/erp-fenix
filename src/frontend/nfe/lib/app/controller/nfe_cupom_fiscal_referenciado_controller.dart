import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeCupomFiscalReferenciadoController extends GetxController {

	// general
	final gridColumns = nfeCupomFiscalReferenciadoGridColumns();
	
	var nfeCupomFiscalReferenciadoModelList = <NfeCupomFiscalReferenciadoModel>[];

	final _nfeCupomFiscalReferenciadoModel = NfeCupomFiscalReferenciadoModel().obs;
	NfeCupomFiscalReferenciadoModel get nfeCupomFiscalReferenciadoModel => _nfeCupomFiscalReferenciadoModel.value;
	set nfeCupomFiscalReferenciadoModel(value) => _nfeCupomFiscalReferenciadoModel.value = value ?? NfeCupomFiscalReferenciadoModel();
	
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
		for (var nfeCupomFiscalReferenciadoModel in nfeCupomFiscalReferenciadoModelList) {
			plutoRowList.add(_getPlutoRow(nfeCupomFiscalReferenciadoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeCupomFiscalReferenciadoModel nfeCupomFiscalReferenciadoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeCupomFiscalReferenciadoModel: nfeCupomFiscalReferenciadoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeCupomFiscalReferenciadoModel? nfeCupomFiscalReferenciadoModel}) {
		return {
			"id": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.id ?? 0),
			"modeloDocumentoFiscal": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.modeloDocumentoFiscal ?? ''),
			"numeroOrdemEcf": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.numeroOrdemEcf ?? 0),
			"coo": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.coo ?? 0),
			"dataEmissaoCupom": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.dataEmissaoCupom ?? ''),
			"numeroCaixa": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.numeroCaixa ?? 0),
			"numeroSerieEcf": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.numeroSerieEcf ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeCupomFiscalReferenciadoModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeCupomFiscalReferenciadoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeCupomFiscalReferenciadoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroOrdemEcfController.text = currentRow.cells['numeroOrdemEcf']?.value?.toString() ?? '';
			cooController.text = currentRow.cells['coo']?.value?.toString() ?? '';
			numeroCaixaController.text = currentRow.cells['numeroCaixa']?.value?.toString() ?? '';
			numeroSerieEcfController.text = currentRow.cells['numeroSerieEcf']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeCupomFiscalReferenciadoEditPage());
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
	final numeroOrdemEcfController = TextEditingController();
	final cooController = TextEditingController();
	final numeroCaixaController = TextEditingController();
	final numeroSerieEcfController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeCupomFiscalReferenciadoModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeCupomFiscalReferenciadoModel.idNfeCabecalho;
		plutoRow.cells['modeloDocumentoFiscal']?.value = nfeCupomFiscalReferenciadoModel.modeloDocumentoFiscal;
		plutoRow.cells['numeroOrdemEcf']?.value = nfeCupomFiscalReferenciadoModel.numeroOrdemEcf;
		plutoRow.cells['coo']?.value = nfeCupomFiscalReferenciadoModel.coo;
		plutoRow.cells['dataEmissaoCupom']?.value = Util.formatDate(nfeCupomFiscalReferenciadoModel.dataEmissaoCupom);
		plutoRow.cells['numeroCaixa']?.value = nfeCupomFiscalReferenciadoModel.numeroCaixa;
		plutoRow.cells['numeroSerieEcf']?.value = nfeCupomFiscalReferenciadoModel.numeroSerieEcf;
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
		nfeCupomFiscalReferenciadoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeCupomFiscalReferenciadoModel();
			model.plutoRowToObject(plutoRow);
			nfeCupomFiscalReferenciadoModelList.add(model);
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
		numeroOrdemEcfController.dispose();
		cooController.dispose();
		numeroCaixaController.dispose();
		numeroSerieEcfController.dispose();
		super.onClose();
	}
}