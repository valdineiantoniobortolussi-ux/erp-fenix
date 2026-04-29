import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/page_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';

class PessoaContatoController extends GetxController {

	// general
	final gridColumns = pessoaContatoGridColumns();
	
	var pessoaContatoModelList = <PessoaContatoModel>[];

	final _pessoaContatoModel = PessoaContatoModel().obs;
	PessoaContatoModel get pessoaContatoModel => _pessoaContatoModel.value;
	set pessoaContatoModel(value) => _pessoaContatoModel.value = value ?? PessoaContatoModel();
	
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
		for (var pessoaContatoModel in pessoaContatoModelList) {
			plutoRowList.add(_getPlutoRow(pessoaContatoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PessoaContatoModel pessoaContatoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pessoaContatoModel: pessoaContatoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PessoaContatoModel? pessoaContatoModel}) {
		return {
			"id": PlutoCell(value: pessoaContatoModel?.id ?? 0),
			"nome": PlutoCell(value: pessoaContatoModel?.nome ?? ''),
			"email": PlutoCell(value: pessoaContatoModel?.email ?? ''),
			"observacao": PlutoCell(value: pessoaContatoModel?.observacao ?? ''),
			"idPessoa": PlutoCell(value: pessoaContatoModel?.idPessoa ?? 0),
		};
	}

	void plutoRowToObject() {
		pessoaContatoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pessoaContatoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			emailController.text = currentRow.cells['email']?.value ?? '';
			observacaoController.text = currentRow.cells['observacao']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PessoaContatoEditPage());
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
	final nomeController = TextEditingController();
	final emailController = TextEditingController();
	final observacaoController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pessoaContatoModel.id;
		plutoRow.cells['idPessoa']?.value = pessoaContatoModel.idPessoa;
		plutoRow.cells['nome']?.value = pessoaContatoModel.nome;
		plutoRow.cells['email']?.value = pessoaContatoModel.email;
		plutoRow.cells['observacao']?.value = pessoaContatoModel.observacao;
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
		pessoaContatoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PessoaContatoModel();
			model.plutoRowToObject(plutoRow);
			pessoaContatoModelList.add(model);
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
		nomeController.dispose();
		emailController.dispose();
		observacaoController.dispose();
		super.onClose();
	}
}