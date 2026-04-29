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

class ContratoPrevFaturamentoController extends GetxController {

	// general
	final gridColumns = contratoPrevFaturamentoGridColumns();
	
	var contratoPrevFaturamentoModelList = <ContratoPrevFaturamentoModel>[];

	final _contratoPrevFaturamentoModel = ContratoPrevFaturamentoModel().obs;
	ContratoPrevFaturamentoModel get contratoPrevFaturamentoModel => _contratoPrevFaturamentoModel.value;
	set contratoPrevFaturamentoModel(value) => _contratoPrevFaturamentoModel.value = value ?? ContratoPrevFaturamentoModel();
	
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
		for (var contratoPrevFaturamentoModel in contratoPrevFaturamentoModelList) {
			plutoRowList.add(_getPlutoRow(contratoPrevFaturamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContratoPrevFaturamentoModel contratoPrevFaturamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(contratoPrevFaturamentoModel: contratoPrevFaturamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContratoPrevFaturamentoModel? contratoPrevFaturamentoModel}) {
		return {
			"id": PlutoCell(value: contratoPrevFaturamentoModel?.id ?? 0),
			"dataPrevista": PlutoCell(value: contratoPrevFaturamentoModel?.dataPrevista ?? ''),
			"valor": PlutoCell(value: contratoPrevFaturamentoModel?.valor ?? 0),
			"idContrato": PlutoCell(value: contratoPrevFaturamentoModel?.idContrato ?? 0),
		};
	}

	void plutoRowToObject() {
		contratoPrevFaturamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return contratoPrevFaturamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ContratoPrevFaturamentoEditPage());
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
		plutoRow.cells['id']?.value = contratoPrevFaturamentoModel.id;
		plutoRow.cells['idContrato']?.value = contratoPrevFaturamentoModel.idContrato;
		plutoRow.cells['dataPrevista']?.value = Util.formatDate(contratoPrevFaturamentoModel.dataPrevista);
		plutoRow.cells['valor']?.value = contratoPrevFaturamentoModel.valor;
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
		contratoPrevFaturamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ContratoPrevFaturamentoModel();
			model.plutoRowToObject(plutoRow);
			contratoPrevFaturamentoModelList.add(model);
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