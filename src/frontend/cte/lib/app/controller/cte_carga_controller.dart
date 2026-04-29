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

class CteCargaController extends GetxController {

	// general
	final gridColumns = cteCargaGridColumns();
	
	var cteCargaModelList = <CteCargaModel>[];

	final _cteCargaModel = CteCargaModel().obs;
	CteCargaModel get cteCargaModel => _cteCargaModel.value;
	set cteCargaModel(value) => _cteCargaModel.value = value ?? CteCargaModel();
	
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
		for (var cteCargaModel in cteCargaModelList) {
			plutoRowList.add(_getPlutoRow(cteCargaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteCargaModel cteCargaModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteCargaModel: cteCargaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteCargaModel? cteCargaModel}) {
		return {
			"id": PlutoCell(value: cteCargaModel?.id ?? 0),
			"codigoUnidadeMedida": PlutoCell(value: cteCargaModel?.codigoUnidadeMedida ?? ''),
			"tipoMedida": PlutoCell(value: cteCargaModel?.tipoMedida ?? ''),
			"quantidade": PlutoCell(value: cteCargaModel?.quantidade ?? 0),
			"idCteCabecalho": PlutoCell(value: cteCargaModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteCargaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteCargaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			tipoMedidaController.text = currentRow.cells['tipoMedida']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteCargaEditPage());
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
	final tipoMedidaController = TextEditingController();
	final quantidadeController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteCargaModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteCargaModel.idCteCabecalho;
		plutoRow.cells['codigoUnidadeMedida']?.value = cteCargaModel.codigoUnidadeMedida;
		plutoRow.cells['tipoMedida']?.value = cteCargaModel.tipoMedida;
		plutoRow.cells['quantidade']?.value = cteCargaModel.quantidade;
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
		cteCargaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteCargaModel();
			model.plutoRowToObject(plutoRow);
			cteCargaModelList.add(model);
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
		tipoMedidaController.dispose();
		quantidadeController.dispose();
		super.onClose();
	}
}