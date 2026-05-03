import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:vendas/app/controller/controller_imports.dart';
import 'package:vendas/app/routes/app_routes.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';
import 'package:vendas/app/page/page_imports.dart';
import 'package:vendas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:vendas/app/page/shared_widget/message_dialog.dart';

class VendaFreteController extends GetxController {

	// general
	final gridColumns = vendaFreteGridColumns();
	
	var vendaFreteModelList = <VendaFreteModel>[];

	final _vendaFreteModel = VendaFreteModel().obs;
	VendaFreteModel get vendaFreteModel => _vendaFreteModel.value;
	set vendaFreteModel(value) => _vendaFreteModel.value = value ?? VendaFreteModel();
	
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
		for (var vendaFreteModel in vendaFreteModelList) {
			plutoRowList.add(_getPlutoRow(vendaFreteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(VendaFreteModel vendaFreteModel) {
		return PlutoRow(
			cells: _getPlutoCells(vendaFreteModel: vendaFreteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ VendaFreteModel? vendaFreteModel}) {
		return {
			"id": PlutoCell(value: vendaFreteModel?.id ?? 0),
			"viewPessoaTransportadora": PlutoCell(value: vendaFreteModel?.viewPessoaTransportadoraModel?.nome ?? ''),
			"responsavel": PlutoCell(value: vendaFreteModel?.responsavel ?? ''),
			"conhecimento": PlutoCell(value: vendaFreteModel?.conhecimento ?? 0),
			"placa": PlutoCell(value: vendaFreteModel?.placa ?? ''),
			"ufPlaca": PlutoCell(value: vendaFreteModel?.ufPlaca ?? ''),
			"seloFiscal": PlutoCell(value: vendaFreteModel?.seloFiscal ?? 0),
			"quantidadeVolume": PlutoCell(value: vendaFreteModel?.quantidadeVolume ?? 0),
			"marcaVolume": PlutoCell(value: vendaFreteModel?.marcaVolume ?? ''),
			"especieVolume": PlutoCell(value: vendaFreteModel?.especieVolume ?? ''),
			"pesoBruto": PlutoCell(value: vendaFreteModel?.pesoBruto ?? 0),
			"pesoLiquido": PlutoCell(value: vendaFreteModel?.pesoLiquido ?? 0),
			"idVendaCabecalho": PlutoCell(value: vendaFreteModel?.idVendaCabecalho ?? 0),
			"idTransportadora": PlutoCell(value: vendaFreteModel?.idTransportadora ?? 0),
		};
	}

	void plutoRowToObject() {
		vendaFreteModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return vendaFreteModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaTransportadoraModelController.text = currentRow.cells['viewPessoaTransportadora']?.value ?? '';
			conhecimentoController.text = currentRow.cells['conhecimento']?.value?.toString() ?? '';
			placaController.text = currentRow.cells['placa']?.value ?? '';
			seloFiscalController.text = currentRow.cells['seloFiscal']?.value?.toString() ?? '';
			quantidadeVolumeController.text = currentRow.cells['quantidadeVolume']?.value?.toStringAsFixed(2) ?? '';
			marcaVolumeController.text = currentRow.cells['marcaVolume']?.value ?? '';
			especieVolumeController.text = currentRow.cells['especieVolume']?.value ?? '';
			pesoBrutoController.text = currentRow.cells['pesoBruto']?.value?.toStringAsFixed(2) ?? '';
			pesoLiquidoController.text = currentRow.cells['pesoLiquido']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => VendaFreteEditPage());
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
	final viewPessoaTransportadoraModelController = TextEditingController();
	final conhecimentoController = TextEditingController();
	final placaController = TextEditingController();
	final seloFiscalController = TextEditingController();
	final quantidadeVolumeController = MoneyMaskedTextController();
	final marcaVolumeController = TextEditingController();
	final especieVolumeController = TextEditingController();
	final pesoBrutoController = MoneyMaskedTextController();
	final pesoLiquidoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = vendaFreteModel.id;
		plutoRow.cells['idVendaCabecalho']?.value = vendaFreteModel.idVendaCabecalho;
		plutoRow.cells['idTransportadora']?.value = vendaFreteModel.idTransportadora;
		plutoRow.cells['viewPessoaTransportadora']?.value = vendaFreteModel.viewPessoaTransportadoraModel?.nome;
		plutoRow.cells['responsavel']?.value = vendaFreteModel.responsavel;
		plutoRow.cells['conhecimento']?.value = vendaFreteModel.conhecimento;
		plutoRow.cells['placa']?.value = vendaFreteModel.placa;
		plutoRow.cells['ufPlaca']?.value = vendaFreteModel.ufPlaca;
		plutoRow.cells['seloFiscal']?.value = vendaFreteModel.seloFiscal;
		plutoRow.cells['quantidadeVolume']?.value = vendaFreteModel.quantidadeVolume;
		plutoRow.cells['marcaVolume']?.value = vendaFreteModel.marcaVolume;
		plutoRow.cells['especieVolume']?.value = vendaFreteModel.especieVolume;
		plutoRow.cells['pesoBruto']?.value = vendaFreteModel.pesoBruto;
		plutoRow.cells['pesoLiquido']?.value = vendaFreteModel.pesoLiquido;
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
		vendaFreteModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = VendaFreteModel();
			model.plutoRowToObject(plutoRow);
			vendaFreteModelList.add(model);
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

	Future callViewPessoaTransportadoraLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Transportadora]'; 
		lookupController.route = '/view-pessoa-transportadora/'; 
		lookupController.gridColumns = viewPessoaTransportadoraGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaTransportadoraModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaTransportadoraModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendaFreteModel.idTransportadora = plutoRowResult.cells['id']!.value; 
			vendaFreteModel.viewPessoaTransportadoraModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaTransportadoraModelController.text = vendaFreteModel.viewPessoaTransportadoraModel?.nome ?? ''; 
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
		viewPessoaTransportadoraModelController.dispose();
		conhecimentoController.dispose();
		placaController.dispose();
		seloFiscalController.dispose();
		quantidadeVolumeController.dispose();
		marcaVolumeController.dispose();
		especieVolumeController.dispose();
		pesoBrutoController.dispose();
		pesoLiquidoController.dispose();
		super.onClose();
	}
}