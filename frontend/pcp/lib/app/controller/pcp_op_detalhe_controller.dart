import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:pcp/app/controller/controller_imports.dart';
import 'package:pcp/app/routes/app_routes.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:pcp/app/page/page_imports.dart';
import 'package:pcp/app/page/grid_columns/grid_columns_imports.dart';
import 'package:pcp/app/page/shared_widget/message_dialog.dart';

class PcpOpDetalheController extends GetxController {

	// general
	final gridColumns = pcpOpDetalheGridColumns();
	
	var pcpOpDetalheModelList = <PcpOpDetalheModel>[];

	final _pcpOpDetalheModel = PcpOpDetalheModel().obs;
	PcpOpDetalheModel get pcpOpDetalheModel => _pcpOpDetalheModel.value;
	set pcpOpDetalheModel(value) => _pcpOpDetalheModel.value = value ?? PcpOpDetalheModel();
	
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
		for (var pcpOpDetalheModel in pcpOpDetalheModelList) {
			plutoRowList.add(_getPlutoRow(pcpOpDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PcpOpDetalheModel pcpOpDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(pcpOpDetalheModel: pcpOpDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PcpOpDetalheModel? pcpOpDetalheModel}) {
		return {
			"id": PlutoCell(value: pcpOpDetalheModel?.id ?? 0),
			"produto": PlutoCell(value: pcpOpDetalheModel?.produtoModel?.nome ?? ''),
			"quantidadeProduzir": PlutoCell(value: pcpOpDetalheModel?.quantidadeProduzir ?? 0),
			"quantidadeProduzida": PlutoCell(value: pcpOpDetalheModel?.quantidadeProduzida ?? 0),
			"quantidadeEntregue": PlutoCell(value: pcpOpDetalheModel?.quantidadeEntregue ?? 0),
			"custoPrevisto": PlutoCell(value: pcpOpDetalheModel?.custoPrevisto ?? 0),
			"custoRealizado": PlutoCell(value: pcpOpDetalheModel?.custoRealizado ?? 0),
			"idPcpOpCabecalho": PlutoCell(value: pcpOpDetalheModel?.idPcpOpCabecalho ?? 0),
			"idProduto": PlutoCell(value: pcpOpDetalheModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		pcpOpDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pcpOpDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			quantidadeProduzirController.text = currentRow.cells['quantidadeProduzir']?.value?.toStringAsFixed(2) ?? '';
			quantidadeProduzidaController.text = currentRow.cells['quantidadeProduzida']?.value?.toStringAsFixed(2) ?? '';
			quantidadeEntregueController.text = currentRow.cells['quantidadeEntregue']?.value?.toStringAsFixed(2) ?? '';
			custoPrevistoController.text = currentRow.cells['custoPrevisto']?.value?.toStringAsFixed(2) ?? '';
			custoRealizadoController.text = currentRow.cells['custoRealizado']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PcpOpDetalheEditPage());
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
	final produtoModelController = TextEditingController();
	final quantidadeProduzirController = MoneyMaskedTextController();
	final quantidadeProduzidaController = MoneyMaskedTextController();
	final quantidadeEntregueController = MoneyMaskedTextController();
	final custoPrevistoController = MoneyMaskedTextController();
	final custoRealizadoController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pcpOpDetalheModel.id;
		plutoRow.cells['idPcpOpCabecalho']?.value = pcpOpDetalheModel.idPcpOpCabecalho;
		plutoRow.cells['idProduto']?.value = pcpOpDetalheModel.idProduto;
		plutoRow.cells['produto']?.value = pcpOpDetalheModel.produtoModel?.nome;
		plutoRow.cells['quantidadeProduzir']?.value = pcpOpDetalheModel.quantidadeProduzir;
		plutoRow.cells['quantidadeProduzida']?.value = pcpOpDetalheModel.quantidadeProduzida;
		plutoRow.cells['quantidadeEntregue']?.value = pcpOpDetalheModel.quantidadeEntregue;
		plutoRow.cells['custoPrevisto']?.value = pcpOpDetalheModel.custoPrevisto;
		plutoRow.cells['custoRealizado']?.value = pcpOpDetalheModel.custoRealizado;
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
		pcpOpDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PcpOpDetalheModel();
			model.plutoRowToObject(plutoRow);
			pcpOpDetalheModelList.add(model);
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

	Future callProdutoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Produto]'; 
		lookupController.route = '/produto/'; 
		lookupController.gridColumns = produtoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ProdutoModel.aliasColumns; 
		lookupController.dbColumns = ProdutoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pcpOpDetalheModel.idProduto = plutoRowResult.cells['id']!.value; 
			pcpOpDetalheModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = pcpOpDetalheModel.produtoModel?.nome ?? ''; 
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
		produtoModelController.dispose();
		quantidadeProduzirController.dispose();
		quantidadeProduzidaController.dispose();
		quantidadeEntregueController.dispose();
		custoPrevistoController.dispose();
		custoRealizadoController.dispose();
		super.onClose();
	}
}