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

class CteRodoviarioController extends GetxController {

	// general
	final gridColumns = cteRodoviarioGridColumns();
	
	var cteRodoviarioModelList = <CteRodoviarioModel>[];

	final _cteRodoviarioModel = CteRodoviarioModel().obs;
	CteRodoviarioModel get cteRodoviarioModel => _cteRodoviarioModel.value;
	set cteRodoviarioModel(value) => _cteRodoviarioModel.value = value ?? CteRodoviarioModel();
	
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
		for (var cteRodoviarioModel in cteRodoviarioModelList) {
			plutoRowList.add(_getPlutoRow(cteRodoviarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteRodoviarioModel cteRodoviarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteRodoviarioModel: cteRodoviarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteRodoviarioModel? cteRodoviarioModel}) {
		return {
			"id": PlutoCell(value: cteRodoviarioModel?.id ?? 0),
			"rntrc": PlutoCell(value: cteRodoviarioModel?.rntrc ?? ''),
			"dataPrevistaEntrega": PlutoCell(value: cteRodoviarioModel?.dataPrevistaEntrega ?? ''),
			"indicadorLotacao": PlutoCell(value: cteRodoviarioModel?.indicadorLotacao ?? ''),
			"ciot": PlutoCell(value: cteRodoviarioModel?.ciot ?? 0),
			"idCteCabecalho": PlutoCell(value: cteRodoviarioModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteRodoviarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteRodoviarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			rntrcController.text = currentRow.cells['rntrc']?.value ?? '';
			ciotController.text = currentRow.cells['ciot']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteRodoviarioEditPage());
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
	final rntrcController = TextEditingController();
	final ciotController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteRodoviarioModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteRodoviarioModel.idCteCabecalho;
		plutoRow.cells['rntrc']?.value = cteRodoviarioModel.rntrc;
		plutoRow.cells['dataPrevistaEntrega']?.value = Util.formatDate(cteRodoviarioModel.dataPrevistaEntrega);
		plutoRow.cells['indicadorLotacao']?.value = cteRodoviarioModel.indicadorLotacao;
		plutoRow.cells['ciot']?.value = cteRodoviarioModel.ciot;
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
		cteRodoviarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteRodoviarioModel();
			model.plutoRowToObject(plutoRow);
			cteRodoviarioModelList.add(model);
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
		rntrcController.dispose();
		ciotController.dispose();
		super.onClose();
	}
}