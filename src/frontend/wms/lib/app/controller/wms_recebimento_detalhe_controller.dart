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

class WmsRecebimentoDetalheController extends GetxController {

	// general
	final gridColumns = wmsRecebimentoDetalheGridColumns();
	
	var wmsRecebimentoDetalheModelList = <WmsRecebimentoDetalheModel>[];

	final _wmsRecebimentoDetalheModel = WmsRecebimentoDetalheModel().obs;
	WmsRecebimentoDetalheModel get wmsRecebimentoDetalheModel => _wmsRecebimentoDetalheModel.value;
	set wmsRecebimentoDetalheModel(value) => _wmsRecebimentoDetalheModel.value = value ?? WmsRecebimentoDetalheModel();
	
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
		for (var wmsRecebimentoDetalheModel in wmsRecebimentoDetalheModelList) {
			plutoRowList.add(_getPlutoRow(wmsRecebimentoDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(WmsRecebimentoDetalheModel wmsRecebimentoDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(wmsRecebimentoDetalheModel: wmsRecebimentoDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ WmsRecebimentoDetalheModel? wmsRecebimentoDetalheModel}) {
		return {
			"id": PlutoCell(value: wmsRecebimentoDetalheModel?.id ?? 0),
			"produto": PlutoCell(value: wmsRecebimentoDetalheModel?.produtoModel?.nome ?? ''),
			"quantidadeVolume": PlutoCell(value: wmsRecebimentoDetalheModel?.quantidadeVolume ?? 0),
			"quantidadeItemPorVolume": PlutoCell(value: wmsRecebimentoDetalheModel?.quantidadeItemPorVolume ?? 0),
			"quantidadeRecebida": PlutoCell(value: wmsRecebimentoDetalheModel?.quantidadeRecebida ?? 0),
			"destino": PlutoCell(value: wmsRecebimentoDetalheModel?.destino ?? ''),
			"idWmsRecebimentoCabecalho": PlutoCell(value: wmsRecebimentoDetalheModel?.idWmsRecebimentoCabecalho ?? 0),
			"idProduto": PlutoCell(value: wmsRecebimentoDetalheModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		wmsRecebimentoDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return wmsRecebimentoDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			quantidadeVolumeController.text = currentRow.cells['quantidadeVolume']?.value?.toString() ?? '';
			quantidadeItemPorVolumeController.text = currentRow.cells['quantidadeItemPorVolume']?.value?.toString() ?? '';
			quantidadeRecebidaController.text = currentRow.cells['quantidadeRecebida']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => WmsRecebimentoDetalheEditPage());
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
	final quantidadeVolumeController = TextEditingController();
	final quantidadeItemPorVolumeController = TextEditingController();
	final quantidadeRecebidaController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = wmsRecebimentoDetalheModel.id;
		plutoRow.cells['idWmsRecebimentoCabecalho']?.value = wmsRecebimentoDetalheModel.idWmsRecebimentoCabecalho;
		plutoRow.cells['idProduto']?.value = wmsRecebimentoDetalheModel.idProduto;
		plutoRow.cells['produto']?.value = wmsRecebimentoDetalheModel.produtoModel?.nome;
		plutoRow.cells['quantidadeVolume']?.value = wmsRecebimentoDetalheModel.quantidadeVolume;
		plutoRow.cells['quantidadeItemPorVolume']?.value = wmsRecebimentoDetalheModel.quantidadeItemPorVolume;
		plutoRow.cells['quantidadeRecebida']?.value = wmsRecebimentoDetalheModel.quantidadeRecebida;
		plutoRow.cells['destino']?.value = wmsRecebimentoDetalheModel.destino;
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
		wmsRecebimentoDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = WmsRecebimentoDetalheModel();
			model.plutoRowToObject(plutoRow);
			wmsRecebimentoDetalheModelList.add(model);
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
			wmsRecebimentoDetalheModel.idProduto = plutoRowResult.cells['id']!.value; 
			wmsRecebimentoDetalheModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = wmsRecebimentoDetalheModel.produtoModel?.nome ?? ''; 
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
		quantidadeVolumeController.dispose();
		quantidadeItemPorVolumeController.dispose();
		quantidadeRecebidaController.dispose();
		super.onClose();
	}
}