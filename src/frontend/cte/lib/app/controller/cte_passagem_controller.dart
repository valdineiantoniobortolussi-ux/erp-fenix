import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CtePassagemController extends GetxController {

	// general
	final gridColumns = ctePassagemGridColumns();
	
	var ctePassagemModelList = <CtePassagemModel>[];

	final _ctePassagemModel = CtePassagemModel().obs;
	CtePassagemModel get ctePassagemModel => _ctePassagemModel.value;
	set ctePassagemModel(value) => _ctePassagemModel.value = value ?? CtePassagemModel();
	
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
		for (var ctePassagemModel in ctePassagemModelList) {
			plutoRowList.add(_getPlutoRow(ctePassagemModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CtePassagemModel ctePassagemModel) {
		return PlutoRow(
			cells: _getPlutoCells(ctePassagemModel: ctePassagemModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CtePassagemModel? ctePassagemModel}) {
		return {
			"id": PlutoCell(value: ctePassagemModel?.id ?? 0),
			"siglaPassagem": PlutoCell(value: ctePassagemModel?.siglaPassagem ?? ''),
			"siglaDestino": PlutoCell(value: ctePassagemModel?.siglaDestino ?? ''),
			"rota": PlutoCell(value: ctePassagemModel?.rota ?? ''),
			"idCteCabecalho": PlutoCell(value: ctePassagemModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		ctePassagemModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return ctePassagemModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			siglaPassagemController.text = currentRow.cells['siglaPassagem']?.value ?? '';
			siglaDestinoController.text = currentRow.cells['siglaDestino']?.value ?? '';
			rotaController.text = currentRow.cells['rota']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CtePassagemEditPage());
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
	final siglaPassagemController = TextEditingController();
	final siglaDestinoController = TextEditingController();
	final rotaController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = ctePassagemModel.id;
		plutoRow.cells['idCteCabecalho']?.value = ctePassagemModel.idCteCabecalho;
		plutoRow.cells['siglaPassagem']?.value = ctePassagemModel.siglaPassagem;
		plutoRow.cells['siglaDestino']?.value = ctePassagemModel.siglaDestino;
		plutoRow.cells['rota']?.value = ctePassagemModel.rota;
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
		ctePassagemModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CtePassagemModel();
			model.plutoRowToObject(plutoRow);
			ctePassagemModelList.add(model);
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
		siglaPassagemController.dispose();
		siglaDestinoController.dispose();
		rotaController.dispose();
		super.onClose();
	}
}