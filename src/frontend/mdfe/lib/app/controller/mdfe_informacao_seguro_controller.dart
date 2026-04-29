import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';
import 'package:mdfe/app/page/page_imports.dart';
import 'package:mdfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:mdfe/app/page/shared_widget/message_dialog.dart';

class MdfeInformacaoSeguroController extends GetxController {

	// general
	final gridColumns = mdfeInformacaoSeguroGridColumns();
	
	var mdfeInformacaoSeguroModelList = <MdfeInformacaoSeguroModel>[];

	final _mdfeInformacaoSeguroModel = MdfeInformacaoSeguroModel().obs;
	MdfeInformacaoSeguroModel get mdfeInformacaoSeguroModel => _mdfeInformacaoSeguroModel.value;
	set mdfeInformacaoSeguroModel(value) => _mdfeInformacaoSeguroModel.value = value ?? MdfeInformacaoSeguroModel();
	
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
		for (var mdfeInformacaoSeguroModel in mdfeInformacaoSeguroModelList) {
			plutoRowList.add(_getPlutoRow(mdfeInformacaoSeguroModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(MdfeInformacaoSeguroModel mdfeInformacaoSeguroModel) {
		return PlutoRow(
			cells: _getPlutoCells(mdfeInformacaoSeguroModel: mdfeInformacaoSeguroModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ MdfeInformacaoSeguroModel? mdfeInformacaoSeguroModel}) {
		return {
			"id": PlutoCell(value: mdfeInformacaoSeguroModel?.id ?? 0),
			"responsavel": PlutoCell(value: mdfeInformacaoSeguroModel?.responsavel ?? 0),
			"cnpjCpf": PlutoCell(value: mdfeInformacaoSeguroModel?.cnpjCpf ?? ''),
			"seguradora": PlutoCell(value: mdfeInformacaoSeguroModel?.seguradora ?? ''),
			"cnpjSeguradora": PlutoCell(value: mdfeInformacaoSeguroModel?.cnpjSeguradora ?? ''),
			"apolice": PlutoCell(value: mdfeInformacaoSeguroModel?.apolice ?? ''),
			"averbacao": PlutoCell(value: mdfeInformacaoSeguroModel?.averbacao ?? ''),
			"idMdfeCabecalho": PlutoCell(value: mdfeInformacaoSeguroModel?.idMdfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		mdfeInformacaoSeguroModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return mdfeInformacaoSeguroModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			responsavelController.text = currentRow.cells['responsavel']?.value?.toString() ?? '';
			cnpjCpfController.text = currentRow.cells['cnpjCpf']?.value ?? '';
			seguradoraController.text = currentRow.cells['seguradora']?.value ?? '';
			cnpjSeguradoraController.text = currentRow.cells['cnpjSeguradora']?.value ?? '';
			apoliceController.text = currentRow.cells['apolice']?.value ?? '';
			averbacaoController.text = currentRow.cells['averbacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => MdfeInformacaoSeguroEditPage());
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
	final responsavelController = TextEditingController();
	final cnpjCpfController = MaskedTextController(mask: '000.000.000-00',);
	final seguradoraController = TextEditingController();
	final cnpjSeguradoraController = MaskedTextController(mask: '00.000.000/0000-00',);
	final apoliceController = TextEditingController();
	final averbacaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = mdfeInformacaoSeguroModel.id;
		plutoRow.cells['idMdfeCabecalho']?.value = mdfeInformacaoSeguroModel.idMdfeCabecalho;
		plutoRow.cells['responsavel']?.value = mdfeInformacaoSeguroModel.responsavel;
		plutoRow.cells['cnpjCpf']?.value = mdfeInformacaoSeguroModel.cnpjCpf;
		plutoRow.cells['seguradora']?.value = mdfeInformacaoSeguroModel.seguradora;
		plutoRow.cells['cnpjSeguradora']?.value = mdfeInformacaoSeguroModel.cnpjSeguradora;
		plutoRow.cells['apolice']?.value = mdfeInformacaoSeguroModel.apolice;
		plutoRow.cells['averbacao']?.value = mdfeInformacaoSeguroModel.averbacao;
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
		mdfeInformacaoSeguroModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = MdfeInformacaoSeguroModel();
			model.plutoRowToObject(plutoRow);
			mdfeInformacaoSeguroModelList.add(model);
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
		responsavelController.dispose();
		cnpjCpfController.dispose();
		seguradoraController.dispose();
		cnpjSeguradoraController.dispose();
		apoliceController.dispose();
		averbacaoController.dispose();
		super.onClose();
	}
}