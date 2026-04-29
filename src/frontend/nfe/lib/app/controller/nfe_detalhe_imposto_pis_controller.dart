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

class NfeDetalheImpostoPisController extends GetxController {

	// general
	final gridColumns = nfeDetalheImpostoPisGridColumns();
	
	var nfeDetalheImpostoPisModelList = <NfeDetalheImpostoPisModel>[];

	final _nfeDetalheImpostoPisModel = NfeDetalheImpostoPisModel().obs;
	NfeDetalheImpostoPisModel get nfeDetalheImpostoPisModel => _nfeDetalheImpostoPisModel.value;
	set nfeDetalheImpostoPisModel(value) => _nfeDetalheImpostoPisModel.value = value ?? NfeDetalheImpostoPisModel();
	
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
		for (var nfeDetalheImpostoPisModel in nfeDetalheImpostoPisModelList) {
			plutoRowList.add(_getPlutoRow(nfeDetalheImpostoPisModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDetalheImpostoPisModel nfeDetalheImpostoPisModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDetalheImpostoPisModel: nfeDetalheImpostoPisModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDetalheImpostoPisModel? nfeDetalheImpostoPisModel}) {
		return {
			"id": PlutoCell(value: nfeDetalheImpostoPisModel?.id ?? 0),
			"cstPis": PlutoCell(value: nfeDetalheImpostoPisModel?.cstPis ?? ''),
			"valorBaseCalculoPis": PlutoCell(value: nfeDetalheImpostoPisModel?.valorBaseCalculoPis ?? 0),
			"aliquotaPisPercentual": PlutoCell(value: nfeDetalheImpostoPisModel?.aliquotaPisPercentual ?? 0),
			"valorPis": PlutoCell(value: nfeDetalheImpostoPisModel?.valorPis ?? 0),
			"quantidadeVendida": PlutoCell(value: nfeDetalheImpostoPisModel?.quantidadeVendida ?? 0),
			"aliquotaPisReais": PlutoCell(value: nfeDetalheImpostoPisModel?.aliquotaPisReais ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeDetalheImpostoPisModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDetalheImpostoPisModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDetalheImpostoPisModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorBaseCalculoPisController.text = currentRow.cells['valorBaseCalculoPis']?.value?.toStringAsFixed(2) ?? '';
			aliquotaPisPercentualController.text = currentRow.cells['aliquotaPisPercentual']?.value?.toStringAsFixed(2) ?? '';
			valorPisController.text = currentRow.cells['valorPis']?.value?.toStringAsFixed(2) ?? '';
			quantidadeVendidaController.text = currentRow.cells['quantidadeVendida']?.value?.toStringAsFixed(2) ?? '';
			aliquotaPisReaisController.text = currentRow.cells['aliquotaPisReais']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDetalheImpostoPisEditPage());
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
	final valorBaseCalculoPisController = MoneyMaskedTextController();
	final aliquotaPisPercentualController = MoneyMaskedTextController();
	final valorPisController = MoneyMaskedTextController();
	final quantidadeVendidaController = MoneyMaskedTextController();
	final aliquotaPisReaisController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeDetalheImpostoPisModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeDetalheImpostoPisModel.idNfeDetalhe;
		plutoRow.cells['cstPis']?.value = nfeDetalheImpostoPisModel.cstPis;
		plutoRow.cells['valorBaseCalculoPis']?.value = nfeDetalheImpostoPisModel.valorBaseCalculoPis;
		plutoRow.cells['aliquotaPisPercentual']?.value = nfeDetalheImpostoPisModel.aliquotaPisPercentual;
		plutoRow.cells['valorPis']?.value = nfeDetalheImpostoPisModel.valorPis;
		plutoRow.cells['quantidadeVendida']?.value = nfeDetalheImpostoPisModel.quantidadeVendida;
		plutoRow.cells['aliquotaPisReais']?.value = nfeDetalheImpostoPisModel.aliquotaPisReais;
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
		nfeDetalheImpostoPisModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDetalheImpostoPisModel();
			model.plutoRowToObject(plutoRow);
			nfeDetalheImpostoPisModelList.add(model);
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
		valorBaseCalculoPisController.dispose();
		aliquotaPisPercentualController.dispose();
		valorPisController.dispose();
		quantidadeVendidaController.dispose();
		aliquotaPisReaisController.dispose();
		super.onClose();
	}
}