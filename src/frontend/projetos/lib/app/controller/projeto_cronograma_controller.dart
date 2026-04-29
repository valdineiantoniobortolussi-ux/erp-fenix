import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/data/model/model_imports.dart';
import 'package:projetos/app/page/page_imports.dart';
import 'package:projetos/app/page/grid_columns/grid_columns_imports.dart';
import 'package:projetos/app/page/shared_widget/message_dialog.dart';

class ProjetoCronogramaController extends GetxController {

	// general
	final gridColumns = projetoCronogramaGridColumns();
	
	var projetoCronogramaModelList = <ProjetoCronogramaModel>[];

	final _projetoCronogramaModel = ProjetoCronogramaModel().obs;
	ProjetoCronogramaModel get projetoCronogramaModel => _projetoCronogramaModel.value;
	set projetoCronogramaModel(value) => _projetoCronogramaModel.value = value ?? ProjetoCronogramaModel();
	
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
		for (var projetoCronogramaModel in projetoCronogramaModelList) {
			plutoRowList.add(_getPlutoRow(projetoCronogramaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ProjetoCronogramaModel projetoCronogramaModel) {
		return PlutoRow(
			cells: _getPlutoCells(projetoCronogramaModel: projetoCronogramaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ProjetoCronogramaModel? projetoCronogramaModel}) {
		return {
			"id": PlutoCell(value: projetoCronogramaModel?.id ?? 0),
			"tarefa": PlutoCell(value: projetoCronogramaModel?.tarefa ?? ''),
			"dataTarefa": PlutoCell(value: projetoCronogramaModel?.dataTarefa ?? ''),
			"descricao": PlutoCell(value: projetoCronogramaModel?.descricao ?? ''),
			"idProjetoPrincipal": PlutoCell(value: projetoCronogramaModel?.idProjetoPrincipal ?? 0),
		};
	}

	void plutoRowToObject() {
		projetoCronogramaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return projetoCronogramaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			tarefaController.text = currentRow.cells['tarefa']?.value ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ProjetoCronogramaEditPage());
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
	final tarefaController = TextEditingController();
	final descricaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = projetoCronogramaModel.id;
		plutoRow.cells['idProjetoPrincipal']?.value = projetoCronogramaModel.idProjetoPrincipal;
		plutoRow.cells['tarefa']?.value = projetoCronogramaModel.tarefa;
		plutoRow.cells['dataTarefa']?.value = Util.formatDate(projetoCronogramaModel.dataTarefa);
		plutoRow.cells['descricao']?.value = projetoCronogramaModel.descricao;
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
		projetoCronogramaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ProjetoCronogramaModel();
			model.plutoRowToObject(plutoRow);
			projetoCronogramaModelList.add(model);
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
		tarefaController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}