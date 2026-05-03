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

class ReuniaoSalaEventoController extends GetxController {

	// general
	final gridColumns = reuniaoSalaEventoGridColumns();
	
	var reuniaoSalaEventoModelList = <ReuniaoSalaEventoModel>[];

	final _reuniaoSalaEventoModel = ReuniaoSalaEventoModel().obs;
	ReuniaoSalaEventoModel get reuniaoSalaEventoModel => _reuniaoSalaEventoModel.value;
	set reuniaoSalaEventoModel(value) => _reuniaoSalaEventoModel.value = value ?? ReuniaoSalaEventoModel();
	
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
		for (var reuniaoSalaEventoModel in reuniaoSalaEventoModelList) {
			plutoRowList.add(_getPlutoRow(reuniaoSalaEventoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ReuniaoSalaEventoModel reuniaoSalaEventoModel) {
		return PlutoRow(
			cells: _getPlutoCells(reuniaoSalaEventoModel: reuniaoSalaEventoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ReuniaoSalaEventoModel? reuniaoSalaEventoModel}) {
		return {
			"id": PlutoCell(value: reuniaoSalaEventoModel?.id ?? 0),
			"reuniaoSala": PlutoCell(value: reuniaoSalaEventoModel?.reuniaoSalaModel?.nome ?? ''),
			"dataReserva": PlutoCell(value: reuniaoSalaEventoModel?.dataReserva ?? ''),
			"idAgendaCompromisso": PlutoCell(value: reuniaoSalaEventoModel?.idAgendaCompromisso ?? 0),
			"idReuniaoSala": PlutoCell(value: reuniaoSalaEventoModel?.idReuniaoSala ?? 0),
		};
	}

	void plutoRowToObject() {
		reuniaoSalaEventoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return reuniaoSalaEventoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			reuniaoSalaModelController.text = currentRow.cells['reuniaoSala']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ReuniaoSalaEventoEditPage());
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
	final reuniaoSalaModelController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = reuniaoSalaEventoModel.id;
		plutoRow.cells['idAgendaCompromisso']?.value = reuniaoSalaEventoModel.idAgendaCompromisso;
		plutoRow.cells['idReuniaoSala']?.value = reuniaoSalaEventoModel.idReuniaoSala;
		plutoRow.cells['reuniaoSala']?.value = reuniaoSalaEventoModel.reuniaoSalaModel?.nome;
		plutoRow.cells['dataReserva']?.value = Util.formatDate(reuniaoSalaEventoModel.dataReserva);
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
		reuniaoSalaEventoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ReuniaoSalaEventoModel();
			model.plutoRowToObject(plutoRow);
			reuniaoSalaEventoModelList.add(model);
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

	Future callReuniaoSalaLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Sala]'; 
		lookupController.route = '/reuniao-sala/'; 
		lookupController.gridColumns = reuniaoSalaGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ReuniaoSalaModel.aliasColumns; 
		lookupController.dbColumns = ReuniaoSalaModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			reuniaoSalaEventoModel.idReuniaoSala = plutoRowResult.cells['id']!.value; 
			reuniaoSalaEventoModel.reuniaoSalaModel!.plutoRowToObject(plutoRowResult); 
			reuniaoSalaModelController.text = reuniaoSalaEventoModel.reuniaoSalaModel?.nome ?? ''; 
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
		reuniaoSalaModelController.dispose();
		super.onClose();
	}
}