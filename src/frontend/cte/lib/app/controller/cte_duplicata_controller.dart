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

class CteDuplicataController extends GetxController {

	// general
	final gridColumns = cteDuplicataGridColumns();
	
	var cteDuplicataModelList = <CteDuplicataModel>[];

	final _cteDuplicataModel = CteDuplicataModel().obs;
	CteDuplicataModel get cteDuplicataModel => _cteDuplicataModel.value;
	set cteDuplicataModel(value) => _cteDuplicataModel.value = value ?? CteDuplicataModel();
	
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
		for (var cteDuplicataModel in cteDuplicataModelList) {
			plutoRowList.add(_getPlutoRow(cteDuplicataModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteDuplicataModel cteDuplicataModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteDuplicataModel: cteDuplicataModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteDuplicataModel? cteDuplicataModel}) {
		return {
			"id": PlutoCell(value: cteDuplicataModel?.id ?? 0),
			"numero": PlutoCell(value: cteDuplicataModel?.numero ?? ''),
			"dataVencimento": PlutoCell(value: cteDuplicataModel?.dataVencimento ?? ''),
			"valor": PlutoCell(value: cteDuplicataModel?.valor ?? 0),
			"idCteCabecalho": PlutoCell(value: cteDuplicataModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteDuplicataModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteDuplicataModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteDuplicataEditPage());
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
	final numeroController = TextEditingController();
	final valorController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteDuplicataModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteDuplicataModel.idCteCabecalho;
		plutoRow.cells['numero']?.value = cteDuplicataModel.numero;
		plutoRow.cells['dataVencimento']?.value = Util.formatDate(cteDuplicataModel.dataVencimento);
		plutoRow.cells['valor']?.value = cteDuplicataModel.valor;
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
		cteDuplicataModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteDuplicataModel();
			model.plutoRowToObject(plutoRow);
			cteDuplicataModelList.add(model);
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
		numeroController.dispose();
		valorController.dispose();
		super.onClose();
	}
}