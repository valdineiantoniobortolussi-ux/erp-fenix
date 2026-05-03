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

class NfeAcessoXmlController extends GetxController {

	// general
	final gridColumns = nfeAcessoXmlGridColumns();
	
	var nfeAcessoXmlModelList = <NfeAcessoXmlModel>[];

	final _nfeAcessoXmlModel = NfeAcessoXmlModel().obs;
	NfeAcessoXmlModel get nfeAcessoXmlModel => _nfeAcessoXmlModel.value;
	set nfeAcessoXmlModel(value) => _nfeAcessoXmlModel.value = value ?? NfeAcessoXmlModel();
	
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
		for (var nfeAcessoXmlModel in nfeAcessoXmlModelList) {
			plutoRowList.add(_getPlutoRow(nfeAcessoXmlModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeAcessoXmlModel nfeAcessoXmlModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeAcessoXmlModel: nfeAcessoXmlModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeAcessoXmlModel? nfeAcessoXmlModel}) {
		return {
			"id": PlutoCell(value: nfeAcessoXmlModel?.id ?? 0),
			"cnpj": PlutoCell(value: nfeAcessoXmlModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: nfeAcessoXmlModel?.cpf ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeAcessoXmlModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeAcessoXmlModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeAcessoXmlModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeAcessoXmlEditPage());
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
	final cpfController = MaskedTextController(mask: '000.000.000-00',);

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeAcessoXmlModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeAcessoXmlModel.idNfeCabecalho;
		plutoRow.cells['cnpj']?.value = nfeAcessoXmlModel.cnpj;
		plutoRow.cells['cpf']?.value = nfeAcessoXmlModel.cpf;
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
		nfeAcessoXmlModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeAcessoXmlModel();
			model.plutoRowToObject(plutoRow);
			nfeAcessoXmlModelList.add(model);
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
		cpfController.dispose();
		super.onClose();
	}
}