import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeDetEspecificoArmamentoController extends GetxController {

	// general
	final gridColumns = nfeDetEspecificoArmamentoGridColumns();
	
	var nfeDetEspecificoArmamentoModelList = <NfeDetEspecificoArmamentoModel>[];

	final _nfeDetEspecificoArmamentoModel = NfeDetEspecificoArmamentoModel().obs;
	NfeDetEspecificoArmamentoModel get nfeDetEspecificoArmamentoModel => _nfeDetEspecificoArmamentoModel.value;
	set nfeDetEspecificoArmamentoModel(value) => _nfeDetEspecificoArmamentoModel.value = value ?? NfeDetEspecificoArmamentoModel();
	
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
		for (var nfeDetEspecificoArmamentoModel in nfeDetEspecificoArmamentoModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetEspecificoArmamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetEspecificoArmamentoModel nfeDetEspecificoArmamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetEspecificoArmamentoModel: nfeDetEspecificoArmamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetEspecificoArmamentoModel? nfeDetEspecificoArmamentoModel}) {
		return {
			"id": PlutoCell(value: nfeDetEspecificoArmamentoModel?.id ?? 0),
			"tipoArma": PlutoCell(value: nfeDetEspecificoArmamentoModel?.tipoArma ?? ''),
			"numeroSerieArma": PlutoCell(value: nfeDetEspecificoArmamentoModel?.numeroSerieArma ?? ''),
			"numeroSerieCano": PlutoCell(value: nfeDetEspecificoArmamentoModel?.numeroSerieCano ?? ''),
			"descricao": PlutoCell(value: nfeDetEspecificoArmamentoModel?.descricao ?? ''),
			"idNfeDetalhe": PlutoCell(value: nfeDetEspecificoArmamentoModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetEspecificoArmamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetEspecificoArmamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroSerieArmaController.text = currentRow.cells['numeroSerieArma']?.value ?? '';
			numeroSerieCanoController.text = currentRow.cells['numeroSerieCano']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetEspecificoArmamentoEditPage());
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
	final numeroSerieArmaController = TextEditingController();
	final numeroSerieCanoController = TextEditingController();
	final descricaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetEspecificoArmamentoModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetEspecificoArmamentoModel.idNfeDetalhe;
		plutoRow.cells['tipoArma']?.value = nfeDetEspecificoArmamentoModel.tipoArma;
		plutoRow.cells['numeroSerieArma']?.value = nfeDetEspecificoArmamentoModel.numeroSerieArma;
		plutoRow.cells['numeroSerieCano']?.value = nfeDetEspecificoArmamentoModel.numeroSerieCano;
		plutoRow.cells['descricao']?.value = nfeDetEspecificoArmamentoModel.descricao;
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
		nfeDetEspecificoArmamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetEspecificoArmamentoModel();
			model.plutoRowToObject(plutoRow);
			nfeDetEspecificoArmamentoModelList.add(model);
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
		numeroSerieArmaController.dispose();
		numeroSerieCanoController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}