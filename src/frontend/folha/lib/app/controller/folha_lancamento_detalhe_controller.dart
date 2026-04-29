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

class FolhaLancamentoDetalheController extends GetxController {

	// general
	final gridColumns = folhaLancamentoDetalheGridColumns();
	
	var folhaLancamentoDetalheModelList = <FolhaLancamentoDetalheModel>[];

	final _folhaLancamentoDetalheModel = FolhaLancamentoDetalheModel().obs;
	FolhaLancamentoDetalheModel get folhaLancamentoDetalheModel => _folhaLancamentoDetalheModel.value;
	set folhaLancamentoDetalheModel(value) => _folhaLancamentoDetalheModel.value = value ?? FolhaLancamentoDetalheModel();
	
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
		for (var folhaLancamentoDetalheModel in folhaLancamentoDetalheModelList) {
			plutoRowList.add(_getPlutoRow(folhaLancamentoDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaLancamentoDetalheModel folhaLancamentoDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaLancamentoDetalheModel: folhaLancamentoDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaLancamentoDetalheModel? folhaLancamentoDetalheModel}) {
		return {
			"id": PlutoCell(value: folhaLancamentoDetalheModel?.id ?? 0),
			"folhaEvento": PlutoCell(value: folhaLancamentoDetalheModel?.folhaEventoModel?.nome ?? ''),
			"origem": PlutoCell(value: folhaLancamentoDetalheModel?.origem ?? 0),
			"provento": PlutoCell(value: folhaLancamentoDetalheModel?.provento ?? 0),
			"desconto": PlutoCell(value: folhaLancamentoDetalheModel?.desconto ?? 0),
			"idFolhaLancamentoCabecalho": PlutoCell(value: folhaLancamentoDetalheModel?.idFolhaLancamentoCabecalho ?? 0),
			"idFolhaEvento": PlutoCell(value: folhaLancamentoDetalheModel?.idFolhaEvento ?? 0),
		};
	}

	void plutoRowToObject() {
		folhaLancamentoDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return folhaLancamentoDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			folhaEventoModelController.text = currentRow.cells['folhaEvento']?.value ?? '';
			origemController.text = currentRow.cells['origem']?.value?.toStringAsFixed(2) ?? '';
			proventoController.text = currentRow.cells['provento']?.value?.toStringAsFixed(2) ?? '';
			descontoController.text = currentRow.cells['desconto']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FolhaLancamentoDetalheEditPage());
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
	final folhaEventoModelController = TextEditingController();
	final origemController = MoneyMaskedTextController();
	final proventoController = MoneyMaskedTextController();
	final descontoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaLancamentoDetalheModel.id;
		plutoRow.cells['idFolhaLancamentoCabecalho']?.value = folhaLancamentoDetalheModel.idFolhaLancamentoCabecalho;
		plutoRow.cells['idFolhaEvento']?.value = folhaLancamentoDetalheModel.idFolhaEvento;
		plutoRow.cells['folhaEvento']?.value = folhaLancamentoDetalheModel.folhaEventoModel?.nome;
		plutoRow.cells['origem']?.value = folhaLancamentoDetalheModel.origem;
		plutoRow.cells['provento']?.value = folhaLancamentoDetalheModel.provento;
		plutoRow.cells['desconto']?.value = folhaLancamentoDetalheModel.desconto;
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
		folhaLancamentoDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FolhaLancamentoDetalheModel();
			model.plutoRowToObject(plutoRow);
			folhaLancamentoDetalheModelList.add(model);
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

	Future callFolhaEventoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Evento]'; 
		lookupController.route = '/folha-evento/'; 
		lookupController.gridColumns = folhaEventoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FolhaEventoModel.aliasColumns; 
		lookupController.dbColumns = FolhaEventoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			folhaLancamentoDetalheModel.idFolhaEvento = plutoRowResult.cells['id']!.value; 
			folhaLancamentoDetalheModel.folhaEventoModel!.plutoRowToObject(plutoRowResult); 
			folhaEventoModelController.text = folhaLancamentoDetalheModel.folhaEventoModel?.nome ?? ''; 
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
		folhaEventoModelController.dispose();
		origemController.dispose();
		proventoController.dispose();
		descontoController.dispose();
		super.onClose();
	}
}