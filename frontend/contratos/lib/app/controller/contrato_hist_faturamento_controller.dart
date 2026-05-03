import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:contratos/app/page/page_imports.dart';
import 'package:contratos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contratos/app/page/shared_widget/message_dialog.dart';

class ContratoHistFaturamentoController extends GetxController {

	// general
	final gridColumns = contratoHistFaturamentoGridColumns();
	
	var contratoHistFaturamentoModelList = <ContratoHistFaturamentoModel>[];

	final _contratoHistFaturamentoModel = ContratoHistFaturamentoModel().obs;
	ContratoHistFaturamentoModel get contratoHistFaturamentoModel => _contratoHistFaturamentoModel.value;
	set contratoHistFaturamentoModel(value) => _contratoHistFaturamentoModel.value = value ?? ContratoHistFaturamentoModel();
	
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
		for (var contratoHistFaturamentoModel in contratoHistFaturamentoModelList) {
			plutoRowList.add(_getPlutoRow(contratoHistFaturamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContratoHistFaturamentoModel contratoHistFaturamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(contratoHistFaturamentoModel: contratoHistFaturamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContratoHistFaturamentoModel? contratoHistFaturamentoModel}) {
		return {
			"id": PlutoCell(value: contratoHistFaturamentoModel?.id ?? 0),
			"dataFatura": PlutoCell(value: contratoHistFaturamentoModel?.dataFatura ?? ''),
			"valor": PlutoCell(value: contratoHistFaturamentoModel?.valor ?? 0),
			"idContrato": PlutoCell(value: contratoHistFaturamentoModel?.idContrato ?? 0),
		};
	}

	void plutoRowToObject() {
		contratoHistFaturamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return contratoHistFaturamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ContratoHistFaturamentoEditPage());
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

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contratoHistFaturamentoModel.id;
		plutoRow.cells['idContrato']?.value = contratoHistFaturamentoModel.idContrato;
		plutoRow.cells['dataFatura']?.value = Util.formatDate(contratoHistFaturamentoModel.dataFatura);
		plutoRow.cells['valor']?.value = contratoHistFaturamentoModel.valor;
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
		contratoHistFaturamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ContratoHistFaturamentoModel();
			model.plutoRowToObject(plutoRow);
			contratoHistFaturamentoModelList.add(model);
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
		super.onClose();
	}
}