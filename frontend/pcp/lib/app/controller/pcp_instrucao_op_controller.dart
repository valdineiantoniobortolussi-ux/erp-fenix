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

class PcpInstrucaoOpController extends GetxController {

	// general
	final gridColumns = pcpInstrucaoOpGridColumns();
	
	var pcpInstrucaoOpModelList = <PcpInstrucaoOpModel>[];

	final _pcpInstrucaoOpModel = PcpInstrucaoOpModel().obs;
	PcpInstrucaoOpModel get pcpInstrucaoOpModel => _pcpInstrucaoOpModel.value;
	set pcpInstrucaoOpModel(value) => _pcpInstrucaoOpModel.value = value ?? PcpInstrucaoOpModel();
	
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
		for (var pcpInstrucaoOpModel in pcpInstrucaoOpModelList) {
			plutoRowList.add(_getPlutoRow(pcpInstrucaoOpModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PcpInstrucaoOpModel pcpInstrucaoOpModel) {
		return PlutoRow(
			cells: _getPlutoCells(pcpInstrucaoOpModel: pcpInstrucaoOpModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PcpInstrucaoOpModel? pcpInstrucaoOpModel}) {
		return {
			"id": PlutoCell(value: pcpInstrucaoOpModel?.id ?? 0),
			"pcpInstrucao": PlutoCell(value: pcpInstrucaoOpModel?.pcpInstrucaoModel?.descricao ?? ''),
			"idPcpOpCabecalho": PlutoCell(value: pcpInstrucaoOpModel?.idPcpOpCabecalho ?? 0),
			"idPcpInstrucao": PlutoCell(value: pcpInstrucaoOpModel?.idPcpInstrucao ?? 0),
		};
	}

	void plutoRowToObject() {
		pcpInstrucaoOpModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pcpInstrucaoOpModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			pcpInstrucaoModelController.text = currentRow.cells['pcpInstrucao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PcpInstrucaoOpEditPage());
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
	final pcpInstrucaoModelController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pcpInstrucaoOpModel.id;
		plutoRow.cells['idPcpOpCabecalho']?.value = pcpInstrucaoOpModel.idPcpOpCabecalho;
		plutoRow.cells['idPcpInstrucao']?.value = pcpInstrucaoOpModel.idPcpInstrucao;
		plutoRow.cells['pcpInstrucao']?.value = pcpInstrucaoOpModel.pcpInstrucaoModel?.descricao;
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
		pcpInstrucaoOpModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PcpInstrucaoOpModel();
			model.plutoRowToObject(plutoRow);
			pcpInstrucaoOpModelList.add(model);
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

	Future callPcpInstrucaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Instrucao]'; 
		lookupController.route = '/pcp-instrucao/'; 
		lookupController.gridColumns = pcpInstrucaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PcpInstrucaoModel.aliasColumns; 
		lookupController.dbColumns = PcpInstrucaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pcpInstrucaoOpModel.idPcpInstrucao = plutoRowResult.cells['id']!.value; 
			pcpInstrucaoOpModel.pcpInstrucaoModel!.plutoRowToObject(plutoRowResult); 
			pcpInstrucaoModelController.text = pcpInstrucaoOpModel.pcpInstrucaoModel?.descricao ?? ''; 
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
		pcpInstrucaoModelController.dispose();
		super.onClose();
	}
}