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

class NfeExportacaoController extends GetxController {

	// general
	final gridColumns = nfeExportacaoGridColumns();
	
	var nfeExportacaoModelList = <NfeExportacaoModel>[];

	final _nfeExportacaoModel = NfeExportacaoModel().obs;
	NfeExportacaoModel get nfeExportacaoModel => _nfeExportacaoModel.value;
	set nfeExportacaoModel(value) => _nfeExportacaoModel.value = value ?? NfeExportacaoModel();
	
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
		for (var nfeExportacaoModel in nfeExportacaoModelList) {
			plutoRowList.add(_getPlutoRow(nfeExportacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeExportacaoModel nfeExportacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeExportacaoModel: nfeExportacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeExportacaoModel? nfeExportacaoModel}) {
		return {
			"id": PlutoCell(value: nfeExportacaoModel?.id ?? 0),
			"drawback": PlutoCell(value: nfeExportacaoModel?.drawback ?? 0),
			"numeroRegistro": PlutoCell(value: nfeExportacaoModel?.numeroRegistro ?? 0),
			"chaveAcesso": PlutoCell(value: nfeExportacaoModel?.chaveAcesso ?? ''),
			"quantidade": PlutoCell(value: nfeExportacaoModel?.quantidade ?? 0),
			"idNfeDetalhe": PlutoCell(value: nfeExportacaoModel?.idNfeDetalhe ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeExportacaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeExportacaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			drawbackController.text = currentRow.cells['drawback']?.value?.toString() ?? '';
			numeroRegistroController.text = currentRow.cells['numeroRegistro']?.value?.toString() ?? '';
			chaveAcessoController.text = currentRow.cells['chaveAcesso']?.value ?? '';
			quantidadeController.text = currentRow.cells['quantidade']?.value?.toStringAsFixed(2) ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeExportacaoEditPage());
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
	final drawbackController = TextEditingController();
	final numeroRegistroController = TextEditingController();
	final chaveAcessoController = TextEditingController();
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
		plutoRow.cells['id']?.value = nfeExportacaoModel.id;
		plutoRow.cells['idNfeDetalhe']?.value = nfeExportacaoModel.idNfeDetalhe;
		plutoRow.cells['drawback']?.value = nfeExportacaoModel.drawback;
		plutoRow.cells['numeroRegistro']?.value = nfeExportacaoModel.numeroRegistro;
		plutoRow.cells['chaveAcesso']?.value = nfeExportacaoModel.chaveAcesso;
		plutoRow.cells['quantidade']?.value = nfeExportacaoModel.quantidade;
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
		nfeExportacaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeExportacaoModel();
			model.plutoRowToObject(plutoRow);
			nfeExportacaoModelList.add(model);
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
		drawbackController.dispose();
		numeroRegistroController.dispose();
		chaveAcessoController.dispose();
		quantidadeController.dispose();
		super.onClose();
	}
}