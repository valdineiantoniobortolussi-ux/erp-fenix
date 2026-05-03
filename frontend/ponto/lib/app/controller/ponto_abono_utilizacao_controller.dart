import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/page/page_imports.dart';
import 'package:ponto/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';

class PontoAbonoUtilizacaoController extends GetxController {

	// general
	final gridColumns = pontoAbonoUtilizacaoGridColumns();
	
	var pontoAbonoUtilizacaoModelList = <PontoAbonoUtilizacaoModel>[];

	final _pontoAbonoUtilizacaoModel = PontoAbonoUtilizacaoModel().obs;
	PontoAbonoUtilizacaoModel get pontoAbonoUtilizacaoModel => _pontoAbonoUtilizacaoModel.value;
	set pontoAbonoUtilizacaoModel(value) => _pontoAbonoUtilizacaoModel.value = value ?? PontoAbonoUtilizacaoModel();
	
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
		for (var pontoAbonoUtilizacaoModel in pontoAbonoUtilizacaoModelList) {
			plutoRowList.add(_getPlutoRow(pontoAbonoUtilizacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PontoAbonoUtilizacaoModel pontoAbonoUtilizacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pontoAbonoUtilizacaoModel: pontoAbonoUtilizacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PontoAbonoUtilizacaoModel? pontoAbonoUtilizacaoModel}) {
		return {
			"id": PlutoCell(value: pontoAbonoUtilizacaoModel?.id ?? 0),
			"dataUtilizacao": PlutoCell(value: pontoAbonoUtilizacaoModel?.dataUtilizacao ?? ''),
			"observacao": PlutoCell(value: pontoAbonoUtilizacaoModel?.observacao ?? ''),
			"idPontoAbono": PlutoCell(value: pontoAbonoUtilizacaoModel?.idPontoAbono ?? 0),
		};
	}

	void plutoRowToObject() {
		pontoAbonoUtilizacaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pontoAbonoUtilizacaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PontoAbonoUtilizacaoEditPage());
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
	final observacaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoAbonoUtilizacaoModel.id;
		plutoRow.cells['idPontoAbono']?.value = pontoAbonoUtilizacaoModel.idPontoAbono;
		plutoRow.cells['dataUtilizacao']?.value = Util.formatDate(pontoAbonoUtilizacaoModel.dataUtilizacao);
		plutoRow.cells['observacao']?.value = pontoAbonoUtilizacaoModel.observacao;
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
		pontoAbonoUtilizacaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PontoAbonoUtilizacaoModel();
			model.plutoRowToObject(plutoRow);
			pontoAbonoUtilizacaoModelList.add(model);
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
		observacaoController.dispose();
		super.onClose();
	}
}