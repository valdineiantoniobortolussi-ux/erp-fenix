import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:projetos/app/controller/controller_imports.dart';
import 'package:projetos/app/routes/app_routes.dart';

import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/data/model/model_imports.dart';
import 'package:projetos/app/page/page_imports.dart';
import 'package:projetos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:projetos/app/page/shared_widget/message_dialog.dart';

class ProjetoCustoController extends GetxController {

	// general
	final gridColumns = projetoCustoGridColumns();
	
	var projetoCustoModelList = <ProjetoCustoModel>[];

	final _projetoCustoModel = ProjetoCustoModel().obs;
	ProjetoCustoModel get projetoCustoModel => _projetoCustoModel.value;
	set projetoCustoModel(value) => _projetoCustoModel.value = value ?? ProjetoCustoModel();
	
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
		for (var projetoCustoModel in projetoCustoModelList) {
			plutoRowList.add(_getPlutoRow(projetoCustoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ProjetoCustoModel projetoCustoModel) {
		return PlutoRow(
			cells: _getPlutoCells(projetoCustoModel: projetoCustoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ProjetoCustoModel? projetoCustoModel}) {
		return {
			"id": PlutoCell(value: projetoCustoModel?.id ?? 0),
			"finNaturezaFinanceira": PlutoCell(value: projetoCustoModel?.finNaturezaFinanceiraModel?.descricao ?? ''),
			"nome": PlutoCell(value: projetoCustoModel?.nome ?? ''),
			"valorMensal": PlutoCell(value: projetoCustoModel?.valorMensal ?? 0),
			"valorTotal": PlutoCell(value: projetoCustoModel?.valorTotal ?? 0),
			"justificativa": PlutoCell(value: projetoCustoModel?.justificativa ?? ''),
			"idProjetoPrincipal": PlutoCell(value: projetoCustoModel?.idProjetoPrincipal ?? 0),
			"idFinNaturezaFinanceira": PlutoCell(value: projetoCustoModel?.idFinNaturezaFinanceira ?? 0),
		};
	}

	void plutoRowToObject() {
		projetoCustoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return projetoCustoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			finNaturezaFinanceiraModelController.text = currentRow.cells['finNaturezaFinanceira']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			valorMensalController.text = currentRow.cells['valorMensal']?.value?.toStringAsFixed(2) ?? '';
			valorTotalController.text = currentRow.cells['valorTotal']?.value?.toStringAsFixed(2) ?? '';
			justificativaController.text = currentRow.cells['justificativa']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ProjetoCustoEditPage());
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
	final nomeController = TextEditingController();
	final valorMensalController = MoneyMaskedTextController();
	final valorTotalController = MoneyMaskedTextController();
	final justificativaController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = projetoCustoModel.id;
		plutoRow.cells['idProjetoPrincipal']?.value = projetoCustoModel.idProjetoPrincipal;
		plutoRow.cells['idFinNaturezaFinanceira']?.value = projetoCustoModel.idFinNaturezaFinanceira;
		plutoRow.cells['finNaturezaFinanceira']?.value = projetoCustoModel.finNaturezaFinanceiraModel?.descricao;
		plutoRow.cells['nome']?.value = projetoCustoModel.nome;
		plutoRow.cells['valorMensal']?.value = projetoCustoModel.valorMensal;
		plutoRow.cells['valorTotal']?.value = projetoCustoModel.valorTotal;
		plutoRow.cells['justificativa']?.value = projetoCustoModel.justificativa;
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
		projetoCustoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ProjetoCustoModel();
			model.plutoRowToObject(plutoRow);
			projetoCustoModelList.add(model);
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
			projetoCustoModel.idFinNaturezaFinanceira = plutoRowResult.cells['id']!.value; 
			projetoCustoModel.finNaturezaFinanceiraModel!.plutoRowToObject(plutoRowResult); 
			finNaturezaFinanceiraModelController.text = projetoCustoModel.finNaturezaFinanceiraModel?.descricao ?? ''; 
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
		nomeController.dispose();
		valorMensalController.dispose();
		valorTotalController.dispose();
		justificativaController.dispose();
		super.onClose();
	}
}