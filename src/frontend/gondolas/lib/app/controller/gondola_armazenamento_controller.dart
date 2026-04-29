import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:gondolas/app/controller/controller_imports.dart';
import 'package:gondolas/app/routes/app_routes.dart';

import 'package:gondolas/app/infra/infra_imports.dart';
import 'package:gondolas/app/data/model/model_imports.dart';
import 'package:gondolas/app/page/page_imports.dart';
import 'package:gondolas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:gondolas/app/page/shared_widget/message_dialog.dart';

class GondolaArmazenamentoController extends GetxController {

	// general
	final gridColumns = gondolaArmazenamentoGridColumns();
	
	var gondolaArmazenamentoModelList = <GondolaArmazenamentoModel>[];

	final _gondolaArmazenamentoModel = GondolaArmazenamentoModel().obs;
	GondolaArmazenamentoModel get gondolaArmazenamentoModel => _gondolaArmazenamentoModel.value;
	set gondolaArmazenamentoModel(value) => _gondolaArmazenamentoModel.value = value ?? GondolaArmazenamentoModel();
	
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
		for (var gondolaArmazenamentoModel in gondolaArmazenamentoModelList) {
			plutoRowList.add(_getPlutoRow(gondolaArmazenamentoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(GondolaArmazenamentoModel gondolaArmazenamentoModel) {
		return PlutoRow(
			cells: _getPlutoCells(gondolaArmazenamentoModel: gondolaArmazenamentoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ GondolaArmazenamentoModel? gondolaArmazenamentoModel}) {
		return {
			"id": PlutoCell(value: gondolaArmazenamentoModel?.id ?? 0),
			"produto": PlutoCell(value: gondolaArmazenamentoModel?.produtoModel?.nome ?? ''),
			"quantidade": PlutoCell(value: gondolaArmazenamentoModel?.quantidade ?? 0),
			"idGondolaCaixa": PlutoCell(value: gondolaArmazenamentoModel?.idGondolaCaixa ?? 0),
			"idProduto": PlutoCell(value: gondolaArmazenamentoModel?.idProduto ?? 0),
		};
	}

	void plutoRowToObject() {
		gondolaArmazenamentoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return gondolaArmazenamentoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			produtoModelController.text = currentRow.cells['produto']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => GondolaArmazenamentoEditPage());
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
	final quantidadeController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = gondolaArmazenamentoModel.id;
		plutoRow.cells['idGondolaCaixa']?.value = gondolaArmazenamentoModel.idGondolaCaixa;
		plutoRow.cells['idProduto']?.value = gondolaArmazenamentoModel.idProduto;
		plutoRow.cells['produto']?.value = gondolaArmazenamentoModel.produtoModel?.nome;
		plutoRow.cells['quantidade']?.value = gondolaArmazenamentoModel.quantidade;
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
		gondolaArmazenamentoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = GondolaArmazenamentoModel();
			model.plutoRowToObject(plutoRow);
			gondolaArmazenamentoModelList.add(model);
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
			gondolaArmazenamentoModel.idProduto = plutoRowResult.cells['id']!.value; 
			gondolaArmazenamentoModel.produtoModel!.plutoRowToObject(plutoRowResult); 
			produtoModelController.text = gondolaArmazenamentoModel.produtoModel?.nome ?? ''; 
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