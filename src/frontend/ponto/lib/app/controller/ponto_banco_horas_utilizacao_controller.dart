import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:ponto/app/page/page_imports.dart';
import 'package:ponto/app/page/grid_columns/grid_columns_imports.dart';
import 'package:ponto/app/page/shared_widget/message_dialog.dart';

class PontoBancoHorasUtilizacaoController extends GetxController {

	// general
	final gridColumns = pontoBancoHorasUtilizacaoGridColumns();
	
	var pontoBancoHorasUtilizacaoModelList = <PontoBancoHorasUtilizacaoModel>[];

	final _pontoBancoHorasUtilizacaoModel = PontoBancoHorasUtilizacaoModel().obs;
	PontoBancoHorasUtilizacaoModel get pontoBancoHorasUtilizacaoModel => _pontoBancoHorasUtilizacaoModel.value;
	set pontoBancoHorasUtilizacaoModel(value) => _pontoBancoHorasUtilizacaoModel.value = value ?? PontoBancoHorasUtilizacaoModel();
	
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
		for (var pontoBancoHorasUtilizacaoModel in pontoBancoHorasUtilizacaoModelList) {
			plutoRowList.add(_getPlutoRow(pontoBancoHorasUtilizacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PontoBancoHorasUtilizacaoModel pontoBancoHorasUtilizacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pontoBancoHorasUtilizacaoModel: pontoBancoHorasUtilizacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PontoBancoHorasUtilizacaoModel? pontoBancoHorasUtilizacaoModel}) {
		return {
			"id": PlutoCell(value: pontoBancoHorasUtilizacaoModel?.id ?? 0),
			"dataUtilizacao": PlutoCell(value: pontoBancoHorasUtilizacaoModel?.dataUtilizacao ?? ''),
			"quantidadeUtilizada": PlutoCell(value: pontoBancoHorasUtilizacaoModel?.quantidadeUtilizada ?? ''),
			"observacao": PlutoCell(value: pontoBancoHorasUtilizacaoModel?.observacao ?? ''),
			"idPontoBancoHoras": PlutoCell(value: pontoBancoHorasUtilizacaoModel?.idPontoBancoHoras ?? 0),
		};
	}

	void plutoRowToObject() {
		pontoBancoHorasUtilizacaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pontoBancoHorasUtilizacaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			quantidadeUtilizadaController.text = currentRow.cells['quantidadeUtilizada']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PontoBancoHorasUtilizacaoEditPage());
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
	final quantidadeUtilizadaController = MaskedTextController(mask: '00:00:00',);
	final observacaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pontoBancoHorasUtilizacaoModel.id;
		plutoRow.cells['idPontoBancoHoras']?.value = pontoBancoHorasUtilizacaoModel.idPontoBancoHoras;
		plutoRow.cells['dataUtilizacao']?.value = Util.formatDate(pontoBancoHorasUtilizacaoModel.dataUtilizacao);
		plutoRow.cells['quantidadeUtilizada']?.value = pontoBancoHorasUtilizacaoModel.quantidadeUtilizada;
		plutoRow.cells['observacao']?.value = pontoBancoHorasUtilizacaoModel.observacao;
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
		pontoBancoHorasUtilizacaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PontoBancoHorasUtilizacaoModel();
			model.plutoRowToObject(plutoRow);
			pontoBancoHorasUtilizacaoModelList.add(model);
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
		quantidadeUtilizadaController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}