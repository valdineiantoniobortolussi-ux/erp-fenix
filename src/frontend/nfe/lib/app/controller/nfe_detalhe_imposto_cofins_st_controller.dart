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

class NfeDetalheImpostoCofinsStController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoCofinsStGridColumns();
	
	var nfeDetalheImpostoCofinsStModelList = <NfeDetalheImpostoCofinsStModel>[];

	final _nfeDetalheImpostoCofinsStModel = NfeDetalheImpostoCofinsStModel().obs;
	NfeDetalheImpostoCofinsStModel get nfeDetalheImpostoCofinsStModel => _nfeDetalheImpostoCofinsStModel.value;
	set nfeDetalheImpostoCofinsStModel(value) => _nfeDetalheImpostoCofinsStModel.value = value ?? NfeDetalheImpostoCofinsStModel();
	
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
		for (var nfeDetalheImpostoCofinsStModel in nfeDetalheImpostoCofinsStModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoCofinsStModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoCofinsStModel nfeDetalheImpostoCofinsStModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoCofinsStModel: nfeDetalheImpostoCofinsStModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoCofinsStModel? nfeDetalheImpostoCofinsStModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoCofinsStModel?.id ?? 0),
			"baseCalculoCofinsSt": PlutoCell(value: nfeDetalheImpostoCofinsStModel?.baseCalculoCofinsSt ?? 0),
			"aliquotaCofinsStPercentual": PlutoCell(value: nfeDetalheImpostoCofinsStModel?.aliquotaCofinsStPercentual ?? 0),
			"quantidadeVendidaCofinsSt": PlutoCell(value: nfeDetalheImpostoCofinsStModel?.quantidadeVendidaCofinsSt ?? 0),
			"aliquotaCofinsStReais": PlutoCell(value: nfeDetalheImpostoCofinsStModel?.aliquotaCofinsStReais ?? 0),
			"valorCofinsSt": PlutoCell(value: nfeDetalheImpostoCofinsStModel?.valorCofinsSt ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoCofinsStModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoCofinsStModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoCofinsStModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			baseCalculoCofinsStController.text = currentRow.cells['baseCalculoCofinsSt']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCofinsStPercentualController.text = currentRow.cells['aliquotaCofinsStPercentual']?.value?.toStringAsFixed(2) ?? '';
			quantidadeVendidaCofinsStController.text = currentRow.cells['quantidadeVendidaCofinsSt']?.value?.toStringAsFixed(2) ?? '';
			aliquotaCofinsStReaisController.text = currentRow.cells['aliquotaCofinsStReais']?.value?.toStringAsFixed(2) ?? '';
			valorCofinsStController.text = currentRow.cells['valorCofinsSt']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoCofinsStEditPage());
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
	final baseCalculoCofinsStController = MoneyMaskedTextController();
	final aliquotaCofinsStPercentualController = MoneyMaskedTextController();
	final quantidadeVendidaCofinsStController = MoneyMaskedTextController();
	final aliquotaCofinsStReaisController = MoneyMaskedTextController();
	final valorCofinsStController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoCofinsStModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoCofinsStModel.idNfeDetalhe;
		plutoRow.cells['baseCalculoCofinsSt']?.value = nfeDetalheImpostoCofinsStModel.baseCalculoCofinsSt;
		plutoRow.cells['aliquotaCofinsStPercentual']?.value = nfeDetalheImpostoCofinsStModel.aliquotaCofinsStPercentual;
		plutoRow.cells['quantidadeVendidaCofinsSt']?.value = nfeDetalheImpostoCofinsStModel.quantidadeVendidaCofinsSt;
		plutoRow.cells['aliquotaCofinsStReais']?.value = nfeDetalheImpostoCofinsStModel.aliquotaCofinsStReais;
		plutoRow.cells['valorCofinsSt']?.value = nfeDetalheImpostoCofinsStModel.valorCofinsSt;
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
		nfeDetalheImpostoCofinsStModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoCofinsStModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoCofinsStModelList.add(model);
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
		baseCalculoCofinsStController.dispose();
		aliquotaCofinsStPercentualController.dispose();
		quantidadeVendidaCofinsStController.dispose();
		aliquotaCofinsStReaisController.dispose();
		valorCofinsStController.dispose();
		super.onClose();
	}
}