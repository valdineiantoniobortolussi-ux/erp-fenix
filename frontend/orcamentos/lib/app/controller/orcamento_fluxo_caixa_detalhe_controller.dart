import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:orcamentos/app/controller/controller_imports.dart';
import 'package:orcamentos/app/routes/app_routes.dart';

import 'package:orcamentos/app/infra/infra_imports.dart';
import 'package:orcamentos/app/data/model/model_imports.dart';
import 'package:orcamentos/app/page/page_imports.dart';
import 'package:orcamentos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:orcamentos/app/page/shared_widget/message_dialog.dart';

class OrcamentoFluxoCaixaDetalheController extends GetxController {

	// general
	final gridColumns = orcamentoFluxoCaixaDetalheGridColumns();
	
	var orcamentoFluxoCaixaDetalheModelList = <OrcamentoFluxoCaixaDetalheModel>[];

	final _orcamentoFluxoCaixaDetalheModel = OrcamentoFluxoCaixaDetalheModel().obs;
	OrcamentoFluxoCaixaDetalheModel get orcamentoFluxoCaixaDetalheModel => _orcamentoFluxoCaixaDetalheModel.value;
	set orcamentoFluxoCaixaDetalheModel(value) => _orcamentoFluxoCaixaDetalheModel.value = value ?? OrcamentoFluxoCaixaDetalheModel();
	
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
		for (var orcamentoFluxoCaixaDetalheModel in orcamentoFluxoCaixaDetalheModelList) {
			plutoRowList.add(_getPlutoRow(orcamentoFluxoCaixaDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(OrcamentoFluxoCaixaDetalheModel orcamentoFluxoCaixaDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(orcamentoFluxoCaixaDetalheModel: orcamentoFluxoCaixaDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ OrcamentoFluxoCaixaDetalheModel? orcamentoFluxoCaixaDetalheModel}) {
		return {
			"id": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.id ?? 0),
			"finNaturezaFinanceira": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.finNaturezaFinanceiraModel?.descricao ?? ''),
			"periodo": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.periodo ?? ''),
			"valorOrcado": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.valorOrcado ?? 0),
			"valorRealizado": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.valorRealizado ?? 0),
			"taxaVariacao": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.taxaVariacao ?? 0),
			"valorVariacao": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.valorVariacao ?? 0),
			"idOrcamentoFluxoCaixa": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.idOrcamentoFluxoCaixa ?? 0),
			"idFinNaturezaFinanceira": PlutoCell(value: orcamentoFluxoCaixaDetalheModel?.idFinNaturezaFinanceira ?? 0),
		};
	}

	void plutoRowToObject() {
		orcamentoFluxoCaixaDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return orcamentoFluxoCaixaDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			finNaturezaFinanceiraModelController.text = currentRow.cells['finNaturezaFinanceira']?.value ?? '';
			periodoController.text = currentRow.cells['periodo']?.value ?? '';
			valorOrcadoController.text = currentRow.cells['valorOrcado']?.value?.toStringAsFixed(2) ?? '';
			valorRealizadoController.text = currentRow.cells['valorRealizado']?.value?.toStringAsFixed(2) ?? '';
			taxaVariacaoController.text = currentRow.cells['taxaVariacao']?.value?.toStringAsFixed(2) ?? '';
			valorVariacaoController.text = currentRow.cells['valorVariacao']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => OrcamentoFluxoCaixaDetalheEditPage());
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
	final periodoController = TextEditingController();
	final valorOrcadoController = MoneyMaskedTextController();
	final valorRealizadoController = MoneyMaskedTextController();
	final taxaVariacaoController = MoneyMaskedTextController();
	final valorVariacaoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = orcamentoFluxoCaixaDetalheModel.id;
		plutoRow.cells['idOrcamentoFluxoCaixa']?.value = orcamentoFluxoCaixaDetalheModel.idOrcamentoFluxoCaixa;
		plutoRow.cells['idFinNaturezaFinanceira']?.value = orcamentoFluxoCaixaDetalheModel.idFinNaturezaFinanceira;
		plutoRow.cells['finNaturezaFinanceira']?.value = orcamentoFluxoCaixaDetalheModel.finNaturezaFinanceiraModel?.descricao;
		plutoRow.cells['periodo']?.value = orcamentoFluxoCaixaDetalheModel.periodo;
		plutoRow.cells['valorOrcado']?.value = orcamentoFluxoCaixaDetalheModel.valorOrcado;
		plutoRow.cells['valorRealizado']?.value = orcamentoFluxoCaixaDetalheModel.valorRealizado;
		plutoRow.cells['taxaVariacao']?.value = orcamentoFluxoCaixaDetalheModel.taxaVariacao;
		plutoRow.cells['valorVariacao']?.value = orcamentoFluxoCaixaDetalheModel.valorVariacao;
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
		orcamentoFluxoCaixaDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = OrcamentoFluxoCaixaDetalheModel();
			model.plutoRowToObject(plutoRow);
			orcamentoFluxoCaixaDetalheModelList.add(model);
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
			orcamentoFluxoCaixaDetalheModel.idFinNaturezaFinanceira = plutoRowResult.cells['id']!.value; 
			orcamentoFluxoCaixaDetalheModel.finNaturezaFinanceiraModel!.plutoRowToObject(plutoRowResult); 
			finNaturezaFinanceiraModelController.text = orcamentoFluxoCaixaDetalheModel.finNaturezaFinanceiraModel?.descricao ?? ''; 
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
		periodoController.dispose();
		valorOrcadoController.dispose();
		valorRealizadoController.dispose();
		taxaVariacaoController.dispose();
		valorVariacaoController.dispose();
		super.onClose();
	}
}