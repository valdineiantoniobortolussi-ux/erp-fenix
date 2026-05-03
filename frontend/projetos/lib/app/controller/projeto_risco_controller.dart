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

class ProjetoRiscoController extends GetxController {

	// general
	final gridColumns = projetoRiscoGridColumns();
	
	var projetoRiscoModelList = <ProjetoRiscoModel>[];

	final _projetoRiscoModel = ProjetoRiscoModel().obs;
	ProjetoRiscoModel get projetoRiscoModel => _projetoRiscoModel.value;
	set projetoRiscoModel(value) => _projetoRiscoModel.value = value ?? ProjetoRiscoModel();
	
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
		for (var projetoRiscoModel in projetoRiscoModelList) {
			plutoRowList.add(_getPlutoRow(projetoRiscoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ProjetoRiscoModel projetoRiscoModel) {
		return PlutoRow(
			cells: _getPlutoCells(projetoRiscoModel: projetoRiscoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ProjetoRiscoModel? projetoRiscoModel}) {
		return {
			"id": PlutoCell(value: projetoRiscoModel?.id ?? 0),
			"nome": PlutoCell(value: projetoRiscoModel?.nome ?? ''),
			"probabilidade": PlutoCell(value: projetoRiscoModel?.probabilidade ?? 0),
			"impacto": PlutoCell(value: projetoRiscoModel?.impacto ?? 0),
			"descricao": PlutoCell(value: projetoRiscoModel?.descricao ?? ''),
			"idProjetoPrincipal": PlutoCell(value: projetoRiscoModel?.idProjetoPrincipal ?? 0),
		};
	}

	void plutoRowToObject() {
		projetoRiscoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return projetoRiscoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			probabilidadeController.text = currentRow.cells['probabilidade']?.value?.toString() ?? '';
			impactoController.text = currentRow.cells['impacto']?.value?.toString() ?? '';
			descricaoController.text = currentRow.cells['descricao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ProjetoRiscoEditPage());
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
	final nomeController = TextEditingController();
	final probabilidadeController = TextEditingController();
	final impactoController = TextEditingController();
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
		plutoRow.cells['id']?.value = projetoRiscoModel.id;
		plutoRow.cells['idProjetoPrincipal']?.value = projetoRiscoModel.idProjetoPrincipal;
		plutoRow.cells['nome']?.value = projetoRiscoModel.nome;
		plutoRow.cells['probabilidade']?.value = projetoRiscoModel.probabilidade;
		plutoRow.cells['impacto']?.value = projetoRiscoModel.impacto;
		plutoRow.cells['descricao']?.value = projetoRiscoModel.descricao;
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
		projetoRiscoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ProjetoRiscoModel();
			model.plutoRowToObject(plutoRow);
			projetoRiscoModelList.add(model);
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
		nomeController.dispose();
		probabilidadeController.dispose();
		impactoController.dispose();
		descricaoController.dispose();
		super.onClose();
	}
}