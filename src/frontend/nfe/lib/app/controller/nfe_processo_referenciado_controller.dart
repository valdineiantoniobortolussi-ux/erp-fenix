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

class NfeProcessoReferenciadoController extends GetxController {

	// general
	final gridColumns = nfeProcessoReferenciadoGridColumns();
	
	var nfeProcessoReferenciadoModelList = <NfeProcessoReferenciadoModel>[];

	final _nfeProcessoReferenciadoModel = NfeProcessoReferenciadoModel().obs;
	NfeProcessoReferenciadoModel get nfeProcessoReferenciadoModel => _nfeProcessoReferenciadoModel.value;
	set nfeProcessoReferenciadoModel(value) => _nfeProcessoReferenciadoModel.value = value ?? NfeProcessoReferenciadoModel();
	
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
		for (var nfeProcessoReferenciadoModel in nfeProcessoReferenciadoModelList) {
			plutoRowList.add(_getPlutoRow(nfeProcessoReferenciadoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeProcessoReferenciadoModel nfeProcessoReferenciadoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeProcessoReferenciadoModel: nfeProcessoReferenciadoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeProcessoReferenciadoModel? nfeProcessoReferenciadoModel}) {
		return {
			"id": PlutoCell(value: nfeProcessoReferenciadoModel?.id ?? 0),
			"identificador": PlutoCell(value: nfeProcessoReferenciadoModel?.identificador ?? ''),
			"origem": PlutoCell(value: nfeProcessoReferenciadoModel?.origem ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeProcessoReferenciadoModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeProcessoReferenciadoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeProcessoReferenciadoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			identificadorController.text = currentRow.cells['identificador']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeProcessoReferenciadoEditPage());
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
	final identificadorController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeProcessoReferenciadoModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeProcessoReferenciadoModel.idNfeCabecalho;
		plutoRow.cells['identificador']?.value = nfeProcessoReferenciadoModel.identificador;
		plutoRow.cells['origem']?.value = nfeProcessoReferenciadoModel.origem;
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
		nfeProcessoReferenciadoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeProcessoReferenciadoModel();
			model.plutoRowToObject(plutoRow);
			nfeProcessoReferenciadoModelList.add(model);
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
		identificadorController.dispose();
		super.onClose();
	}
}