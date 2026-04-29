import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:contabil/app/controller/controller_imports.dart';
import 'package:contabil/app/routes/app_routes.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/page_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';

class CtResultadoNtFinanceiraController extends GetxController {

	// general
	final gridColumns = ctResultadoNtFinanceiraGridColumns();
	
	var ctResultadoNtFinanceiraModelList = <CtResultadoNtFinanceiraModel>[];

	final _ctResultadoNtFinanceiraModel = CtResultadoNtFinanceiraModel().obs;
	CtResultadoNtFinanceiraModel get ctResultadoNtFinanceiraModel => _ctResultadoNtFinanceiraModel.value;
	set ctResultadoNtFinanceiraModel(value) => _ctResultadoNtFinanceiraModel.value = value ?? CtResultadoNtFinanceiraModel();
	
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
		for (var ctResultadoNtFinanceiraModel in ctResultadoNtFinanceiraModelList) {
			plutoRowList.add(_getPlutoRow(ctResultadoNtFinanceiraModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CtResultadoNtFinanceiraModel ctResultadoNtFinanceiraModel) {
		return PlutoRow(
			cells: _getPlutoCells(ctResultadoNtFinanceiraModel: ctResultadoNtFinanceiraModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CtResultadoNtFinanceiraModel? ctResultadoNtFinanceiraModel}) {
		return {
			"id": PlutoCell(value: ctResultadoNtFinanceiraModel?.id ?? 0),
			"finNaturezaFinanceira": PlutoCell(value: ctResultadoNtFinanceiraModel?.finNaturezaFinanceiraModel?.descricao ?? ''),
			"percentualRateio": PlutoCell(value: ctResultadoNtFinanceiraModel?.percentualRateio ?? 0),
			"idCentroResultado": PlutoCell(value: ctResultadoNtFinanceiraModel?.idCentroResultado ?? 0),
			"idFinNaturezaFinanceira": PlutoCell(value: ctResultadoNtFinanceiraModel?.idFinNaturezaFinanceira ?? 0),
		};
	}

	void plutoRowToObject() {
		ctResultadoNtFinanceiraModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return ctResultadoNtFinanceiraModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			finNaturezaFinanceiraModelController.text = currentRow.cells['finNaturezaFinanceira']?.value ?? '';
			percentualRateioController.text = currentRow.cells['percentualRateio']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CtResultadoNtFinanceiraEditPage());
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
	final finNaturezaFinanceiraModelController = TextEditingController();
	final percentualRateioController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = ctResultadoNtFinanceiraModel.id;
		plutoRow.cells['idCentroResultado']?.value = ctResultadoNtFinanceiraModel.idCentroResultado;
		plutoRow.cells['idFinNaturezaFinanceira']?.value = ctResultadoNtFinanceiraModel.idFinNaturezaFinanceira;
		plutoRow.cells['finNaturezaFinanceira']?.value = ctResultadoNtFinanceiraModel.finNaturezaFinanceiraModel?.descricao;
		plutoRow.cells['percentualRateio']?.value = ctResultadoNtFinanceiraModel.percentualRateio;
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
		ctResultadoNtFinanceiraModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CtResultadoNtFinanceiraModel();
			model.plutoRowToObject(plutoRow);
			ctResultadoNtFinanceiraModelList.add(model);
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

	Future callFinNaturezaFinanceiraLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Natureza Financeira]'; 
		lookupController.route = '/fin-natureza-financeira/'; 
		lookupController.gridColumns = finNaturezaFinanceiraGridColumns(isForLookup: true); 
		lookupController.aliasColumns = FinNaturezaFinanceiraModel.aliasColumns; 
		lookupController.dbColumns = FinNaturezaFinanceiraModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			ctResultadoNtFinanceiraModel.idFinNaturezaFinanceira = plutoRowResult.cells['id']!.value; 
			ctResultadoNtFinanceiraModel.finNaturezaFinanceiraModel!.plutoRowToObject(plutoRowResult); 
			finNaturezaFinanceiraModelController.text = ctResultadoNtFinanceiraModel.finNaturezaFinanceiraModel?.descricao ?? ''; 
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
		finNaturezaFinanceiraModelController.dispose();
		percentualRateioController.dispose();
		super.onClose();
	}
}