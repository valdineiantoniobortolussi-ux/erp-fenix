import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:inventario/app/controller/controller_imports.dart';
import 'package:inventario/app/routes/app_routes.dart';

import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:inventario/app/page/page_imports.dart';
import 'package:inventario/app/page/grid_columns/grid_columns_imports.dart';
import 'package:inventario/app/page/shared_widget/message_dialog.dart';

class InventarioContagemDetController extends GetxController {

	// general
	final gridColumns = inventarioContagemDetGridColumns();
	
	var inventarioContagemDetModelList = <InventarioContagemDetModel>[];

	final _inventarioContagemDetModel = InventarioContagemDetModel().obs;
	InventarioContagemDetModel get inventarioContagemDetModel => _inventarioContagemDetModel.value;
	set inventarioContagemDetModel(value) => _inventarioContagemDetModel.value = value ?? InventarioContagemDetModel();
	
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
		for (var inventarioContagemDetModel in inventarioContagemDetModelList) {
			plutoRowList.add(_getPlutoRow(inventarioContagemDetModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(InventarioContagemDetModel inventarioContagemDetModel) {
		return PlutoRow(
			cells: _getPlutoCells(inventarioContagemDetModel: inventarioContagemDetModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ InventarioContagemDetModel? inventarioContagemDetModel}) {
		return {
			"id": PlutoCell(value: inventarioContagemDetModel?.id ?? 0),
			"produto": PlutoCell(value: inventarioContagemDetModel?.produtoModel?.nome ?? ''),
			"contagem01": PlutoCell(value: inventarioContagemDetModel?.contagem01 ?? 0),
			"contagem02": PlutoCell(value: inventarioContagemDetModel?.contagem02 ?? 0),
			"contagem03": PlutoCell(value: inventarioContagemDetModel?.contagem03 ?? 0),
			"fechadoContagem": PlutoCell(value: inventarioContagemDetModel?.fechadoContagem ?? ''),
			"quantidadeSistema": PlutoCell(value: inventarioContagemDetModel?.quantidadeSistema ?? 0),
			"acuracidade": PlutoCell(value: inventarioContagemDetModel?.acuracidade ?? 0),
			"divergencia": PlutoCell(value: inventarioContagemDetModel?.divergencia ?? 0),
			"idInventarioContagemCab": PlutoCell(value: inventarioContagemDetModel?.idInventarioContagemCab ?? 0),
			"idProduto": PlutoCell(value: inventarioContagemDetModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		inventarioContagemDetModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return inventarioContagemDetModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			contagem01Controller.text = currentRow.cells['contagem01']?.value?.toStringAsFixed(2) ?? '';
			contagem02Controller.text = currentRow.cells['contagem02']?.value?.toStringAsFixed(2) ?? '';
			contagem03Controller.text = currentRow.cells['contagem03']?.value?.toStringAsFixed(2) ?? '';
			quantidadeSistemaController.text = currentRow.cells['quantidadeSistema']?.value?.toStringAsFixed(2) ?? '';
			acuracidadeController.text = currentRow.cells['acuracidade']?.value?.toStringAsFixed(2) ?? '';
			divergenciaController.text = currentRow.cells['divergencia']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => InventarioContagemDetEditPage());
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
	final produtoModelController = TextEditingController();
	final contagem01Controller = MoneyMaskedTextController();
	final contagem02Controller = MoneyMaskedTextController();
	final contagem03Controller = MoneyMaskedTextController();
	final quantidadeSistemaController = MoneyMaskedTextController();
	final acuracidadeController = MoneyMaskedTextController();
	final divergenciaController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = inventarioContagemDetModel.id;
		plutoRow.cells['idInventarioContagemCab']?.value = inventarioContagemDetModel.idInventarioContagemCab;
		plutoRow.cells['idProduto']?.value = inventarioContagemDetModel.idProduto;
		plutoRow.cells['produto']?.value = inventarioContagemDetModel.produtoModel?.nome;
		plutoRow.cells['contagem01']?.value = inventarioContagemDetModel.contagem01;
		plutoRow.cells['contagem02']?.value = inventarioContagemDetModel.contagem02;
		plutoRow.cells['contagem03']?.value = inventarioContagemDetModel.contagem03;
		plutoRow.cells['fechadoContagem']?.value = inventarioContagemDetModel.fechadoContagem;
		plutoRow.cells['quantidadeSistema']?.value = inventarioContagemDetModel.quantidadeSistema;
		plutoRow.cells['acuracidade']?.value = inventarioContagemDetModel.acuracidade;
		plutoRow.cells['divergencia']?.value = inventarioContagemDetModel.divergencia;
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
		inventarioContagemDetModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = InventarioContagemDetModel();
			model.plutoRowToObject(plutoRow);
			inventarioContagemDetModelList.add(model);
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

	Future callProdutoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Produto]'; 
		lookupController.route = '/produto/'; 
		lookupController.gridColumns = produtoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoModel.aliasColumns; 
		lookupController.dbColumns = ProdutoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			inventarioContagemDetModel.idProduto = plutoRowResult.cells['id']!.value; 
			inventarioContagemDetModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = inventarioContagemDetModel.produtoModel?.nome ?? ''; 
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
		produtoModelController.dispose();
		contagem01Controller.dispose();
		contagem02Controller.dispose();
		contagem03Controller.dispose();
		quantidadeSistemaController.dispose();
		acuracidadeController.dispose();
		divergenciaController.dispose();
		super.onClose();
	}
}