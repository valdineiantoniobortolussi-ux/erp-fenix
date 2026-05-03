import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeItemRastreadoController extends GetxController {

	// general
	final gridColumns = nfeItemRastreadoGridColumns();
	
	var nfeItemRastreadoModelList = <NfeItemRastreadoModel>[];

	final _nfeItemRastreadoModel = NfeItemRastreadoModel().obs;
	NfeItemRastreadoModel get nfeItemRastreadoModel => _nfeItemRastreadoModel.value;
	set nfeItemRastreadoModel(value) => _nfeItemRastreadoModel.value = value ?? NfeItemRastreadoModel();
	
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
		for (var nfeItemRastreadoModel in nfeItemRastreadoModelList) {
			plutoRowList.add(_getPlutoRow(nfeItemRastreadoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeItemRastreadoModel nfeItemRastreadoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeItemRastreadoModel: nfeItemRastreadoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeItemRastreadoModel? nfeItemRastreadoModel}) {
		return {
			"id": PlutoCell(value: nfeItemRastreadoModel?.id ?? 0),
			"numeroLote": PlutoCell(value: nfeItemRastreadoModel?.numeroLote ?? ''),
			"quantidadeItens": PlutoCell(value: nfeItemRastreadoModel?.quantidadeItens ?? 0),
			"dataFabricacao": PlutoCell(value: nfeItemRastreadoModel?.dataFabricacao ?? ''),
			"dataValidade": PlutoCell(value: nfeItemRastreadoModel?.dataValidade ?? ''),
			"codigoAgregacao": PlutoCell(value: nfeItemRastreadoModel?.codigoAgregacao ?? ''),
			"idNfeDetalhe": PlutoCell(value: nfeItemRastreadoModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeItemRastreadoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeItemRastreadoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroLoteController.text = currentRow.cells['numeroLote']?.value ?? '';
			quantidadeItensController.text = currentRow.cells['quantidadeItens']?.value?.toStringAsFixed(2) ?? '';
			codigoAgregacaoController.text = currentRow.cells['codigoAgregacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeItemRastreadoEditPage());
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
	final numeroLoteController = TextEditingController();
	final quantidadeItensController = MoneyMaskedTextController();
	final codigoAgregacaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeItemRastreadoModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeItemRastreadoModel.idNfeDetalhe;
		plutoRow.cells['numeroLote']?.value = nfeItemRastreadoModel.numeroLote;
		plutoRow.cells['quantidadeItens']?.value = nfeItemRastreadoModel.quantidadeItens;
		plutoRow.cells['dataFabricacao']?.value = Util.formatDate(nfeItemRastreadoModel.dataFabricacao);
		plutoRow.cells['dataValidade']?.value = Util.formatDate(nfeItemRastreadoModel.dataValidade);
		plutoRow.cells['codigoAgregacao']?.value = nfeItemRastreadoModel.codigoAgregacao;
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
		nfeItemRastreadoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeItemRastreadoModel();
			model.plutoRowToObject(plutoRow);
			nfeItemRastreadoModelList.add(model);
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
		numeroLoteController.dispose();
		quantidadeItensController.dispose();
		codigoAgregacaoController.dispose();
		super.onClose();
	}
}