import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/page_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';

class FiscalInscricoesSubstitutasController extends GetxController {

	// general
	final gridColumns = fiscalInscricoesSubstitutasGridColumns();
	
	var fiscalInscricoesSubstitutasModelList = <FiscalInscricoesSubstitutasModel>[];

	final _fiscalInscricoesSubstitutasModel = FiscalInscricoesSubstitutasModel().obs;
	FiscalInscricoesSubstitutasModel get fiscalInscricoesSubstitutasModel => _fiscalInscricoesSubstitutasModel.value;
	set fiscalInscricoesSubstitutasModel(value) => _fiscalInscricoesSubstitutasModel.value = value ?? FiscalInscricoesSubstitutasModel();
	
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
		for (var fiscalInscricoesSubstitutasModel in fiscalInscricoesSubstitutasModelList) {
			plutoRowList.add(_getPlutoRow(fiscalInscricoesSubstitutasModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FiscalInscricoesSubstitutasModel fiscalInscricoesSubstitutasModel) {
		return PlutoRow(
			cells: _getPlutoCells(fiscalInscricoesSubstitutasModel: fiscalInscricoesSubstitutasModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FiscalInscricoesSubstitutasModel? fiscalInscricoesSubstitutasModel}) {
		return {
			"id": PlutoCell(value: fiscalInscricoesSubstitutasModel?.id ?? 0),
			"uf": PlutoCell(value: fiscalInscricoesSubstitutasModel?.uf ?? ''),
			"inscricaoEstadual": PlutoCell(value: fiscalInscricoesSubstitutasModel?.inscricaoEstadual ?? ''),
			"pmpf": PlutoCell(value: fiscalInscricoesSubstitutasModel?.pmpf ?? ''),
			"idFiscalParametros": PlutoCell(value: fiscalInscricoesSubstitutasModel?.idFiscalParametros ?? 0),
		};
	}

	void plutoRowToObject() {
		fiscalInscricoesSubstitutasModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return fiscalInscricoesSubstitutasModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			inscricaoEstadualController.text = currentRow.cells['inscricaoEstadual']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FiscalInscricoesSubstitutasEditPage());
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
	final inscricaoEstadualController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalInscricoesSubstitutasModel.id;
		plutoRow.cells['idFiscalParametros']?.value = fiscalInscricoesSubstitutasModel.idFiscalParametros;
		plutoRow.cells['uf']?.value = fiscalInscricoesSubstitutasModel.uf;
		plutoRow.cells['inscricaoEstadual']?.value = fiscalInscricoesSubstitutasModel.inscricaoEstadual;
		plutoRow.cells['pmpf']?.value = fiscalInscricoesSubstitutasModel.pmpf;
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
		fiscalInscricoesSubstitutasModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FiscalInscricoesSubstitutasModel();
			model.plutoRowToObject(plutoRow);
			fiscalInscricoesSubstitutasModelList.add(model);
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
		inscricaoEstadualController.dispose();
		super.onClose();
	}
}