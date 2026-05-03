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

class ContabilLancamentoDetalheController extends GetxController {

	// general
	final gridColumns = contabilLancamentoDetalheGridColumns();
	
	var contabilLancamentoDetalheModelList = <ContabilLancamentoDetalheModel>[];

	final _contabilLancamentoDetalheModel = ContabilLancamentoDetalheModel().obs;
	ContabilLancamentoDetalheModel get contabilLancamentoDetalheModel => _contabilLancamentoDetalheModel.value;
	set contabilLancamentoDetalheModel(value) => _contabilLancamentoDetalheModel.value = value ?? ContabilLancamentoDetalheModel();
	
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
		for (var contabilLancamentoDetalheModel in contabilLancamentoDetalheModelList) {
			plutoRowList.add(_getPlutoRow(contabilLancamentoDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilLancamentoDetalheModel contabilLancamentoDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilLancamentoDetalheModel: contabilLancamentoDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilLancamentoDetalheModel? contabilLancamentoDetalheModel}) {
		return {
			"id": PlutoCell(value: contabilLancamentoDetalheModel?.id ?? 0),
			"contabilConta": PlutoCell(value: contabilLancamentoDetalheModel?.contabilContaModel?.descricao ?? ''),
			"contabilHistorico": PlutoCell(value: contabilLancamentoDetalheModel?.contabilHistoricoModel?.descricao ?? ''),
			"tipo": PlutoCell(value: contabilLancamentoDetalheModel?.tipo ?? ''),
			"valor": PlutoCell(value: contabilLancamentoDetalheModel?.valor ?? 0),
			"historico": PlutoCell(value: contabilLancamentoDetalheModel?.historico ?? ''),
			"idContabilLancamentoCab": PlutoCell(value: contabilLancamentoDetalheModel?.idContabilLancamentoCab ?? 0),
			"idContabilConta": PlutoCell(value: contabilLancamentoDetalheModel?.idContabilConta ?? 0),
			"idContabilHistorico": PlutoCell(value: contabilLancamentoDetalheModel?.idContabilHistorico ?? 0),
		};
	}

	void plutoRowToObject() {
		contabilLancamentoDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return contabilLancamentoDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			contabilContaModelController.text = currentRow.cells['contabilConta']?.value ?? '';
			contabilHistoricoModelController.text = currentRow.cells['contabilHistorico']?.value ?? '';
			valorController.text = currentRow.cells['valor']?.value?.toStringAsFixed(2) ?? '';
			historicoController.text = currentRow.cells['historico']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ContabilLancamentoDetalheEditPage());
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
	final contabilHistoricoModelController = TextEditingController();
	final valorController = MoneyMaskedTextController();
	final historicoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = contabilLancamentoDetalheModel.id;
		plutoRow.cells['idContabilLancamentoCab']?.value = contabilLancamentoDetalheModel.idContabilLancamentoCab;
		plutoRow.cells['idContabilConta']?.value = contabilLancamentoDetalheModel.idContabilConta;
		plutoRow.cells['contabilConta']?.value = contabilLancamentoDetalheModel.contabilContaModel?.descricao;
		plutoRow.cells['idContabilHistorico']?.value = contabilLancamentoDetalheModel.idContabilHistorico;
		plutoRow.cells['contabilHistorico']?.value = contabilLancamentoDetalheModel.contabilHistoricoModel?.descricao;
		plutoRow.cells['tipo']?.value = contabilLancamentoDetalheModel.tipo;
		plutoRow.cells['valor']?.value = contabilLancamentoDetalheModel.valor;
		plutoRow.cells['historico']?.value = contabilLancamentoDetalheModel.historico;
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
		contabilLancamentoDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ContabilLancamentoDetalheModel();
			model.plutoRowToObject(plutoRow);
			contabilLancamentoDetalheModelList.add(model);
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
		lookupController.title = '${'lookup_page_title'.tr} [Conta Contabil]'; 
		lookupController.route = '/contabil-conta/'; 
		lookupController.gridColumns = contabilContaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContabilContaModel.aliasColumns; 
		lookupController.dbColumns = ContabilContaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilLancamentoDetalheModel.idContabilConta = plutoRowResult.cells['id']!.value; 
			contabilLancamentoDetalheModel.contabilContaModel!.plutoRowToObject(plutoRowResult); 
			contabilContaModelController.text = contabilLancamentoDetalheModel.contabilContaModel?.descricao ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callContabilHistoricoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Historico]'; 
		lookupController.route = '/contabil-historico/'; 
		lookupController.gridColumns = contabilHistoricoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ContabilHistoricoModel.aliasColumns; 
		lookupController.dbColumns = ContabilHistoricoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			contabilLancamentoDetalheModel.idContabilHistorico = plutoRowResult.cells['id']!.value; 
			contabilLancamentoDetalheModel.contabilHistoricoModel!.plutoRowToObject(plutoRowResult); 
			contabilHistoricoModelController.text = contabilLancamentoDetalheModel.contabilHistoricoModel?.descricao ?? ''; 
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
		contabilHistoricoModelController.dispose();
		valorController.dispose();
		historicoController.dispose();
		super.onClose();
	}
}