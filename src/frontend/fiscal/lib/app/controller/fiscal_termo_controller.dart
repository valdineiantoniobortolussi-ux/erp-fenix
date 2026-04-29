import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:fiscal/app/page/page_imports.dart';
import 'package:fiscal/app/page/grid_columns/grid_columns_imports.dart';
import 'package:fiscal/app/page/shared_widget/message_dialog.dart';

class FiscalTermoController extends GetxController {

	// general
	final gridColumns = fiscalTermoGridColumns();
	
	var fiscalTermoModelList = <FiscalTermoModel>[];

	final _fiscalTermoModel = FiscalTermoModel().obs;
	FiscalTermoModel get fiscalTermoModel => _fiscalTermoModel.value;
	set fiscalTermoModel(value) => _fiscalTermoModel.value = value ?? FiscalTermoModel();
	
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
		for (var fiscalTermoModel in fiscalTermoModelList) {
			plutoRowList.add(_getPlutoRow(fiscalTermoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(FiscalTermoModel fiscalTermoModel) {
		return PlutoRow(
			cells: _getPlutoCells(fiscalTermoModel: fiscalTermoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ FiscalTermoModel? fiscalTermoModel}) {
		return {
			"id": PlutoCell(value: fiscalTermoModel?.id ?? 0),
			"aberturaEncerramento": PlutoCell(value: fiscalTermoModel?.aberturaEncerramento ?? ''),
			"numero": PlutoCell(value: fiscalTermoModel?.numero ?? 0),
			"paginaInicial": PlutoCell(value: fiscalTermoModel?.paginaInicial ?? 0),
			"paginaFinal": PlutoCell(value: fiscalTermoModel?.paginaFinal ?? 0),
			"numeroRegistro": PlutoCell(value: fiscalTermoModel?.numeroRegistro ?? ''),
			"registrado": PlutoCell(value: fiscalTermoModel?.registrado ?? ''),
			"dataDespacho": PlutoCell(value: fiscalTermoModel?.dataDespacho ?? ''),
			"dataAbertura": PlutoCell(value: fiscalTermoModel?.dataAbertura ?? ''),
			"dataEncerramento": PlutoCell(value: fiscalTermoModel?.dataEncerramento ?? ''),
			"escrituracaoInicio": PlutoCell(value: fiscalTermoModel?.escrituracaoInicio ?? ''),
			"escrituracaoFim": PlutoCell(value: fiscalTermoModel?.escrituracaoFim ?? ''),
			"texto": PlutoCell(value: fiscalTermoModel?.texto ?? ''),
			"idFiscalLivro": PlutoCell(value: fiscalTermoModel?.idFiscalLivro ?? 0),
		};
	}

	void plutoRowToObject() {
		fiscalTermoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return fiscalTermoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			paginaInicialController.text = currentRow.cells['paginaInicial']?.value?.toString() ?? '';
			paginaFinalController.text = currentRow.cells['paginaFinal']?.value?.toString() ?? '';
			numeroRegistroController.text = currentRow.cells['numeroRegistro']?.value ?? '';
			registradoController.text = currentRow.cells['registrado']?.value ?? '';
			textoController.text = currentRow.cells['texto']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => FiscalTermoEditPage());
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
	final numeroController = TextEditingController();
	final paginaInicialController = TextEditingController();
	final paginaFinalController = TextEditingController();
	final numeroRegistroController = TextEditingController();
	final registradoController = TextEditingController();
	final textoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = fiscalTermoModel.id;
		plutoRow.cells['idFiscalLivro']?.value = fiscalTermoModel.idFiscalLivro;
		plutoRow.cells['aberturaEncerramento']?.value = fiscalTermoModel.aberturaEncerramento;
		plutoRow.cells['numero']?.value = fiscalTermoModel.numero;
		plutoRow.cells['paginaInicial']?.value = fiscalTermoModel.paginaInicial;
		plutoRow.cells['paginaFinal']?.value = fiscalTermoModel.paginaFinal;
		plutoRow.cells['numeroRegistro']?.value = fiscalTermoModel.numeroRegistro;
		plutoRow.cells['registrado']?.value = fiscalTermoModel.registrado;
		plutoRow.cells['dataDespacho']?.value = Util.formatDate(fiscalTermoModel.dataDespacho);
		plutoRow.cells['dataAbertura']?.value = Util.formatDate(fiscalTermoModel.dataAbertura);
		plutoRow.cells['dataEncerramento']?.value = Util.formatDate(fiscalTermoModel.dataEncerramento);
		plutoRow.cells['escrituracaoInicio']?.value = Util.formatDate(fiscalTermoModel.escrituracaoInicio);
		plutoRow.cells['escrituracaoFim']?.value = Util.formatDate(fiscalTermoModel.escrituracaoFim);
		plutoRow.cells['texto']?.value = fiscalTermoModel.texto;
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
		fiscalTermoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = FiscalTermoModel();
			model.plutoRowToObject(plutoRow);
			fiscalTermoModelList.add(model);
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
		numeroController.dispose();
		paginaInicialController.dispose();
		paginaFinalController.dispose();
		numeroRegistroController.dispose();
		registradoController.dispose();
		textoController.dispose();
		super.onClose();
	}
}