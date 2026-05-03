import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/page/page_imports.dart';
import 'package:contabil/app/page/grid_columns/grid_columns_imports.dart';
import 'package:contabil/app/page/shared_widget/message_dialog.dart';

class ContabilTermoController extends GetxController {

	// general
	final gridColumns = contabilTermoGridColumns();
	
	var contabilTermoModelList = <ContabilTermoModel>[];

	final _contabilTermoModel = ContabilTermoModel().obs;
	ContabilTermoModel get contabilTermoModel => _contabilTermoModel.value;
	set contabilTermoModel(value) => _contabilTermoModel.value = value ?? ContabilTermoModel();
	
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
		for (var contabilTermoModel in contabilTermoModelList) {
			plutoRowList.add(_getPlutoRow(contabilTermoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(ContabilTermoModel contabilTermoModel) {
		return PlutoRow(
			cells: _getPlutoCells(contabilTermoModel: contabilTermoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ ContabilTermoModel? contabilTermoModel}) {
		return {
			"id": PlutoCell(value: contabilTermoModel?.id ?? 0),
			"aberturaEncerramento": PlutoCell(value: contabilTermoModel?.aberturaEncerramento ?? ''),
			"numero": PlutoCell(value: contabilTermoModel?.numero ?? 0),
			"paginaInicial": PlutoCell(value: contabilTermoModel?.paginaInicial ?? 0),
			"paginaFinal": PlutoCell(value: contabilTermoModel?.paginaFinal ?? 0),
			"registrado": PlutoCell(value: contabilTermoModel?.registrado ?? ''),
			"numeroRegistro": PlutoCell(value: contabilTermoModel?.numeroRegistro ?? ''),
			"dataDespacho": PlutoCell(value: contabilTermoModel?.dataDespacho ?? ''),
			"dataAbertura": PlutoCell(value: contabilTermoModel?.dataAbertura ?? ''),
			"dataEncerramento": PlutoCell(value: contabilTermoModel?.dataEncerramento ?? ''),
			"escrituracaoInicio": PlutoCell(value: contabilTermoModel?.escrituracaoInicio ?? ''),
			"escrituracaoFim": PlutoCell(value: contabilTermoModel?.escrituracaoFim ?? ''),
			"texto": PlutoCell(value: contabilTermoModel?.texto ?? ''),
			"idContabilLivro": PlutoCell(value: contabilTermoModel?.idContabilLivro ?? 0),
		};
	}

	void plutoRowToObject() {
		contabilTermoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return contabilTermoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroController.text = currentRow.cells['numero']?.value?.toString() ?? '';
			paginaInicialController.text = currentRow.cells['paginaInicial']?.value?.toString() ?? '';
			paginaFinalController.text = currentRow.cells['paginaFinal']?.value?.toString() ?? '';
			registradoController.text = currentRow.cells['registrado']?.value ?? '';
			numeroRegistroController.text = currentRow.cells['numeroRegistro']?.value ?? '';
			textoController.text = currentRow.cells['texto']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => ContabilTermoEditPage());
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
	final registradoController = TextEditingController();
	final numeroRegistroController = TextEditingController();
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
		plutoRow.cells['id']?.value = contabilTermoModel.id;
		plutoRow.cells['idContabilLivro']?.value = contabilTermoModel.idContabilLivro;
		plutoRow.cells['aberturaEncerramento']?.value = contabilTermoModel.aberturaEncerramento;
		plutoRow.cells['numero']?.value = contabilTermoModel.numero;
		plutoRow.cells['paginaInicial']?.value = contabilTermoModel.paginaInicial;
		plutoRow.cells['paginaFinal']?.value = contabilTermoModel.paginaFinal;
		plutoRow.cells['registrado']?.value = contabilTermoModel.registrado;
		plutoRow.cells['numeroRegistro']?.value = contabilTermoModel.numeroRegistro;
		plutoRow.cells['dataDespacho']?.value = Util.formatDate(contabilTermoModel.dataDespacho);
		plutoRow.cells['dataAbertura']?.value = Util.formatDate(contabilTermoModel.dataAbertura);
		plutoRow.cells['dataEncerramento']?.value = Util.formatDate(contabilTermoModel.dataEncerramento);
		plutoRow.cells['escrituracaoInicio']?.value = Util.formatDate(contabilTermoModel.escrituracaoInicio);
		plutoRow.cells['escrituracaoFim']?.value = Util.formatDate(contabilTermoModel.escrituracaoFim);
		plutoRow.cells['texto']?.value = contabilTermoModel.texto;
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
		contabilTermoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = ContabilTermoModel();
			model.plutoRowToObject(plutoRow);
			contabilTermoModelList.add(model);
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
		registradoController.dispose();
		numeroRegistroController.dispose();
		textoController.dispose();
		super.onClose();
	}
}