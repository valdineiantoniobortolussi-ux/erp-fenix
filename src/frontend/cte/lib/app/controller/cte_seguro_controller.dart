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

class CteSeguroController extends GetxController {

	// general
	final gridColumns = cteSeguroGridColumns();
	
	var cteSeguroModelList = <CteSeguroModel>[];

	final _cteSeguroModel = CteSeguroModel().obs;
	CteSeguroModel get cteSeguroModel => _cteSeguroModel.value;
	set cteSeguroModel(value) => _cteSeguroModel.value = value ?? CteSeguroModel();
	
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
		for (var cteSeguroModel in cteSeguroModelList) {
			plutoRowList.add(_getPlutoRow(cteSeguroModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteSeguroModel cteSeguroModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteSeguroModel: cteSeguroModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteSeguroModel? cteSeguroModel}) {
		return {
			"id": PlutoCell(value: cteSeguroModel?.id ?? 0),
			"responsavel": PlutoCell(value: cteSeguroModel?.responsavel ?? ''),
			"seguradora": PlutoCell(value: cteSeguroModel?.seguradora ?? ''),
			"apolice": PlutoCell(value: cteSeguroModel?.apolice ?? ''),
			"averbacao": PlutoCell(value: cteSeguroModel?.averbacao ?? ''),
			"valorCarga": PlutoCell(value: cteSeguroModel?.valorCarga ?? 0),
			"idCteCabecalho": PlutoCell(value: cteSeguroModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteSeguroModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteSeguroModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			seguradoraController.text = currentRow.cells['seguradora']?.value ?? '';
			apoliceController.text = currentRow.cells['apolice']?.value ?? '';
			averbacaoController.text = currentRow.cells['averbacao']?.value ?? '';
			valorCargaController.text = currentRow.cells['valorCarga']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteSeguroEditPage());
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
	final seguradoraController = TextEditingController();
	final apoliceController = TextEditingController();
	final averbacaoController = TextEditingController();
	final valorCargaController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteSeguroModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteSeguroModel.idCteCabecalho;
		plutoRow.cells['responsavel']?.value = cteSeguroModel.responsavel;
		plutoRow.cells['seguradora']?.value = cteSeguroModel.seguradora;
		plutoRow.cells['apolice']?.value = cteSeguroModel.apolice;
		plutoRow.cells['averbacao']?.value = cteSeguroModel.averbacao;
		plutoRow.cells['valorCarga']?.value = cteSeguroModel.valorCarga;
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
		cteSeguroModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteSeguroModel();
			model.plutoRowToObject(plutoRow);
			cteSeguroModelList.add(model);
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
		seguradoraController.dispose();
		apoliceController.dispose();
		averbacaoController.dispose();
		valorCargaController.dispose();
		super.onClose();
	}
}