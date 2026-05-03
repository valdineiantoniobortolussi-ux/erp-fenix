import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:wms/app/controller/controller_imports.dart';
import 'package:wms/app/routes/app_routes.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/page/page_imports.dart';
import 'package:wms/app/page/grid_columns/grid_columns_imports.dart';
import 'package:wms/app/page/shared_widget/message_dialog.dart';

class WmsOrdemSeparacaoDetController extends GetxController {

	// general
	final gridColumns = wmsOrdemSeparacaoDetGridColumns();
	
	var wmsOrdemSeparacaoDetModelList = <WmsOrdemSeparacaoDetModel>[];

	final _wmsOrdemSeparacaoDetModel = WmsOrdemSeparacaoDetModel().obs;
	WmsOrdemSeparacaoDetModel get wmsOrdemSeparacaoDetModel => _wmsOrdemSeparacaoDetModel.value;
	set wmsOrdemSeparacaoDetModel(value) => _wmsOrdemSeparacaoDetModel.value = value ?? WmsOrdemSeparacaoDetModel();
	
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
		for (var wmsOrdemSeparacaoDetModel in wmsOrdemSeparacaoDetModelList) {
			plutoRowList.add(_getPlutoRow(wmsOrdemSeparacaoDetModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(WmsOrdemSeparacaoDetModel wmsOrdemSeparacaoDetModel) {
		return PlutoRow(
			cells: _getPlutoCells(wmsOrdemSeparacaoDetModel: wmsOrdemSeparacaoDetModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ WmsOrdemSeparacaoDetModel? wmsOrdemSeparacaoDetModel}) {
		return {
			"id": PlutoCell(value: wmsOrdemSeparacaoDetModel?.id ?? 0),
			"produto": PlutoCell(value: wmsOrdemSeparacaoDetModel?.produtoModel?.nome ?? ''),
			"quantidade": PlutoCell(value: wmsOrdemSeparacaoDetModel?.quantidade ?? 0),
			"idWmsOrdemSeparacaoCab": PlutoCell(value: wmsOrdemSeparacaoDetModel?.idWmsOrdemSeparacaoCab ?? 0),
			"idProduto": PlutoCell(value: wmsOrdemSeparacaoDetModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		wmsOrdemSeparacaoDetModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return wmsOrdemSeparacaoDetModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => WmsOrdemSeparacaoDetEditPage());
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
	final quantidadeController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsOrdemSeparacaoDetModel.id;
		plutoRow.cells['idWmsOrdemSeparacaoCab']?.value = wmsOrdemSeparacaoDetModel.idWmsOrdemSeparacaoCab;
		plutoRow.cells['idProduto']?.value = wmsOrdemSeparacaoDetModel.idProduto;
		plutoRow.cells['produto']?.value = wmsOrdemSeparacaoDetModel.produtoModel?.nome;
		plutoRow.cells['quantidade']?.value = wmsOrdemSeparacaoDetModel.quantidade;
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
		wmsOrdemSeparacaoDetModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = WmsOrdemSeparacaoDetModel();
			model.plutoRowToObject(plutoRow);
			wmsOrdemSeparacaoDetModelList.add(model);
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
			wmsOrdemSeparacaoDetModel.idProduto = plutoRowResult.cells['id']!.value; 
			wmsOrdemSeparacaoDetModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = wmsOrdemSeparacaoDetModel.produtoModel?.nome ?? ''; 
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
		quantidadeController.dispose();
		super.onClose();
	}
}