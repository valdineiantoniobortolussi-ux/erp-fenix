import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/page/page_imports.dart';
import 'package:folha/app/page/grid_columns/grid_columns_imports.dart';
import 'package:folha/app/page/shared_widget/message_dialog.dart';

class FolhaPppFatorRiscoController extends GetxController {

	// general
	final gridColumns = folhaPppFatorRiscoGridColumns();
	
	var folhaPppFatorRiscoModelList = <FolhaPppFatorRiscoModel>[];

	final _folhaPppFatorRiscoModel = FolhaPppFatorRiscoModel().obs;
	FolhaPppFatorRiscoModel get folhaPppFatorRiscoModel => _folhaPppFatorRiscoModel.value;
	set folhaPppFatorRiscoModel(value) => _folhaPppFatorRiscoModel.value = value ?? FolhaPppFatorRiscoModel();
	
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
		for (var folhaPppFatorRiscoModel in folhaPppFatorRiscoModelList) {
			plutoRowList.add(_getPlutoRow(folhaPppFatorRiscoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FolhaPppFatorRiscoModel folhaPppFatorRiscoModel) {
		return PlutoRow(
			cells: _getPlutoCells(folhaPppFatorRiscoModel: folhaPppFatorRiscoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FolhaPppFatorRiscoModel? folhaPppFatorRiscoModel}) {
		return {
			"id": PlutoCell(value: folhaPppFatorRiscoModel?.id ?? 0),
			"dataInicio": PlutoCell(value: folhaPppFatorRiscoModel?.dataInicio ?? ''),
			"dataFim": PlutoCell(value: folhaPppFatorRiscoModel?.dataFim ?? ''),
			"tipo": PlutoCell(value: folhaPppFatorRiscoModel?.tipo ?? ''),
			"fatorRisco": PlutoCell(value: folhaPppFatorRiscoModel?.fatorRisco ?? ''),
			"intensidade": PlutoCell(value: folhaPppFatorRiscoModel?.intensidade ?? ''),
			"tecnicaUtilizada": PlutoCell(value: folhaPppFatorRiscoModel?.tecnicaUtilizada ?? ''),
			"epcEficaz": PlutoCell(value: folhaPppFatorRiscoModel?.epcEficaz ?? ''),
			"epiEficaz": PlutoCell(value: folhaPppFatorRiscoModel?.epiEficaz ?? ''),
			"caEpi": PlutoCell(value: folhaPppFatorRiscoModel?.caEpi ?? 0),
			"atendimentoNr061": PlutoCell(value: folhaPppFatorRiscoModel?.atendimentoNr061 ?? ''),
			"atendimentoNr062": PlutoCell(value: folhaPppFatorRiscoModel?.atendimentoNr062 ?? ''),
			"atendimentoNr063": PlutoCell(value: folhaPppFatorRiscoModel?.atendimentoNr063 ?? ''),
			"atendimentoNr064": PlutoCell(value: folhaPppFatorRiscoModel?.atendimentoNr064 ?? ''),
			"atendimentoNr065": PlutoCell(value: folhaPppFatorRiscoModel?.atendimentoNr065 ?? ''),
			"idFolhaPpp": PlutoCell(value: folhaPppFatorRiscoModel?.idFolhaPpp ?? 0),
		};
	}

	void plutoRowToObject() {
		folhaPppFatorRiscoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return folhaPppFatorRiscoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			fatorRiscoController.text = currentRow.cells['fatorRisco']?.value ?? '';
			intensidadeController.text = currentRow.cells['intensidade']?.value ?? '';
			tecnicaUtilizadaController.text = currentRow.cells['tecnicaUtilizada']?.value ?? '';
			caEpiController.text = currentRow.cells['caEpi']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FolhaPppFatorRiscoEditPage());
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
	final fatorRiscoController = TextEditingController();
	final intensidadeController = TextEditingController();
	final tecnicaUtilizadaController = TextEditingController();
	final caEpiController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = folhaPppFatorRiscoModel.id;
		plutoRow.cells['idFolhaPpp']?.value = folhaPppFatorRiscoModel.idFolhaPpp;
		plutoRow.cells['dataInicio']?.value = Util.formatDate(folhaPppFatorRiscoModel.dataInicio);
		plutoRow.cells['dataFim']?.value = Util.formatDate(folhaPppFatorRiscoModel.dataFim);
		plutoRow.cells['tipo']?.value = folhaPppFatorRiscoModel.tipo;
		plutoRow.cells['fatorRisco']?.value = folhaPppFatorRiscoModel.fatorRisco;
		plutoRow.cells['intensidade']?.value = folhaPppFatorRiscoModel.intensidade;
		plutoRow.cells['tecnicaUtilizada']?.value = folhaPppFatorRiscoModel.tecnicaUtilizada;
		plutoRow.cells['epcEficaz']?.value = folhaPppFatorRiscoModel.epcEficaz;
		plutoRow.cells['epiEficaz']?.value = folhaPppFatorRiscoModel.epiEficaz;
		plutoRow.cells['caEpi']?.value = folhaPppFatorRiscoModel.caEpi;
		plutoRow.cells['atendimentoNr061']?.value = folhaPppFatorRiscoModel.atendimentoNr061;
		plutoRow.cells['atendimentoNr062']?.value = folhaPppFatorRiscoModel.atendimentoNr062;
		plutoRow.cells['atendimentoNr063']?.value = folhaPppFatorRiscoModel.atendimentoNr063;
		plutoRow.cells['atendimentoNr064']?.value = folhaPppFatorRiscoModel.atendimentoNr064;
		plutoRow.cells['atendimentoNr065']?.value = folhaPppFatorRiscoModel.atendimentoNr065;
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
		folhaPppFatorRiscoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FolhaPppFatorRiscoModel();
			model.plutoRowToObject(plutoRow);
			folhaPppFatorRiscoModelList.add(model);
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
		fatorRiscoController.dispose();
		intensidadeController.dispose();
		tecnicaUtilizadaController.dispose();
		caEpiController.dispose();
		super.onClose();
	}
}