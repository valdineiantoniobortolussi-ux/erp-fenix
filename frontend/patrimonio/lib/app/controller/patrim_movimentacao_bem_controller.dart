import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/routes/app_routes.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/page_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';

class PatrimMovimentacaoBemController extends GetxController {

	// general
	final gridColumns = patrimMovimentacaoBemGridColumns();
	
	var patrimMovimentacaoBemModelList = <PatrimMovimentacaoBemModel>[];

	final _patrimMovimentacaoBemModel = PatrimMovimentacaoBemModel().obs;
	PatrimMovimentacaoBemModel get patrimMovimentacaoBemModel => _patrimMovimentacaoBemModel.value;
	set patrimMovimentacaoBemModel(value) => _patrimMovimentacaoBemModel.value = value ?? PatrimMovimentacaoBemModel();
	
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
		for (var patrimMovimentacaoBemModel in patrimMovimentacaoBemModelList) {
			plutoRowList.add(_getPlutoRow(patrimMovimentacaoBemModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PatrimMovimentacaoBemModel patrimMovimentacaoBemModel) {
		return PlutoRow(
			cells: _getPlutoCells(patrimMovimentacaoBemModel: patrimMovimentacaoBemModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PatrimMovimentacaoBemModel? patrimMovimentacaoBemModel}) {
		return {
			"id": PlutoCell(value: patrimMovimentacaoBemModel?.id ?? 0),
			"patrimTipoMovimentacao": PlutoCell(value: patrimMovimentacaoBemModel?.patrimTipoMovimentacaoModel?.nome ?? ''),
			"dataMovimentacao": PlutoCell(value: patrimMovimentacaoBemModel?.dataMovimentacao ?? ''),
			"responsavel": PlutoCell(value: patrimMovimentacaoBemModel?.responsavel ?? ''),
			"idPatrimBem": PlutoCell(value: patrimMovimentacaoBemModel?.idPatrimBem ?? 0),
			"idPatrimTipoMovimentacao": PlutoCell(value: patrimMovimentacaoBemModel?.idPatrimTipoMovimentacao ?? 0),
		};
	}

	void plutoRowToObject() {
		patrimMovimentacaoBemModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return patrimMovimentacaoBemModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			patrimTipoMovimentacaoModelController.text = currentRow.cells['patrimTipoMovimentacao']?.value ?? '';
			responsavelController.text = currentRow.cells['responsavel']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PatrimMovimentacaoBemEditPage());
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
	final patrimTipoMovimentacaoModelController = TextEditingController();
	final responsavelController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimMovimentacaoBemModel.id;
		plutoRow.cells['idPatrimBem']?.value = patrimMovimentacaoBemModel.idPatrimBem;
		plutoRow.cells['idPatrimTipoMovimentacao']?.value = patrimMovimentacaoBemModel.idPatrimTipoMovimentacao;
		plutoRow.cells['patrimTipoMovimentacao']?.value = patrimMovimentacaoBemModel.patrimTipoMovimentacaoModel?.nome;
		plutoRow.cells['dataMovimentacao']?.value = Util.formatDate(patrimMovimentacaoBemModel.dataMovimentacao);
		plutoRow.cells['responsavel']?.value = patrimMovimentacaoBemModel.responsavel;
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
		patrimMovimentacaoBemModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PatrimMovimentacaoBemModel();
			model.plutoRowToObject(plutoRow);
			patrimMovimentacaoBemModelList.add(model);
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

	Future callPatrimTipoMovimentacaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tipo Movimentacao]'; 
		lookupController.route = '/patrim-tipo-movimentacao/'; 
		lookupController.gridColumns = patrimTipoMovimentacaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = PatrimTipoMovimentacaoModel.aliasColumns; 
		lookupController.dbColumns = PatrimTipoMovimentacaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimMovimentacaoBemModel.idPatrimTipoMovimentacao = plutoRowResult.cells['id']!.value; 
			patrimMovimentacaoBemModel.patrimTipoMovimentacaoModel!.plutoRowToObject(plutoRowResult); 
			patrimTipoMovimentacaoModelController.text = patrimMovimentacaoBemModel.patrimTipoMovimentacaoModel?.nome ?? ''; 
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
		patrimTipoMovimentacaoModelController.dispose();
		responsavelController.dispose();
		super.onClose();
	}
}