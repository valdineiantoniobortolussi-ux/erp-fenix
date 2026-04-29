import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:patrimonio/app/controller/controller_imports.dart';
import 'package:patrimonio/app/routes/app_routes.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:patrimonio/app/data/model/model_imports.dart';
import 'package:patrimonio/app/page/page_imports.dart';
import 'package:patrimonio/app/page/grid_columns/grid_columns_imports.dart';
import 'package:patrimonio/app/page/shared_widget/message_dialog.dart';

class PatrimApoliceSeguroController extends GetxController {

	// general
	final gridColumns = patrimApoliceSeguroGridColumns();
	
	var patrimApoliceSeguroModelList = <PatrimApoliceSeguroModel>[];

	final _patrimApoliceSeguroModel = PatrimApoliceSeguroModel().obs;
	PatrimApoliceSeguroModel get patrimApoliceSeguroModel => _patrimApoliceSeguroModel.value;
	set patrimApoliceSeguroModel(value) => _patrimApoliceSeguroModel.value = value ?? PatrimApoliceSeguroModel();
	
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
		for (var patrimApoliceSeguroModel in patrimApoliceSeguroModelList) {
			plutoRowList.add(_getPlutoRow(patrimApoliceSeguroModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PatrimApoliceSeguroModel patrimApoliceSeguroModel) {
		return PlutoRow(
			cells: _getPlutoCells(patrimApoliceSeguroModel: patrimApoliceSeguroModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PatrimApoliceSeguroModel? patrimApoliceSeguroModel}) {
		return {
			"id": PlutoCell(value: patrimApoliceSeguroModel?.id ?? 0),
			"seguradora": PlutoCell(value: patrimApoliceSeguroModel?.seguradoraModel?.nome ?? ''),
			"numero": PlutoCell(value: patrimApoliceSeguroModel?.numero ?? ''),
			"dataContratacao": PlutoCell(value: patrimApoliceSeguroModel?.dataContratacao ?? ''),
			"dataVencimento": PlutoCell(value: patrimApoliceSeguroModel?.dataVencimento ?? ''),
			"valorPremio": PlutoCell(value: patrimApoliceSeguroModel?.valorPremio ?? 0),
			"valorSegurado": PlutoCell(value: patrimApoliceSeguroModel?.valorSegurado ?? 0),
			"observacao": PlutoCell(value: patrimApoliceSeguroModel?.observacao ?? ''),
			"imagem": PlutoCell(value: patrimApoliceSeguroModel?.imagem ?? ''),
			"idPatrimBem": PlutoCell(value: patrimApoliceSeguroModel?.idPatrimBem ?? 0),
			"idSeguradora": PlutoCell(value: patrimApoliceSeguroModel?.idSeguradora ?? 0),
		};
	}

	void plutoRowToObject() {
		patrimApoliceSeguroModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return patrimApoliceSeguroModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			seguradoraModelController.text = currentRow.cells['seguradora']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			valorPremioController.text = currentRow.cells['valorPremio']?.value?.toStringAsFixed(2) ?? '';
			valorSeguradoController.text = currentRow.cells['valorSegurado']?.value?.toStringAsFixed(2) ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			imagemController.text = currentRow.cells['imagem']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PatrimApoliceSeguroEditPage());
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
	final seguradoraModelController = TextEditingController();
	final numeroController = TextEditingController();
	final valorPremioController = MoneyMaskedTextController();
	final valorSeguradoController = MoneyMaskedTextController();
	final observacaoController = TextEditingController();
	final imagemController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = patrimApoliceSeguroModel.id;
		plutoRow.cells['idPatrimBem']?.value = patrimApoliceSeguroModel.idPatrimBem;
		plutoRow.cells['idSeguradora']?.value = patrimApoliceSeguroModel.idSeguradora;
		plutoRow.cells['seguradora']?.value = patrimApoliceSeguroModel.seguradoraModel?.nome;
		plutoRow.cells['numero']?.value = patrimApoliceSeguroModel.numero;
		plutoRow.cells['dataContratacao']?.value = Util.formatDate(patrimApoliceSeguroModel.dataContratacao);
		plutoRow.cells['dataVencimento']?.value = Util.formatDate(patrimApoliceSeguroModel.dataVencimento);
		plutoRow.cells['valorPremio']?.value = patrimApoliceSeguroModel.valorPremio;
		plutoRow.cells['valorSegurado']?.value = patrimApoliceSeguroModel.valorSegurado;
		plutoRow.cells['observacao']?.value = patrimApoliceSeguroModel.observacao;
		plutoRow.cells['imagem']?.value = patrimApoliceSeguroModel.imagem;
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
		patrimApoliceSeguroModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PatrimApoliceSeguroModel();
			model.plutoRowToObject(plutoRow);
			patrimApoliceSeguroModelList.add(model);
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

	Future callSeguradoraLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Seguradora]'; 
		lookupController.route = '/seguradora/'; 
		lookupController.gridColumns = seguradoraGridColumns(isForLookup: true); 
		lookupController.aliasColumns = SeguradoraModel.aliasColumns; 
		lookupController.dbColumns = SeguradoraModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			patrimApoliceSeguroModel.idSeguradora = plutoRowResult.cells['id']!.value; 
			patrimApoliceSeguroModel.seguradoraModel!.plutoRowToObject(plutoRowResult); 
			seguradoraModelController.text = patrimApoliceSeguroModel.seguradoraModel?.nome ?? ''; 
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
		seguradoraModelController.dispose();
		numeroController.dispose();
		valorPremioController.dispose();
		valorSeguradoController.dispose();
		observacaoController.dispose();
		imagemController.dispose();
		super.onClose();
	}
}