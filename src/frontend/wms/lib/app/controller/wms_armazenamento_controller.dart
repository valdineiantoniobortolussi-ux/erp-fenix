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

class WmsArmazenamentoController extends GetxController {

	// general
	final gridColumns = wmsArmazenamentoGridColumns();
	
	var wmsArmazenamentoModelList = <WmsArmazenamentoModel>[];

	final _wmsArmazenamentoModel = WmsArmazenamentoModel().obs;
	WmsArmazenamentoModel get wmsArmazenamentoModel => _wmsArmazenamentoModel.value;
	set wmsArmazenamentoModel(value) => _wmsArmazenamentoModel.value = value ?? WmsArmazenamentoModel();
	
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
		for (var wmsArmazenamentoModel in wmsArmazenamentoModelList) {
			plutoRowList.add(_getPlutoRow(wmsArmazenamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(WmsArmazenamentoModel wmsArmazenamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(wmsArmazenamentoModel: wmsArmazenamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ WmsArmazenamentoModel? wmsArmazenamentoModel}) {
		return {
			"id": PlutoCell(value: wmsArmazenamentoModel?.id ?? 0),
			"wmsRecebimentoDetalhe": PlutoCell(value: wmsArmazenamentoModel?.wmsRecebimentoDetalheModel?.id ?? ''),
			"quantidade": PlutoCell(value: wmsArmazenamentoModel?.quantidade ?? 0),
			"idWmsCaixa": PlutoCell(value: wmsArmazenamentoModel?.idWmsCaixa ?? 0),
			"idWmsRecebimentoDetalhe": PlutoCell(value: wmsArmazenamentoModel?.idWmsRecebimentoDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		wmsArmazenamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return wmsArmazenamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			wmsRecebimentoDetalheModelController.text = currentRow.cells['wmsRecebimentoDetalhe']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => WmsArmazenamentoEditPage());
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
	final wmsRecebimentoDetalheModelController = TextEditingController();
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
		plutoRow.cells['id']?.value = wmsArmazenamentoModel.id;
		plutoRow.cells['idWmsCaixa']?.value = wmsArmazenamentoModel.idWmsCaixa;
		plutoRow.cells['idWmsRecebimentoDetalhe']?.value = wmsArmazenamentoModel.idWmsRecebimentoDetalhe;
		plutoRow.cells['wmsRecebimentoDetalhe']?.value = wmsArmazenamentoModel.wmsRecebimentoDetalheModel?.id;
		plutoRow.cells['quantidade']?.value = wmsArmazenamentoModel.quantidade;
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
		wmsArmazenamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = WmsArmazenamentoModel();
			model.plutoRowToObject(plutoRow);
			wmsArmazenamentoModelList.add(model);
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

	Future callWmsRecebimentoDetalheLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Item Recebimento]'; 
		lookupController.route = '/wms-recebimento-detalhe/'; 
		lookupController.gridColumns = wmsRecebimentoDetalheGridColumns(isForLookup: true); 
		lookupController.aliasColumns = WmsRecebimentoDetalheModel.aliasColumns; 
		lookupController.dbColumns = WmsRecebimentoDetalheModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			wmsArmazenamentoModel.idWmsRecebimentoDetalhe = plutoRowResult.cells['id']!.value; 
			wmsArmazenamentoModel.wmsRecebimentoDetalheModel!.plutoRowToObject(plutoRowResult); 
			wmsRecebimentoDetalheModelController.text = wmsArmazenamentoModel.wmsRecebimentoDetalheModel?.id?.toString() ?? ''; 
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
		wmsRecebimentoDetalheModelController.dispose();
		quantidadeController.dispose();
		super.onClose();
	}
}