import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:estoque/app/controller/controller_imports.dart';
import 'package:estoque/app/routes/app_routes.dart';

import 'package:estoque/app/infra/infra_imports.dart';
import 'package:estoque/app/data/model/model_imports.dart';
import 'package:estoque/app/page/page_imports.dart';
import 'package:estoque/app/page/grid_columns/grid_columns_imports.dart';
import 'package:estoque/app/page/shared_widget/message_dialog.dart';

class RequisicaoInternaDetalheController extends GetxController {

	// general
	final gridColumns = requisicaoInternaDetalheGridColumns();
	
	var requisicaoInternaDetalheModelList = <RequisicaoInternaDetalheModel>[];

	final _requisicaoInternaDetalheModel = RequisicaoInternaDetalheModel().obs;
	RequisicaoInternaDetalheModel get requisicaoInternaDetalheModel => _requisicaoInternaDetalheModel.value;
	set requisicaoInternaDetalheModel(value) => _requisicaoInternaDetalheModel.value = value ?? RequisicaoInternaDetalheModel();
	
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
		for (var requisicaoInternaDetalheModel in requisicaoInternaDetalheModelList) {
			plutoRowList.add(_getPlutoRow(requisicaoInternaDetalheModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(RequisicaoInternaDetalheModel requisicaoInternaDetalheModel) {
		return PlutoRow(
			cells: _getPlutoCells(requisicaoInternaDetalheModel: requisicaoInternaDetalheModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ RequisicaoInternaDetalheModel? requisicaoInternaDetalheModel}) {
		return {
			"id": PlutoCell(value: requisicaoInternaDetalheModel?.id ?? 0),
			"produto": PlutoCell(value: requisicaoInternaDetalheModel?.produtoModel?.nome ?? ''),
			"quantidade": PlutoCell(value: requisicaoInternaDetalheModel?.quantidade ?? 0),
			"idRequisicaoInternaCabecalho": PlutoCell(value: requisicaoInternaDetalheModel?.idRequisicaoInternaCabecalho ?? 0),
			"idProduto": PlutoCell(value: requisicaoInternaDetalheModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		requisicaoInternaDetalheModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return requisicaoInternaDetalheModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => RequisicaoInternaDetalheEditPage());
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
	final quantidadeController = MoneyMaskedTextController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = requisicaoInternaDetalheModel.id;
		plutoRow.cells['idRequisicaoInternaCabecalho']?.value = requisicaoInternaDetalheModel.idRequisicaoInternaCabecalho;
		plutoRow.cells['idProduto']?.value = requisicaoInternaDetalheModel.idProduto;
		plutoRow.cells['produto']?.value = requisicaoInternaDetalheModel.produtoModel?.nome;
		plutoRow.cells['quantidade']?.value = requisicaoInternaDetalheModel.quantidade;
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
		requisicaoInternaDetalheModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = RequisicaoInternaDetalheModel();
			model.plutoRowToObject(plutoRow);
			requisicaoInternaDetalheModelList.add(model);
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
			requisicaoInternaDetalheModel.idProduto = plutoRowResult.cells['id']!.value; 
			requisicaoInternaDetalheModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = requisicaoInternaDetalheModel.produtoModel?.nome ?? ''; 
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
		quantidadeController.dispose();
		super.onClose();
	}
}