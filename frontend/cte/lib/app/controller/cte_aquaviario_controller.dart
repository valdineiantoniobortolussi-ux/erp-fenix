import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CteAquaviarioController extends GetxController {

	// general
	final gridColumns = cteAquaviarioGridColumns();
	
	var cteAquaviarioModelList = <CteAquaviarioModel>[];

	final _cteAquaviarioModel = CteAquaviarioModel().obs;
	CteAquaviarioModel get cteAquaviarioModel => _cteAquaviarioModel.value;
	set cteAquaviarioModel(value) => _cteAquaviarioModel.value = value ?? CteAquaviarioModel();
	
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
		for (var cteAquaviarioModel in cteAquaviarioModelList) {
			plutoRowList.add(_getPlutoRow(cteAquaviarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteAquaviarioModel cteAquaviarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteAquaviarioModel: cteAquaviarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteAquaviarioModel? cteAquaviarioModel}) {
		return {
			"id": PlutoCell(value: cteAquaviarioModel?.id ?? 0),
			"valorPrestacao": PlutoCell(value: cteAquaviarioModel?.valorPrestacao ?? 0),
			"afrmm": PlutoCell(value: cteAquaviarioModel?.afrmm ?? 0),
			"numeroBooking": PlutoCell(value: cteAquaviarioModel?.numeroBooking ?? ''),
			"numeroControle": PlutoCell(value: cteAquaviarioModel?.numeroControle ?? ''),
			"idNavio": PlutoCell(value: cteAquaviarioModel?.idNavio ?? ''),
			"idCteCabecalho": PlutoCell(value: cteAquaviarioModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteAquaviarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteAquaviarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			valorPrestacaoController.text = currentRow.cells['valorPrestacao']?.value?.toStringAsFixed(2) ?? '';
			afrmmController.text = currentRow.cells['afrmm']?.value?.toStringAsFixed(2) ?? '';
			numeroBookingController.text = currentRow.cells['numeroBooking']?.value ?? '';
			numeroControleController.text = currentRow.cells['numeroControle']?.value ?? '';
			idNavioController.text = currentRow.cells['idNavio']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteAquaviarioEditPage());
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
	final valorPrestacaoController = MoneyMaskedTextController();
	final afrmmController = MoneyMaskedTextController();
	final numeroBookingController = TextEditingController();
	final numeroControleController = TextEditingController();
	final idNavioController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteAquaviarioModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteAquaviarioModel.idCteCabecalho;
		plutoRow.cells['valorPrestacao']?.value = cteAquaviarioModel.valorPrestacao;
		plutoRow.cells['afrmm']?.value = cteAquaviarioModel.afrmm;
		plutoRow.cells['numeroBooking']?.value = cteAquaviarioModel.numeroBooking;
		plutoRow.cells['numeroControle']?.value = cteAquaviarioModel.numeroControle;
		plutoRow.cells['idNavio']?.value = cteAquaviarioModel.idNavio;
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
		cteAquaviarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteAquaviarioModel();
			model.plutoRowToObject(plutoRow);
			cteAquaviarioModelList.add(model);
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
		valorPrestacaoController.dispose();
		afrmmController.dispose();
		numeroBookingController.dispose();
		numeroControleController.dispose();
		idNavioController.dispose();
		super.onClose();
	}
}