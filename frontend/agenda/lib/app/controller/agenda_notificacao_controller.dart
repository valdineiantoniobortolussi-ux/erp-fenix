import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:agenda/app/page/page_imports.dart';
import 'package:agenda/app/page/grid_columns/grid_columns_imports.dart';
import 'package:agenda/app/page/shared_widget/message_dialog.dart';

class AgendaNotificacaoController extends GetxController {

	// general
	final gridColumns = agendaNotificacaoGridColumns();
	
	var agendaNotificacaoModelList = <AgendaNotificacaoModel>[];

	final _agendaNotificacaoModel = AgendaNotificacaoModel().obs;
	AgendaNotificacaoModel get agendaNotificacaoModel => _agendaNotificacaoModel.value;
	set agendaNotificacaoModel(value) => _agendaNotificacaoModel.value = value ?? AgendaNotificacaoModel();
	
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
		for (var agendaNotificacaoModel in agendaNotificacaoModelList) {
			plutoRowList.add(_getPlutoRow(agendaNotificacaoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(AgendaNotificacaoModel agendaNotificacaoModel) {
		return PlutoRow(
			cells: _getPlutoCells(agendaNotificacaoModel: agendaNotificacaoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ AgendaNotificacaoModel? agendaNotificacaoModel}) {
		return {
			"id": PlutoCell(value: agendaNotificacaoModel?.id ?? 0),
			"dataNotificacao": PlutoCell(value: agendaNotificacaoModel?.dataNotificacao ?? ''),
			"hora": PlutoCell(value: agendaNotificacaoModel?.hora ?? ''),
			"tipo": PlutoCell(value: agendaNotificacaoModel?.tipo ?? ''),
			"idAgendaCompromisso": PlutoCell(value: agendaNotificacaoModel?.idAgendaCompromisso ?? 0),
		};
	}

	void plutoRowToObject() {
		agendaNotificacaoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return agendaNotificacaoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			horaController.text = currentRow.cells['hora']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => AgendaNotificacaoEditPage());
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
	final horaController = MaskedTextController(mask: '00:00:00',);

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = agendaNotificacaoModel.id;
		plutoRow.cells['idAgendaCompromisso']?.value = agendaNotificacaoModel.idAgendaCompromisso;
		plutoRow.cells['dataNotificacao']?.value = Util.formatDate(agendaNotificacaoModel.dataNotificacao);
		plutoRow.cells['hora']?.value = agendaNotificacaoModel.hora;
		plutoRow.cells['tipo']?.value = agendaNotificacaoModel.tipo;
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
		agendaNotificacaoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = AgendaNotificacaoModel();
			model.plutoRowToObject(plutoRow);
			agendaNotificacaoModelList.add(model);
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
		horaController.dispose();
		super.onClose();
	}
}