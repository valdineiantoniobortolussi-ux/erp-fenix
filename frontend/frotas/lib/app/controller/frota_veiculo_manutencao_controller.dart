import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:frotas/app/data/model/model_imports.dart';
import 'package:frotas/app/page/page_imports.dart';
import 'package:frotas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:frotas/app/page/shared_widget/message_dialog.dart';

class FrotaVeiculoManutencaoController extends GetxController {

	// general
	final gridColumns = frotaVeiculoManutencaoGridColumns();
	
	var frotaVeiculoManutencaoModelList = <FrotaVeiculoManutencaoModel>[];

	final _frotaVeiculoManutencaoModel = FrotaVeiculoManutencaoModel().obs;
	FrotaVeiculoManutencaoModel get frotaVeiculoManutencaoModel => _frotaVeiculoManutencaoModel.value;
	set frotaVeiculoManutencaoModel(value) => _frotaVeiculoManutencaoModel.value = value ?? FrotaVeiculoManutencaoModel();
	
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
		for (var frotaVeiculoManutencaoModel in frotaVeiculoManutencaoModelList) {
			plutoRowList.add(_getPlutoRow(frotaVeiculoManutencaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FrotaVeiculoManutencaoModel frotaVeiculoManutencaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(frotaVeiculoManutencaoModel: frotaVeiculoManutencaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FrotaVeiculoManutencaoModel? frotaVeiculoManutencaoModel}) {
		return {
			"id": PlutoCell(value: frotaVeiculoManutencaoModel?.id ?? 0),
			"tipo": PlutoCell(value: frotaVeiculoManutencaoModel?.tipo ?? ''),
			"dataManutencao": PlutoCell(value: frotaVeiculoManutencaoModel?.dataManutencao ?? ''),
			"valorManutencao": PlutoCell(value: frotaVeiculoManutencaoModel?.valorManutencao ?? 0),
			"observacao": PlutoCell(value: frotaVeiculoManutencaoModel?.observacao ?? ''),
			"idFrotaVeiculo": PlutoCell(value: frotaVeiculoManutencaoModel?.idFrotaVeiculo ?? 0),
		};
	}

	void plutoRowToObject() {
		frotaVeiculoManutencaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return frotaVeiculoManutencaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorManutencaoController.text = currentRow.cells['valorManutencao']?.value?.toStringAsFixed(2) ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FrotaVeiculoManutencaoEditPage());
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
	final valorManutencaoController = MoneyMaskedTextController();
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
		plutoRow.cells['id']?.value = frotaVeiculoManutencaoModel.id;
		plutoRow.cells['idFrotaVeiculo']?.value = frotaVeiculoManutencaoModel.idFrotaVeiculo;
		plutoRow.cells['tipo']?.value = frotaVeiculoManutencaoModel.tipo;
		plutoRow.cells['dataManutencao']?.value = Util.formatDate(frotaVeiculoManutencaoModel.dataManutencao);
		plutoRow.cells['valorManutencao']?.value = frotaVeiculoManutencaoModel.valorManutencao;
		plutoRow.cells['observacao']?.value = frotaVeiculoManutencaoModel.observacao;
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
		frotaVeiculoManutencaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FrotaVeiculoManutencaoModel();
			model.plutoRowToObject(plutoRow);
			frotaVeiculoManutencaoModelList.add(model);
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
		valorManutencaoController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}