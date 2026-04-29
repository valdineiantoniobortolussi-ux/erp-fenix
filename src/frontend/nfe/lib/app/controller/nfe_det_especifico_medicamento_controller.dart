import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeDetEspecificoMedicamentoController extends GetxController {

	// general
	final gridColumns = nfeDetEspecificoMedicamentoGridColumns();
	
	var nfeDetEspecificoMedicamentoModelList = <NfeDetEspecificoMedicamentoModel>[];

	final _nfeDetEspecificoMedicamentoModel = NfeDetEspecificoMedicamentoModel().obs;
	NfeDetEspecificoMedicamentoModel get nfeDetEspecificoMedicamentoModel => _nfeDetEspecificoMedicamentoModel.value;
	set nfeDetEspecificoMedicamentoModel(value) => _nfeDetEspecificoMedicamentoModel.value = value ?? NfeDetEspecificoMedicamentoModel();
	
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
		for (var nfeDetEspecificoMedicamentoModel in nfeDetEspecificoMedicamentoModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetEspecificoMedicamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetEspecificoMedicamentoModel nfeDetEspecificoMedicamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetEspecificoMedicamentoModel: nfeDetEspecificoMedicamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetEspecificoMedicamentoModel? nfeDetEspecificoMedicamentoModel}) {
		return {
			"id": PlutoCell(value: nfeDetEspecificoMedicamentoModel?.id ?? 0),
			"codigoAnvisa": PlutoCell(value: nfeDetEspecificoMedicamentoModel?.codigoAnvisa ?? ''),
			"motivoIsencao": PlutoCell(value: nfeDetEspecificoMedicamentoModel?.motivoIsencao ?? ''),
			"precoMaximoConsumidor": PlutoCell(value: nfeDetEspecificoMedicamentoModel?.precoMaximoConsumidor ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetEspecificoMedicamentoModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetEspecificoMedicamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetEspecificoMedicamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			codigoAnvisaController.text = currentRow.cells['codigoAnvisa']?.value ?? '';
			motivoIsencaoController.text = currentRow.cells['motivoIsencao']?.value ?? '';
			precoMaximoConsumidorController.text = currentRow.cells['precoMaximoConsumidor']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetEspecificoMedicamentoEditPage());
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
	final codigoAnvisaController = TextEditingController();
	final motivoIsencaoController = TextEditingController();
	final precoMaximoConsumidorController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetEspecificoMedicamentoModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetEspecificoMedicamentoModel.idNfeDetalhe;
		plutoRow.cells['codigoAnvisa']?.value = nfeDetEspecificoMedicamentoModel.codigoAnvisa;
		plutoRow.cells['motivoIsencao']?.value = nfeDetEspecificoMedicamentoModel.motivoIsencao;
		plutoRow.cells['precoMaximoConsumidor']?.value = nfeDetEspecificoMedicamentoModel.precoMaximoConsumidor;
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
		nfeDetEspecificoMedicamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetEspecificoMedicamentoModel();
			model.plutoRowToObject(plutoRow);
			nfeDetEspecificoMedicamentoModelList.add(model);
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
		codigoAnvisaController.dispose();
		motivoIsencaoController.dispose();
		precoMaximoConsumidorController.dispose();
		super.onClose();
	}
}