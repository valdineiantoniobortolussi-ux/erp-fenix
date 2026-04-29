import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/page/page_imports.dart';
import 'package:mdfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';

class MdfePercursoController extends GetxController {

	// general
	final gridColumns = mdfePercursoGridColumns();
	
	var mdfePercursoModelList = <MdfePercursoModel>[];

	final _mdfePercursoModel = MdfePercursoModel().obs;
	MdfePercursoModel get mdfePercursoModel => _mdfePercursoModel.value;
	set mdfePercursoModel(value) => _mdfePercursoModel.value = value ?? MdfePercursoModel();
	
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
		for (var mdfePercursoModel in mdfePercursoModelList) {
			plutoRowList.add(_getPlutoRow(mdfePercursoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(MdfePercursoModel mdfePercursoModel) {
		return PlutoRow(
			cells: _getPlutoCells(mdfePercursoModel: mdfePercursoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ MdfePercursoModel? mdfePercursoModel}) {
		return {
			"id": PlutoCell(value: mdfePercursoModel?.id ?? 0),
			"ufPercurso": PlutoCell(value: mdfePercursoModel?.ufPercurso ?? ''),
			"dataInicioViagem": PlutoCell(value: mdfePercursoModel?.dataInicioViagem ?? ''),
			"idMdfeCabecalho": PlutoCell(value: mdfePercursoModel?.idMdfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		mdfePercursoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return mdfePercursoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => MdfePercursoEditPage());
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

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfePercursoModel.id;
		plutoRow.cells['idMdfeCabecalho']?.value = mdfePercursoModel.idMdfeCabecalho;
		plutoRow.cells['ufPercurso']?.value = mdfePercursoModel.ufPercurso;
		plutoRow.cells['dataInicioViagem']?.value = Util.formatDate(mdfePercursoModel.dataInicioViagem);
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
		mdfePercursoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = MdfePercursoModel();
			model.plutoRowToObject(plutoRow);
			mdfePercursoModelList.add(model);
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
		super.onClose();
	}
}