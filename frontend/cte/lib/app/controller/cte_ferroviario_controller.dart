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

class CteFerroviarioController extends GetxController {

	// general
	final gridColumns = cteFerroviarioGridColumns();
	
	var cteFerroviarioModelList = <CteFerroviarioModel>[];

	final _cteFerroviarioModel = CteFerroviarioModel().obs;
	CteFerroviarioModel get cteFerroviarioModel => _cteFerroviarioModel.value;
	set cteFerroviarioModel(value) => _cteFerroviarioModel.value = value ?? CteFerroviarioModel();
	
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
		for (var cteFerroviarioModel in cteFerroviarioModelList) {
			plutoRowList.add(_getPlutoRow(cteFerroviarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteFerroviarioModel cteFerroviarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteFerroviarioModel: cteFerroviarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteFerroviarioModel? cteFerroviarioModel}) {
		return {
			"id": PlutoCell(value: cteFerroviarioModel?.id ?? 0),
			"tipoTrafego": PlutoCell(value: cteFerroviarioModel?.tipoTrafego ?? ''),
			"responsavelFaturamento": PlutoCell(value: cteFerroviarioModel?.responsavelFaturamento ?? ''),
			"ferroviaEmitenteCte": PlutoCell(value: cteFerroviarioModel?.ferroviaEmitenteCte ?? ''),
			"fluxo": PlutoCell(value: cteFerroviarioModel?.fluxo ?? ''),
			"idTrem": PlutoCell(value: cteFerroviarioModel?.idTrem ?? ''),
			"valorFrete": PlutoCell(value: cteFerroviarioModel?.valorFrete ?? 0),
			"idCteCabecalho": PlutoCell(value: cteFerroviarioModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteFerroviarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteFerroviarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			fluxoController.text = currentRow.cells['fluxo']?.value ?? '';
			idTremController.text = currentRow.cells['idTrem']?.value ?? '';
			valorFreteController.text = currentRow.cells['valorFrete']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteFerroviarioEditPage());
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
	final fluxoController = TextEditingController();
	final idTremController = TextEditingController();
	final valorFreteController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteFerroviarioModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteFerroviarioModel.idCteCabecalho;
		plutoRow.cells['tipoTrafego']?.value = cteFerroviarioModel.tipoTrafego;
		plutoRow.cells['responsavelFaturamento']?.value = cteFerroviarioModel.responsavelFaturamento;
		plutoRow.cells['ferroviaEmitenteCte']?.value = cteFerroviarioModel.ferroviaEmitenteCte;
		plutoRow.cells['fluxo']?.value = cteFerroviarioModel.fluxo;
		plutoRow.cells['idTrem']?.value = cteFerroviarioModel.idTrem;
		plutoRow.cells['valorFrete']?.value = cteFerroviarioModel.valorFrete;
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
		cteFerroviarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteFerroviarioModel();
			model.plutoRowToObject(plutoRow);
			cteFerroviarioModelList.add(model);
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
		fluxoController.dispose();
		idTremController.dispose();
		valorFreteController.dispose();
		super.onClose();
	}
}