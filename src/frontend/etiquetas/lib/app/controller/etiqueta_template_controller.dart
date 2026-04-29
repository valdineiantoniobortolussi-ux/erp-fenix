import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:etiquetas/app/infra/infra_imports.dart';
import 'package:etiquetas/app/data/model/model_imports.dart';
import 'package:etiquetas/app/page/page_imports.dart';
import 'package:etiquetas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:etiquetas/app/page/shared_widget/message_dialog.dart';

class EtiquetaTemplateController extends GetxController {

	// general
	final gridColumns = etiquetaTemplateGridColumns();
	
	var etiquetaTemplateModelList = <EtiquetaTemplateModel>[];

	final _etiquetaTemplateModel = EtiquetaTemplateModel().obs;
	EtiquetaTemplateModel get etiquetaTemplateModel => _etiquetaTemplateModel.value;
	set etiquetaTemplateModel(value) => _etiquetaTemplateModel.value = value ?? EtiquetaTemplateModel();
	
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
		for (var etiquetaTemplateModel in etiquetaTemplateModelList) {
			plutoRowList.add(_getPlutoRow(etiquetaTemplateModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(EtiquetaTemplateModel etiquetaTemplateModel) {
		return PlutoRow(
			cells: _getPlutoCells(etiquetaTemplateModel: etiquetaTemplateModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ EtiquetaTemplateModel? etiquetaTemplateModel}) {
		return {
			"id": PlutoCell(value: etiquetaTemplateModel?.id ?? 0),
			"tabela": PlutoCell(value: etiquetaTemplateModel?.tabela ?? ''),
			"campo": PlutoCell(value: etiquetaTemplateModel?.campo ?? ''),
			"formato": PlutoCell(value: etiquetaTemplateModel?.formato ?? ''),
			"quantidadeRepeticoes": PlutoCell(value: etiquetaTemplateModel?.quantidadeRepeticoes ?? 0),
			"filtro": PlutoCell(value: etiquetaTemplateModel?.filtro ?? ''),
			"idEtiquetaLayout": PlutoCell(value: etiquetaTemplateModel?.idEtiquetaLayout ?? 0),
		};
	}

	void plutoRowToObject() {
		etiquetaTemplateModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return etiquetaTemplateModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			tabelaController.text = currentRow.cells['tabela']?.value ?? '';
			campoController.text = currentRow.cells['campo']?.value ?? '';
			quantidadeRepeticoesController.text = currentRow.cells['quantidadeRepeticoes']?.value?.toString() ?? '';
			filtroController.text = currentRow.cells['filtro']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => EtiquetaTemplateEditPage());
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
	final tabelaController = TextEditingController();
	final campoController = TextEditingController();
	final quantidadeRepeticoesController = TextEditingController();
	final filtroController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = etiquetaTemplateModel.id;
		plutoRow.cells['idEtiquetaLayout']?.value = etiquetaTemplateModel.idEtiquetaLayout;
		plutoRow.cells['tabela']?.value = etiquetaTemplateModel.tabela;
		plutoRow.cells['campo']?.value = etiquetaTemplateModel.campo;
		plutoRow.cells['formato']?.value = etiquetaTemplateModel.formato;
		plutoRow.cells['quantidadeRepeticoes']?.value = etiquetaTemplateModel.quantidadeRepeticoes;
		plutoRow.cells['filtro']?.value = etiquetaTemplateModel.filtro;
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
		etiquetaTemplateModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = EtiquetaTemplateModel();
			model.plutoRowToObject(plutoRow);
			etiquetaTemplateModelList.add(model);
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
		tabelaController.dispose();
		campoController.dispose();
		quantidadeRepeticoesController.dispose();
		filtroController.dispose();
		super.onClose();
	}
}