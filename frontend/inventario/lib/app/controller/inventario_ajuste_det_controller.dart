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

class InventarioAjusteDetController extends GetxController {

	// general
	final gridColumns = inventarioAjusteDetGridColumns();
	
	var inventarioAjusteDetModelList = <InventarioAjusteDetModel>[];

	final _inventarioAjusteDetModel = InventarioAjusteDetModel().obs;
	InventarioAjusteDetModel get inventarioAjusteDetModel => _inventarioAjusteDetModel.value;
	set inventarioAjusteDetModel(value) => _inventarioAjusteDetModel.value = value ?? InventarioAjusteDetModel();
	
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
		for (var inventarioAjusteDetModel in inventarioAjusteDetModelList) {
			plutoRowList.add(_getPlutoRow(inventarioAjusteDetModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(InventarioAjusteDetModel inventarioAjusteDetModel) {
		return PlutoRow(
			cells: _getPlutoCells(inventarioAjusteDetModel: inventarioAjusteDetModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ InventarioAjusteDetModel? inventarioAjusteDetModel}) {
		return {
			"id": PlutoCell(value: inventarioAjusteDetModel?.id ?? 0),
			"produto": PlutoCell(value: inventarioAjusteDetModel?.produtoModel?.nome ?? ''),
			"valorOriginal": PlutoCell(value: inventarioAjusteDetModel?.valorOriginal ?? 0),
			"valorReajuste": PlutoCell(value: inventarioAjusteDetModel?.valorReajuste ?? 0),
			"idInventarioAjusteCab": PlutoCell(value: inventarioAjusteDetModel?.idInventarioAjusteCab ?? 0),
			"idProduto": PlutoCell(value: inventarioAjusteDetModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		inventarioAjusteDetModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return inventarioAjusteDetModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			valorOriginalController.text = currentRow.cells['valorOriginal']?.value?.toStringAsFixed(2) ?? '';
			valorReajusteController.text = currentRow.cells['valorReajuste']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => InventarioAjusteDetEditPage());
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
	final valorOriginalController = MoneyMaskedTextController();
	final valorReajusteController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = inventarioAjusteDetModel.id;
		plutoRow.cells['idInventarioAjusteCab']?.value = inventarioAjusteDetModel.idInventarioAjusteCab;
		plutoRow.cells['idProduto']?.value = inventarioAjusteDetModel.idProduto;
		plutoRow.cells['produto']?.value = inventarioAjusteDetModel.produtoModel?.nome;
		plutoRow.cells['valorOriginal']?.value = inventarioAjusteDetModel.valorOriginal;
		plutoRow.cells['valorReajuste']?.value = inventarioAjusteDetModel.valorReajuste;
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
		inventarioAjusteDetModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = InventarioAjusteDetModel();
			model.plutoRowToObject(plutoRow);
			inventarioAjusteDetModelList.add(model);
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
			inventarioAjusteDetModel.idProduto = plutoRowResult.cells['id']!.value; 
			inventarioAjusteDetModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = inventarioAjusteDetModel.produtoModel?.nome ?? ''; 
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
		valorOriginalController.dispose();
		valorReajusteController.dispose();
		super.onClose();
	}
}