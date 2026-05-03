import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/page/page_imports.dart';
import 'package:nfe/app/page/grid_columns/grid_columns_imports.dart';
import 'package:nfe/app/page/shared_widget/message_dialog.dart';

class NfeResponsavelTecnicoController extends GetxController {

	// general
	final gridColumns = nfeResponsavelTecnicoGridColumns();
	
	var nfeResponsavelTecnicoModelList = <NfeResponsavelTecnicoModel>[];

	final _nfeResponsavelTecnicoModel = NfeResponsavelTecnicoModel().obs;
	NfeResponsavelTecnicoModel get nfeResponsavelTecnicoModel => _nfeResponsavelTecnicoModel.value;
	set nfeResponsavelTecnicoModel(value) => _nfeResponsavelTecnicoModel.value = value ?? NfeResponsavelTecnicoModel();
	
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
		for (var nfeResponsavelTecnicoModel in nfeResponsavelTecnicoModelList) {
			plutoRowList.add(_getPlutoRow(nfeResponsavelTecnicoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeResponsavelTecnicoModel nfeResponsavelTecnicoModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeResponsavelTecnicoModel: nfeResponsavelTecnicoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeResponsavelTecnicoModel? nfeResponsavelTecnicoModel}) {
		return {
			"id": PlutoCell(value: nfeResponsavelTecnicoModel?.id ?? 0),
			"cnpj": PlutoCell(value: nfeResponsavelTecnicoModel?.cnpj ?? ''),
			"contato": PlutoCell(value: nfeResponsavelTecnicoModel?.contato ?? ''),
			"email": PlutoCell(value: nfeResponsavelTecnicoModel?.email ?? ''),
			"telefone": PlutoCell(value: nfeResponsavelTecnicoModel?.telefone ?? ''),
			"identificadorCsrt": PlutoCell(value: nfeResponsavelTecnicoModel?.identificadorCsrt ?? ''),
			"hashCsrt": PlutoCell(value: nfeResponsavelTecnicoModel?.hashCsrt ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeResponsavelTecnicoModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeResponsavelTecnicoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeResponsavelTecnicoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			contatoController.text = currentRow.cells['contato']?.value ?? '';
			emailController.text = currentRow.cells['email']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';
			hashCsrtController.text = currentRow.cells['hashCsrt']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeResponsavelTecnicoEditPage());
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
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final contatoController = TextEditingController();
	final emailController = TextEditingController();
	final telefoneController = TextEditingController();
	final hashCsrtController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeResponsavelTecnicoModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeResponsavelTecnicoModel.idNfeCabecalho;
		plutoRow.cells['cnpj']?.value = nfeResponsavelTecnicoModel.cnpj;
		plutoRow.cells['contato']?.value = nfeResponsavelTecnicoModel.contato;
		plutoRow.cells['email']?.value = nfeResponsavelTecnicoModel.email;
		plutoRow.cells['telefone']?.value = nfeResponsavelTecnicoModel.telefone;
		plutoRow.cells['identificadorCsrt']?.value = nfeResponsavelTecnicoModel.identificadorCsrt;
		plutoRow.cells['hashCsrt']?.value = nfeResponsavelTecnicoModel.hashCsrt;
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
		nfeResponsavelTecnicoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeResponsavelTecnicoModel();
			model.plutoRowToObject(plutoRow);
			nfeResponsavelTecnicoModelList.add(model);
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
		cnpjController.dispose();
		contatoController.dispose();
		emailController.dispose();
		telefoneController.dispose();
		hashCsrtController.dispose();
		super.onClose();
	}
}