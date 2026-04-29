import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/page/page_imports.dart';
import 'package:cte/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cte/app/page/shared_widget/message_dialog.dart';

class CtePerigosoController extends GetxController {

	// general
	final gridColumns = ctePerigosoGridColumns();
	
	var ctePerigosoModelList = <CtePerigosoModel>[];

	final _ctePerigosoModel = CtePerigosoModel().obs;
	CtePerigosoModel get ctePerigosoModel => _ctePerigosoModel.value;
	set ctePerigosoModel(value) => _ctePerigosoModel.value = value ?? CtePerigosoModel();
	
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
		for (var ctePerigosoModel in ctePerigosoModelList) {
			plutoRowList.add(_getPlutoRow(ctePerigosoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CtePerigosoModel ctePerigosoModel) {
		return PlutoRow(
			cells: _getPlutoCells(ctePerigosoModel: ctePerigosoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CtePerigosoModel? ctePerigosoModel}) {
		return {
			"id": PlutoCell(value: ctePerigosoModel?.id ?? 0),
			"numeroOnu": PlutoCell(value: ctePerigosoModel?.numeroOnu ?? ''),
			"nomeApropriado": PlutoCell(value: ctePerigosoModel?.nomeApropriado ?? ''),
			"classeRisco": PlutoCell(value: ctePerigosoModel?.classeRisco ?? ''),
			"grupoEmbalagem": PlutoCell(value: ctePerigosoModel?.grupoEmbalagem ?? ''),
			"quantidadeTotalProduto": PlutoCell(value: ctePerigosoModel?.quantidadeTotalProduto ?? ''),
			"quantidadeTipoVolume": PlutoCell(value: ctePerigosoModel?.quantidadeTipoVolume ?? ''),
			"pontoFulgor": PlutoCell(value: ctePerigosoModel?.pontoFulgor ?? ''),
			"idCteCabecalho": PlutoCell(value: ctePerigosoModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		ctePerigosoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return ctePerigosoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroOnuController.text = currentRow.cells['numeroOnu']?.value ?? '';
			nomeApropriadoController.text = currentRow.cells['nomeApropriado']?.value ?? '';
			classeRiscoController.text = currentRow.cells['classeRisco']?.value ?? '';
			grupoEmbalagemController.text = currentRow.cells['grupoEmbalagem']?.value ?? '';
			quantidadeTotalProdutoController.text = currentRow.cells['quantidadeTotalProduto']?.value ?? '';
			quantidadeTipoVolumeController.text = currentRow.cells['quantidadeTipoVolume']?.value ?? '';
			pontoFulgorController.text = currentRow.cells['pontoFulgor']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CtePerigosoEditPage());
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
	final numeroOnuController = TextEditingController();
	final nomeApropriadoController = TextEditingController();
	final classeRiscoController = TextEditingController();
	final grupoEmbalagemController = TextEditingController();
	final quantidadeTotalProdutoController = TextEditingController();
	final quantidadeTipoVolumeController = TextEditingController();
	final pontoFulgorController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = ctePerigosoModel.id;
		plutoRow.cells['idCteCabecalho']?.value = ctePerigosoModel.idCteCabecalho;
		plutoRow.cells['numeroOnu']?.value = ctePerigosoModel.numeroOnu;
		plutoRow.cells['nomeApropriado']?.value = ctePerigosoModel.nomeApropriado;
		plutoRow.cells['classeRisco']?.value = ctePerigosoModel.classeRisco;
		plutoRow.cells['grupoEmbalagem']?.value = ctePerigosoModel.grupoEmbalagem;
		plutoRow.cells['quantidadeTotalProduto']?.value = ctePerigosoModel.quantidadeTotalProduto;
		plutoRow.cells['quantidadeTipoVolume']?.value = ctePerigosoModel.quantidadeTipoVolume;
		plutoRow.cells['pontoFulgor']?.value = ctePerigosoModel.pontoFulgor;
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
		ctePerigosoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CtePerigosoModel();
			model.plutoRowToObject(plutoRow);
			ctePerigosoModelList.add(model);
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
		numeroOnuController.dispose();
		nomeApropriadoController.dispose();
		classeRiscoController.dispose();
		grupoEmbalagemController.dispose();
		quantidadeTotalProdutoController.dispose();
		quantidadeTipoVolumeController.dispose();
		pontoFulgorController.dispose();
		super.onClose();
	}
}