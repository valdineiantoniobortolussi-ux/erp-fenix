import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/routes/app_routes.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/page_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';

class ContabilEncerramentoExeDetController extends GetxController {

	// general
	final gridColumns = contabilEncerramentoExeDetGridColumns();
	
	var contabilEncerramentoExeDetModelList = <ContabilEncerramentoExeDetModel>[];

	final _contabilEncerramentoExeDetModel = ContabilEncerramentoExeDetModel().obs;
	ContabilEncerramentoExeDetModel get contabilEncerramentoExeDetModel => _contabilEncerramentoExeDetModel.value;
	set contabilEncerramentoExeDetModel(value) => _contabilEncerramentoExeDetModel.value = value ?? ContabilEncerramentoExeDetModel();
	
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
		for (var contabilEncerramentoExeDetModel in contabilEncerramentoExeDetModelList) {
			plutoRowList.add(_getPlutoRow(contabilEncerramentoExeDetModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilEncerramentoExeDetModel contabilEncerramentoExeDetModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilEncerramentoExeDetModel: contabilEncerramentoExeDetModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilEncerramentoExeDetModel? contabilEncerramentoExeDetModel}) {
		return {
			"id": PlutoCell(value: contabilEncerramentoExeDetModel?.id ?? 0),
			"contabilConta": PlutoCell(value: contabilEncerramentoExeDetModel?.contabilContaModel?.descricao ?? ''),
			"saldoAnterior": PlutoCell(value: contabilEncerramentoExeDetModel?.saldoAnterior ?? 0),
			"valorDebito": PlutoCell(value: contabilEncerramentoExeDetModel?.valorDebito ?? 0),
			"valorCredito": PlutoCell(value: contabilEncerramentoExeDetModel?.valorCredito ?? 0),
			"saldo": PlutoCell(value: contabilEncerramentoExeDetModel?.saldo ?? 0),
			"idContabilEncerramentoExe": PlutoCell(value: contabilEncerramentoExeDetModel?.idContabilEncerramentoExe ?? 0),
			"idContabilConta": PlutoCell(value: contabilEncerramentoExeDetModel?.idContabilConta ?? 0),
		};
	}

	void plutoRowToObject() {
		contabilEncerramentoExeDetModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return contabilEncerramentoExeDetModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			contabilContaModelController.text = currentRow.cells['contabilConta']?.value ?? '';
			saldoAnteriorController.text = currentRow.cells['saldoAnterior']?.value?.toStringAsFixed(2) ?? '';
			valorDebitoController.text = currentRow.cells['valorDebito']?.value?.toStringAsFixed(2) ?? '';
			valorCreditoController.text = currentRow.cells['valorCredito']?.value?.toStringAsFixed(2) ?? '';
			saldoController.text = currentRow.cells['saldo']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ContabilEncerramentoExeDetEditPage());
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
	final contabilContaModelController = TextEditingController();
	final saldoAnteriorController = MoneyMaskedTextController();
	final valorDebitoController = MoneyMaskedTextController();
	final valorCreditoController = MoneyMaskedTextController();
	final saldoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilEncerramentoExeDetModel.id;
		plutoRow.cells['idContabilEncerramentoExe']?.value = contabilEncerramentoExeDetModel.idContabilEncerramentoExe;
		plutoRow.cells['idContabilConta']?.value = contabilEncerramentoExeDetModel.idContabilConta;
		plutoRow.cells['contabilConta']?.value = contabilEncerramentoExeDetModel.contabilContaModel?.descricao;
		plutoRow.cells['saldoAnterior']?.value = contabilEncerramentoExeDetModel.saldoAnterior;
		plutoRow.cells['valorDebito']?.value = contabilEncerramentoExeDetModel.valorDebito;
		plutoRow.cells['valorCredito']?.value = contabilEncerramentoExeDetModel.valorCredito;
		plutoRow.cells['saldo']?.value = contabilEncerramentoExeDetModel.saldo;
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
		contabilEncerramentoExeDetModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ContabilEncerramentoExeDetModel();
			model.plutoRowToObject(plutoRow);
			contabilEncerramentoExeDetModelList.add(model);
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

	Future callContabilContaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Conta Contábil]'; 
		lookupController.route = '/contabil-conta/'; 
		lookupController.gridColumns = contabilContaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContabilContaModel.aliasColumns; 
		lookupController.dbColumns = ContabilContaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilEncerramentoExeDetModel.idContabilConta = plutoRowResult.cells['id']!.value; 
			contabilEncerramentoExeDetModel.contabilContaModel!.plutoRowToObject(plutoRowResult); 
			contabilContaModelController.text = contabilEncerramentoExeDetModel.contabilContaModel?.descricao ?? ''; 
			formWasChanged = true; 
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
		contabilContaModelController.dispose();
		saldoAnteriorController.dispose();
		valorDebitoController.dispose();
		valorCreditoController.dispose();
		saldoController.dispose();
		super.onClose();
	}
}