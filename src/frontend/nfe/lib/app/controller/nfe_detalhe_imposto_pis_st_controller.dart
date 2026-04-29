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

class NfeDetalheImpostoPisStController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoPisStGridColumns();
	
	var nfeDetalheImpostoPisStModelList = <NfeDetalheImpostoPisStModel>[];

	final _nfeDetalheImpostoPisStModel = NfeDetalheImpostoPisStModel().obs;
	NfeDetalheImpostoPisStModel get nfeDetalheImpostoPisStModel => _nfeDetalheImpostoPisStModel.value;
	set nfeDetalheImpostoPisStModel(value) => _nfeDetalheImpostoPisStModel.value = value ?? NfeDetalheImpostoPisStModel();
	
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
		for (var nfeDetalheImpostoPisStModel in nfeDetalheImpostoPisStModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoPisStModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoPisStModel nfeDetalheImpostoPisStModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoPisStModel: nfeDetalheImpostoPisStModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoPisStModel? nfeDetalheImpostoPisStModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoPisStModel?.id ?? 0),
			"valorBaseCalculoPisSt": PlutoCell(value: nfeDetalheImpostoPisStModel?.valorBaseCalculoPisSt ?? 0),
			"aliquotaPisStPercentual": PlutoCell(value: nfeDetalheImpostoPisStModel?.aliquotaPisStPercentual ?? 0),
			"quantidadeVendidaPisSt": PlutoCell(value: nfeDetalheImpostoPisStModel?.quantidadeVendidaPisSt ?? 0),
			"aliquotaPisStReais": PlutoCell(value: nfeDetalheImpostoPisStModel?.aliquotaPisStReais ?? 0),
			"valorPisSt": PlutoCell(value: nfeDetalheImpostoPisStModel?.valorPisSt ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoPisStModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoPisStModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoPisStModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorBaseCalculoPisStController.text = currentRow.cells['valorBaseCalculoPisSt']?.value?.toStringAsFixed(2) ?? '';
			aliquotaPisStPercentualController.text = currentRow.cells['aliquotaPisStPercentual']?.value?.toStringAsFixed(2) ?? '';
			quantidadeVendidaPisStController.text = currentRow.cells['quantidadeVendidaPisSt']?.value?.toStringAsFixed(2) ?? '';
			aliquotaPisStReaisController.text = currentRow.cells['aliquotaPisStReais']?.value?.toStringAsFixed(2) ?? '';
			valorPisStController.text = currentRow.cells['valorPisSt']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoPisStEditPage());
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
	final valorBaseCalculoPisStController = MoneyMaskedTextController();
	final aliquotaPisStPercentualController = MoneyMaskedTextController();
	final quantidadeVendidaPisStController = MoneyMaskedTextController();
	final aliquotaPisStReaisController = MoneyMaskedTextController();
	final valorPisStController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoPisStModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoPisStModel.idNfeDetalhe;
		plutoRow.cells['valorBaseCalculoPisSt']?.value = nfeDetalheImpostoPisStModel.valorBaseCalculoPisSt;
		plutoRow.cells['aliquotaPisStPercentual']?.value = nfeDetalheImpostoPisStModel.aliquotaPisStPercentual;
		plutoRow.cells['quantidadeVendidaPisSt']?.value = nfeDetalheImpostoPisStModel.quantidadeVendidaPisSt;
		plutoRow.cells['aliquotaPisStReais']?.value = nfeDetalheImpostoPisStModel.aliquotaPisStReais;
		plutoRow.cells['valorPisSt']?.value = nfeDetalheImpostoPisStModel.valorPisSt;
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
		nfeDetalheImpostoPisStModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoPisStModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoPisStModelList.add(model);
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
		valorBaseCalculoPisStController.dispose();
		aliquotaPisStPercentualController.dispose();
		quantidadeVendidaPisStController.dispose();
		aliquotaPisStReaisController.dispose();
		valorPisStController.dispose();
		super.onClose();
	}
}