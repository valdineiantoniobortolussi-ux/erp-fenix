import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:contratos/app/data/model/model_imports.dart';
import 'package:contratos/app/page/page_imports.dart';
import 'package:contratos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contratos/app/page/shared_widget/message_dialog.dart';

class ContratoHistoricoReajusteController extends GetxController {

	// general
	final gridColumns = contratoHistoricoReajusteGridColumns();
	
	var contratoHistoricoReajusteModelList = <ContratoHistoricoReajusteModel>[];

	final _contratoHistoricoReajusteModel = ContratoHistoricoReajusteModel().obs;
	ContratoHistoricoReajusteModel get contratoHistoricoReajusteModel => _contratoHistoricoReajusteModel.value;
	set contratoHistoricoReajusteModel(value) => _contratoHistoricoReajusteModel.value = value ?? ContratoHistoricoReajusteModel();
	
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
		for (var contratoHistoricoReajusteModel in contratoHistoricoReajusteModelList) {
			plutoRowList.add(_getPlutoRow(contratoHistoricoReajusteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContratoHistoricoReajusteModel contratoHistoricoReajusteModel) {
		return PlutoRow(
			cells: _getPlutoCells(contratoHistoricoReajusteModel: contratoHistoricoReajusteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContratoHistoricoReajusteModel? contratoHistoricoReajusteModel}) {
		return {
			"id": PlutoCell(value: contratoHistoricoReajusteModel?.id ?? 0),
			"indice": PlutoCell(value: contratoHistoricoReajusteModel?.indice ?? 0),
			"valorAnterior": PlutoCell(value: contratoHistoricoReajusteModel?.valorAnterior ?? 0),
			"valorAtual": PlutoCell(value: contratoHistoricoReajusteModel?.valorAtual ?? 0),
			"dataReajuste": PlutoCell(value: contratoHistoricoReajusteModel?.dataReajuste ?? ''),
			"observacao": PlutoCell(value: contratoHistoricoReajusteModel?.observacao ?? ''),
			"idContrato": PlutoCell(value: contratoHistoricoReajusteModel?.idContrato ?? 0),
		};
	}

	void plutoRowToObject() {
		contratoHistoricoReajusteModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return contratoHistoricoReajusteModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			indiceController.text = currentRow.cells['indice']?.value?.toStringAsFixed(2) ?? '';
			valorAnteriorController.text = currentRow.cells['valorAnterior']?.value?.toStringAsFixed(2) ?? '';
			valorAtualController.text = currentRow.cells['valorAtual']?.value?.toStringAsFixed(2) ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ContratoHistoricoReajusteEditPage());
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
	final indiceController = MoneyMaskedTextController();
	final valorAnteriorController = MoneyMaskedTextController();
	final valorAtualController = MoneyMaskedTextController();
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
		plutoRow.cells['id']?.value = contratoHistoricoReajusteModel.id;
		plutoRow.cells['idContrato']?.value = contratoHistoricoReajusteModel.idContrato;
		plutoRow.cells['indice']?.value = contratoHistoricoReajusteModel.indice;
		plutoRow.cells['valorAnterior']?.value = contratoHistoricoReajusteModel.valorAnterior;
		plutoRow.cells['valorAtual']?.value = contratoHistoricoReajusteModel.valorAtual;
		plutoRow.cells['dataReajuste']?.value = Util.formatDate(contratoHistoricoReajusteModel.dataReajuste);
		plutoRow.cells['observacao']?.value = contratoHistoricoReajusteModel.observacao;
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
		contratoHistoricoReajusteModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ContratoHistoricoReajusteModel();
			model.plutoRowToObject(plutoRow);
			contratoHistoricoReajusteModelList.add(model);
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
		indiceController.dispose();
		valorAnteriorController.dispose();
		valorAtualController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}