import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:agenda/app/controller/controller_imports.dart';
import 'package:agenda/app/routes/app_routes.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:agenda/app/page/page_imports.dart';
import 'package:agenda/app/page/grid_columns/grid_columns_imports.dart';
import 'package:agenda/app/page/shared_widget/message_dialog.dart';

class AgendaCompromissoConvidadoController extends GetxController {

	// general
	final gridColumns = agendaCompromissoConvidadoGridColumns();
	
	var agendaCompromissoConvidadoModelList = <AgendaCompromissoConvidadoModel>[];

	final _agendaCompromissoConvidadoModel = AgendaCompromissoConvidadoModel().obs;
	AgendaCompromissoConvidadoModel get agendaCompromissoConvidadoModel => _agendaCompromissoConvidadoModel.value;
	set agendaCompromissoConvidadoModel(value) => _agendaCompromissoConvidadoModel.value = value ?? AgendaCompromissoConvidadoModel();
	
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
		for (var agendaCompromissoConvidadoModel in agendaCompromissoConvidadoModelList) {
			plutoRowList.add(_getPlutoRow(agendaCompromissoConvidadoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(AgendaCompromissoConvidadoModel agendaCompromissoConvidadoModel) {
		return PlutoRow(
			cells: _getPlutoCells(agendaCompromissoConvidadoModel: agendaCompromissoConvidadoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ AgendaCompromissoConvidadoModel? agendaCompromissoConvidadoModel}) {
		return {
			"id": PlutoCell(value: agendaCompromissoConvidadoModel?.id ?? 0),
			"viewPessoaColaborador": PlutoCell(value: agendaCompromissoConvidadoModel?.viewPessoaColaboradorModel?.nome ?? ''),
			"idAgendaCompromisso": PlutoCell(value: agendaCompromissoConvidadoModel?.idAgendaCompromisso ?? 0),
			"idColaborador": PlutoCell(value: agendaCompromissoConvidadoModel?.idColaborador ?? 0),
		};
	}

	void plutoRowToObject() {
		agendaCompromissoConvidadoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return agendaCompromissoConvidadoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			viewPessoaColaboradorModelController.text = currentRow.cells['viewPessoaColaborador']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => AgendaCompromissoConvidadoEditPage());
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
	final viewPessoaColaboradorModelController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = agendaCompromissoConvidadoModel.id;
		plutoRow.cells['idAgendaCompromisso']?.value = agendaCompromissoConvidadoModel.idAgendaCompromisso;
		plutoRow.cells['idColaborador']?.value = agendaCompromissoConvidadoModel.idColaborador;
		plutoRow.cells['viewPessoaColaborador']?.value = agendaCompromissoConvidadoModel.viewPessoaColaboradorModel?.nome;
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
		agendaCompromissoConvidadoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = AgendaCompromissoConvidadoModel();
			model.plutoRowToObject(plutoRow);
			agendaCompromissoConvidadoModelList.add(model);
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

	Future callViewPessoaColaboradorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Colaborador]'; 
		lookupController.route = '/view-pessoa-colaborador/'; 
		lookupController.gridColumns = viewPessoaColaboradorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaColaboradorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaColaboradorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			agendaCompromissoConvidadoModel.idColaborador = plutoRowResult.cells['id']!.value; 
			agendaCompromissoConvidadoModel.viewPessoaColaboradorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaColaboradorModelController.text = agendaCompromissoConvidadoModel.viewPessoaColaboradorModel?.nome ?? ''; 
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
		viewPessoaColaboradorModelController.dispose();
		super.onClose();
	}
}