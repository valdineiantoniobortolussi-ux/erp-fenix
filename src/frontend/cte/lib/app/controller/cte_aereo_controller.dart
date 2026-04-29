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

class CteAereoController extends GetxController {

	// general
	final gridColumns = cteAereoGridColumns();
	
	var cteAereoModelList = <CteAereoModel>[];

	final _cteAereoModel = CteAereoModel().obs;
	CteAereoModel get cteAereoModel => _cteAereoModel.value;
	set cteAereoModel(value) => _cteAereoModel.value = value ?? CteAereoModel();
	
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
		for (var cteAereoModel in cteAereoModelList) {
			plutoRowList.add(_getPlutoRow(cteAereoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteAereoModel cteAereoModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteAereoModel: cteAereoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteAereoModel? cteAereoModel}) {
		return {
			"id": PlutoCell(value: cteAereoModel?.id ?? 0),
			"numeroMinuta": PlutoCell(value: cteAereoModel?.numeroMinuta ?? 0),
			"numeroConhecimento": PlutoCell(value: cteAereoModel?.numeroConhecimento ?? 0),
			"dataPrevistaEntrega": PlutoCell(value: cteAereoModel?.dataPrevistaEntrega ?? ''),
			"idEmissor": PlutoCell(value: cteAereoModel?.idEmissor ?? ''),
			"idInternaTomador": PlutoCell(value: cteAereoModel?.idInternaTomador ?? ''),
			"tarifaClasse": PlutoCell(value: cteAereoModel?.tarifaClasse ?? ''),
			"tarifaCodigo": PlutoCell(value: cteAereoModel?.tarifaCodigo ?? ''),
			"tarifaValor": PlutoCell(value: cteAereoModel?.tarifaValor ?? 0),
			"cargaDimensao": PlutoCell(value: cteAereoModel?.cargaDimensao ?? ''),
			"cargaInformacaoManuseio": PlutoCell(value: cteAereoModel?.cargaInformacaoManuseio ?? ''),
			"cargaEspecial": PlutoCell(value: cteAereoModel?.cargaEspecial ?? ''),
			"idCteCabecalho": PlutoCell(value: cteAereoModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteAereoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteAereoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			numeroMinutaController.text = currentRow.cells['numeroMinuta']?.value?.toString() ?? '';
			numeroConhecimentoController.text = currentRow.cells['numeroConhecimento']?.value?.toString() ?? '';
			idEmissorController.text = currentRow.cells['idEmissor']?.value ?? '';
			idInternaTomadorController.text = currentRow.cells['idInternaTomador']?.value ?? '';
			tarifaCodigoController.text = currentRow.cells['tarifaCodigo']?.value ?? '';
			tarifaValorController.text = currentRow.cells['tarifaValor']?.value?.toStringAsFixed(2) ?? '';
			cargaDimensaoController.text = currentRow.cells['cargaDimensao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteAereoEditPage());
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
	final numeroMinutaController = TextEditingController();
	final numeroConhecimentoController = TextEditingController();
	final idEmissorController = TextEditingController();
	final idInternaTomadorController = TextEditingController();
	final tarifaCodigoController = TextEditingController();
	final tarifaValorController = MoneyMaskedTextController();
	final cargaDimensaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteAereoModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteAereoModel.idCteCabecalho;
		plutoRow.cells['numeroMinuta']?.value = cteAereoModel.numeroMinuta;
		plutoRow.cells['numeroConhecimento']?.value = cteAereoModel.numeroConhecimento;
		plutoRow.cells['dataPrevistaEntrega']?.value = Util.formatDate(cteAereoModel.dataPrevistaEntrega);
		plutoRow.cells['idEmissor']?.value = cteAereoModel.idEmissor;
		plutoRow.cells['idInternaTomador']?.value = cteAereoModel.idInternaTomador;
		plutoRow.cells['tarifaClasse']?.value = cteAereoModel.tarifaClasse;
		plutoRow.cells['tarifaCodigo']?.value = cteAereoModel.tarifaCodigo;
		plutoRow.cells['tarifaValor']?.value = cteAereoModel.tarifaValor;
		plutoRow.cells['cargaDimensao']?.value = cteAereoModel.cargaDimensao;
		plutoRow.cells['cargaInformacaoManuseio']?.value = cteAereoModel.cargaInformacaoManuseio;
		plutoRow.cells['cargaEspecial']?.value = cteAereoModel.cargaEspecial;
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
		cteAereoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteAereoModel();
			model.plutoRowToObject(plutoRow);
			cteAereoModelList.add(model);
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
		numeroMinutaController.dispose();
		numeroConhecimentoController.dispose();
		idEmissorController.dispose();
		idInternaTomadorController.dispose();
		tarifaCodigoController.dispose();
		tarifaValorController.dispose();
		cargaDimensaoController.dispose();
		super.onClose();
	}
}