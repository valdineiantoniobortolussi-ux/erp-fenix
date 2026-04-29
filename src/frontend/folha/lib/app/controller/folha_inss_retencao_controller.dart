import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:folha/app/controller/controller_imports.dart';
import 'package:folha/app/routes/app_routes.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/page_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';

class FolhaInssRetencaoController extends GetxController {

	// general
	final gridColumns = folhaInssRetencaoGridColumns();
	
	var folhaInssRetencaoModelList = <FolhaInssRetencaoModel>[];

	final _folhaInssRetencaoModel = FolhaInssRetencaoModel().obs;
	FolhaInssRetencaoModel get folhaInssRetencaoModel => _folhaInssRetencaoModel.value;
	set folhaInssRetencaoModel(value) => _folhaInssRetencaoModel.value = value ?? FolhaInssRetencaoModel();
	
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
		for (var folhaInssRetencaoModel in folhaInssRetencaoModelList) {
			plutoRowList.add(_getPlutoRow(folhaInssRetencaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaInssRetencaoModel folhaInssRetencaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaInssRetencaoModel: folhaInssRetencaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaInssRetencaoModel? folhaInssRetencaoModel}) {
		return {
			"id": PlutoCell(value: folhaInssRetencaoModel?.id ?? 0),
			"folhaInssServico": PlutoCell(value: folhaInssRetencaoModel?.folhaInssServicoModel?.nome ?? ''),
			"valorMensal": PlutoCell(value: folhaInssRetencaoModel?.valorMensal ?? 0),
			"valor13": PlutoCell(value: folhaInssRetencaoModel?.valor13 ?? 0),
			"idFolhaInss": PlutoCell(value: folhaInssRetencaoModel?.idFolhaInss ?? 0),
			"idFolhaInssServico": PlutoCell(value: folhaInssRetencaoModel?.idFolhaInssServico ?? 0),
		};
	}

	void plutoRowToObject() {
		folhaInssRetencaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return folhaInssRetencaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			folhaInssServicoModelController.text = currentRow.cells['folhaInssServico']?.value ?? '';
			valorMensalController.text = currentRow.cells['valorMensal']?.value?.toStringAsFixed(2) ?? '';
			valor13Controller.text = currentRow.cells['valor13']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FolhaInssRetencaoEditPage());
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
	final folhaInssServicoModelController = TextEditingController();
	final valorMensalController = MoneyMaskedTextController();
	final valor13Controller = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaInssRetencaoModel.id;
		plutoRow.cells['idFolhaInss']?.value = folhaInssRetencaoModel.idFolhaInss;
		plutoRow.cells['idFolhaInssServico']?.value = folhaInssRetencaoModel.idFolhaInssServico;
		plutoRow.cells['folhaInssServico']?.value = folhaInssRetencaoModel.folhaInssServicoModel?.nome;
		plutoRow.cells['valorMensal']?.value = folhaInssRetencaoModel.valorMensal;
		plutoRow.cells['valor13']?.value = folhaInssRetencaoModel.valor13;
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
		folhaInssRetencaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FolhaInssRetencaoModel();
			model.plutoRowToObject(plutoRow);
			folhaInssRetencaoModelList.add(model);
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

	Future callFolhaInssServicoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Serviço INSS]'; 
		lookupController.route = '/folha-inss-servico/'; 
		lookupController.gridColumns = folhaInssServicoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FolhaInssServicoModel.aliasColumns; 
		lookupController.dbColumns = FolhaInssServicoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			folhaInssRetencaoModel.idFolhaInssServico = plutoRowResult.cells['id']!.value; 
			folhaInssRetencaoModel.folhaInssServicoModel!.plutoRowToObject(plutoRowResult); 
			folhaInssServicoModelController.text = folhaInssRetencaoModel.folhaInssServicoModel?.nome ?? ''; 
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
		folhaInssServicoModelController.dispose();
		valorMensalController.dispose();
		valor13Controller.dispose();
		super.onClose();
	}
}