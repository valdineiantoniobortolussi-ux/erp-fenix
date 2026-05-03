import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/page/page_imports.dart';
import 'package:frotas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:frotas/app/page/shared_widget/message_dialog.dart';

class FrotaCombustivelControleController extends GetxController {

	// general
	final gridColumns = frotaCombustivelControleGridColumns();
	
	var frotaCombustivelControleModelList = <FrotaCombustivelControleModel>[];

	final _frotaCombustivelControleModel = FrotaCombustivelControleModel().obs;
	FrotaCombustivelControleModel get frotaCombustivelControleModel => _frotaCombustivelControleModel.value;
	set frotaCombustivelControleModel(value) => _frotaCombustivelControleModel.value = value ?? FrotaCombustivelControleModel();
	
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
		for (var frotaCombustivelControleModel in frotaCombustivelControleModelList) {
			plutoRowList.add(_getPlutoRow(frotaCombustivelControleModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FrotaCombustivelControleModel frotaCombustivelControleModel) {
		return PlutoRow(
			cells: _getPlutoCells(frotaCombustivelControleModel: frotaCombustivelControleModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FrotaCombustivelControleModel? frotaCombustivelControleModel}) {
		return {
			"id": PlutoCell(value: frotaCombustivelControleModel?.id ?? 0),
			"dataAbastecimento": PlutoCell(value: frotaCombustivelControleModel?.dataAbastecimento ?? ''),
			"horaAbastecimento": PlutoCell(value: frotaCombustivelControleModel?.horaAbastecimento ?? ''),
			"valorAbastecimento": PlutoCell(value: frotaCombustivelControleModel?.valorAbastecimento ?? 0),
			"idFrotaVeiculo": PlutoCell(value: frotaCombustivelControleModel?.idFrotaVeiculo ?? 0),
		};
	}

	void plutoRowToObject() {
		frotaCombustivelControleModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return frotaCombustivelControleModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			horaAbastecimentoController.text = currentRow.cells['horaAbastecimento']?.value ?? '';
			valorAbastecimentoController.text = currentRow.cells['valorAbastecimento']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FrotaCombustivelControleEditPage());
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
	final horaAbastecimentoController = MaskedTextController(mask: '00:00:00',);
	final valorAbastecimentoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = frotaCombustivelControleModel.id;
		plutoRow.cells['idFrotaVeiculo']?.value = frotaCombustivelControleModel.idFrotaVeiculo;
		plutoRow.cells['dataAbastecimento']?.value = Util.formatDate(frotaCombustivelControleModel.dataAbastecimento);
		plutoRow.cells['horaAbastecimento']?.value = frotaCombustivelControleModel.horaAbastecimento;
		plutoRow.cells['valorAbastecimento']?.value = frotaCombustivelControleModel.valorAbastecimento;
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
		frotaCombustivelControleModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FrotaCombustivelControleModel();
			model.plutoRowToObject(plutoRow);
			frotaCombustivelControleModelList.add(model);
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
		horaAbastecimentoController.dispose();
		valorAbastecimentoController.dispose();
		super.onClose();
	}
}