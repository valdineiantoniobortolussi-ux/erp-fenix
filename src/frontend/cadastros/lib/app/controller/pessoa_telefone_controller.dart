import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/page_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';

class PessoaTelefoneController extends GetxController {

	// general
	final gridColumns = pessoaTelefoneGridColumns();
	
	var pessoaTelefoneModelList = <PessoaTelefoneModel>[];

	final _pessoaTelefoneModel = PessoaTelefoneModel().obs;
	PessoaTelefoneModel get pessoaTelefoneModel => _pessoaTelefoneModel.value;
	set pessoaTelefoneModel(value) => _pessoaTelefoneModel.value = value ?? PessoaTelefoneModel();
	
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
		for (var pessoaTelefoneModel in pessoaTelefoneModelList) {
			plutoRowList.add(_getPlutoRow(pessoaTelefoneModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PessoaTelefoneModel pessoaTelefoneModel) {
		return PlutoRow(
			cells: _getPlutoCells(pessoaTelefoneModel: pessoaTelefoneModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PessoaTelefoneModel? pessoaTelefoneModel}) {
		return {
			"id": PlutoCell(value: pessoaTelefoneModel?.id ?? 0),
			"tipo": PlutoCell(value: pessoaTelefoneModel?.tipo ?? ''),
			"numero": PlutoCell(value: pessoaTelefoneModel?.numero ?? ''),
			"idPessoa": PlutoCell(value: pessoaTelefoneModel?.idPessoa ?? 0),
		};
	}

	void plutoRowToObject() {
		pessoaTelefoneModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pessoaTelefoneModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PessoaTelefoneEditPage());
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
	final numeroController = MaskedTextController(mask: '(00)00000-0000',);

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pessoaTelefoneModel.id;
		plutoRow.cells['idPessoa']?.value = pessoaTelefoneModel.idPessoa;
		plutoRow.cells['tipo']?.value = pessoaTelefoneModel.tipo;
		plutoRow.cells['numero']?.value = pessoaTelefoneModel.numero;
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
		pessoaTelefoneModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PessoaTelefoneModel();
			model.plutoRowToObject(plutoRow);
			pessoaTelefoneModelList.add(model);
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
		super.onClose();
	}
}