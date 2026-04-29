import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:pcp/app/controller/controller_imports.dart';
import 'package:pcp/app/routes/app_routes.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:pcp/app/page/page_imports.dart';
import 'package:pcp/app/page/grid_columns/grid_columns_imports.dart';
import 'package:pcp/app/page/shared_widget/message_dialog.dart';

class PcpServicoEquipamentoController extends GetxController {

	// general
	final gridColumns = pcpServicoEquipamentoGridColumns();
	
	var pcpServicoEquipamentoModelList = <PcpServicoEquipamentoModel>[];

	final _pcpServicoEquipamentoModel = PcpServicoEquipamentoModel().obs;
	PcpServicoEquipamentoModel get pcpServicoEquipamentoModel => _pcpServicoEquipamentoModel.value;
	set pcpServicoEquipamentoModel(value) => _pcpServicoEquipamentoModel.value = value ?? PcpServicoEquipamentoModel();
	
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
		for (var pcpServicoEquipamentoModel in pcpServicoEquipamentoModelList) {
			plutoRowList.add(_getPlutoRow(pcpServicoEquipamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PcpServicoEquipamentoModel pcpServicoEquipamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pcpServicoEquipamentoModel: pcpServicoEquipamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PcpServicoEquipamentoModel? pcpServicoEquipamentoModel}) {
		return {
			"id": PlutoCell(value: pcpServicoEquipamentoModel?.id ?? 0),
			"patrimBem": PlutoCell(value: pcpServicoEquipamentoModel?.patrimBemModel?.nome ?? ''),
			"idPcpServico": PlutoCell(value: pcpServicoEquipamentoModel?.idPcpServico ?? 0),
			"idPatrimBem": PlutoCell(value: pcpServicoEquipamentoModel?.idPatrimBem ?? 0),
		};
	}

	void plutoRowToObject() {
		pcpServicoEquipamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pcpServicoEquipamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			patrimBemModelController.text = currentRow.cells['patrimBem']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PcpServicoEquipamentoEditPage());
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
	final patrimBemModelController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pcpServicoEquipamentoModel.id;
		plutoRow.cells['idPcpServico']?.value = pcpServicoEquipamentoModel.idPcpServico;
		plutoRow.cells['idPatrimBem']?.value = pcpServicoEquipamentoModel.idPatrimBem;
		plutoRow.cells['patrimBem']?.value = pcpServicoEquipamentoModel.patrimBemModel?.nome;
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
		pcpServicoEquipamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PcpServicoEquipamentoModel();
			model.plutoRowToObject(plutoRow);
			pcpServicoEquipamentoModelList.add(model);
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

	Future callPatrimBemLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Equipamento]'; 
		lookupController.route = '/patrim-bem/'; 
		lookupController.gridColumns = patrimBemGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PatrimBemModel.aliasColumns; 
		lookupController.dbColumns = PatrimBemModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pcpServicoEquipamentoModel.idPatrimBem = plutoRowResult.cells['id']!.value; 
			pcpServicoEquipamentoModel.patrimBemModel!.plutoRowToObject(plutoRowResult); 
			patrimBemModelController.text = pcpServicoEquipamentoModel.patrimBemModel?.nome ?? ''; 
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
		patrimBemModelController.dispose();
		super.onClose();
	}
}