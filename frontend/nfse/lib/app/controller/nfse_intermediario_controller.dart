import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfse/app/infra/infra_imports.dart';
import 'package:nfse/app/data/model/model_imports.dart';
import 'package:nfse/app/page/page_imports.dart';
import 'package:nfse/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfse/app/page/shared_widget/message_dialog.dart';

class NfseIntermediarioController extends GetxController {

	// general
	final gridColumns = nfseIntermediarioGridColumns();
	
	var nfseIntermediarioModelList = <NfseIntermediarioModel>[];

	final _nfseIntermediarioModel = NfseIntermediarioModel().obs;
	NfseIntermediarioModel get nfseIntermediarioModel => _nfseIntermediarioModel.value;
	set nfseIntermediarioModel(value) => _nfseIntermediarioModel.value = value ?? NfseIntermediarioModel();
	
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
		for (var nfseIntermediarioModel in nfseIntermediarioModelList) {
			plutoRowList.add(_getPlutoRow(nfseIntermediarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfseIntermediarioModel nfseIntermediarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfseIntermediarioModel: nfseIntermediarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfseIntermediarioModel? nfseIntermediarioModel}) {
		return {
			"id": PlutoCell(value: nfseIntermediarioModel?.id ?? 0),
			"cnpj": PlutoCell(value: nfseIntermediarioModel?.cnpj ?? ''),
			"inscricaoMunicipal": PlutoCell(value: nfseIntermediarioModel?.inscricaoMunicipal ?? ''),
			"razao": PlutoCell(value: nfseIntermediarioModel?.razao ?? ''),
			"idNfseCabecalho": PlutoCell(value: nfseIntermediarioModel?.idNfseCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfseIntermediarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfseIntermediarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			inscricaoMunicipalController.text = currentRow.cells['inscricaoMunicipal']?.value ?? '';
			razaoController.text = currentRow.cells['razao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfseIntermediarioEditPage());
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
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final inscricaoMunicipalController = TextEditingController();
	final razaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfseIntermediarioModel.id;
		plutoRow.cells['idNfseCabecalho']?.value = nfseIntermediarioModel.idNfseCabecalho;
		plutoRow.cells['cnpj']?.value = nfseIntermediarioModel.cnpj;
		plutoRow.cells['inscricaoMunicipal']?.value = nfseIntermediarioModel.inscricaoMunicipal;
		plutoRow.cells['razao']?.value = nfseIntermediarioModel.razao;
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
		nfseIntermediarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfseIntermediarioModel();
			model.plutoRowToObject(plutoRow);
			nfseIntermediarioModelList.add(model);
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
		cnpjController.dispose();
		inscricaoMunicipalController.dispose();
		razaoController.dispose();
		super.onClose();
	}
}