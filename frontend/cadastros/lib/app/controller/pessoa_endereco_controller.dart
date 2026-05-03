import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/page/page_imports.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/page/shared_widget/message_dialog.dart';

class PessoaEnderecoController extends GetxController {

	// general
	final gridColumns = pessoaEnderecoGridColumns();
	
	var pessoaEnderecoModelList = <PessoaEnderecoModel>[];

	final _pessoaEnderecoModel = PessoaEnderecoModel().obs;
	PessoaEnderecoModel get pessoaEnderecoModel => _pessoaEnderecoModel.value;
	set pessoaEnderecoModel(value) => _pessoaEnderecoModel.value = value ?? PessoaEnderecoModel();
	
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
		for (var pessoaEnderecoModel in pessoaEnderecoModelList) {
			plutoRowList.add(_getPlutoRow(pessoaEnderecoModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(PessoaEnderecoModel pessoaEnderecoModel) {
		return PlutoRow(
			cells: _getPlutoCells(pessoaEnderecoModel: pessoaEnderecoModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ PessoaEnderecoModel? pessoaEnderecoModel}) {
		return {
			"id": PlutoCell(value: pessoaEnderecoModel?.id ?? 0),
			"logradouro": PlutoCell(value: pessoaEnderecoModel?.logradouro ?? ''),
			"numero": PlutoCell(value: pessoaEnderecoModel?.numero ?? ''),
			"complemento": PlutoCell(value: pessoaEnderecoModel?.complemento ?? ''),
			"bairro": PlutoCell(value: pessoaEnderecoModel?.bairro ?? ''),
			"cidade": PlutoCell(value: pessoaEnderecoModel?.cidade ?? ''),
			"uf": PlutoCell(value: pessoaEnderecoModel?.uf ?? ''),
			"cep": PlutoCell(value: pessoaEnderecoModel?.cep ?? ''),
			"municipioIbge": PlutoCell(value: pessoaEnderecoModel?.municipioIbge ?? 0),
			"principal": PlutoCell(value: pessoaEnderecoModel?.principal ?? ''),
			"entrega": PlutoCell(value: pessoaEnderecoModel?.entrega ?? ''),
			"cobranca": PlutoCell(value: pessoaEnderecoModel?.cobranca ?? ''),
			"correspondencia": PlutoCell(value: pessoaEnderecoModel?.correspondencia ?? ''),
			"idPessoa": PlutoCell(value: pessoaEnderecoModel?.idPessoa ?? 0),
		};
	}

	void plutoRowToObject() {
		pessoaEnderecoModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return pessoaEnderecoModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			cidadeController.text = currentRow.cells['cidade']?.value ?? '';
			cepController.text = currentRow.cells['cep']?.value ?? '';
			municipioIbgeController.text = currentRow.cells['municipioIbge']?.value?.toString() ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => PessoaEnderecoEditPage());
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
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final cidadeController = TextEditingController();
	final cepController = MaskedTextController(mask: '00000-000',);
	final municipioIbgeController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = pessoaEnderecoModel.id;
		plutoRow.cells['idPessoa']?.value = pessoaEnderecoModel.idPessoa;
		plutoRow.cells['logradouro']?.value = pessoaEnderecoModel.logradouro;
		plutoRow.cells['numero']?.value = pessoaEnderecoModel.numero;
		plutoRow.cells['complemento']?.value = pessoaEnderecoModel.complemento;
		plutoRow.cells['bairro']?.value = pessoaEnderecoModel.bairro;
		plutoRow.cells['cidade']?.value = pessoaEnderecoModel.cidade;
		plutoRow.cells['uf']?.value = pessoaEnderecoModel.uf;
		plutoRow.cells['cep']?.value = pessoaEnderecoModel.cep;
		plutoRow.cells['municipioIbge']?.value = pessoaEnderecoModel.municipioIbge;
		plutoRow.cells['principal']?.value = pessoaEnderecoModel.principal;
		plutoRow.cells['entrega']?.value = pessoaEnderecoModel.entrega;
		plutoRow.cells['cobranca']?.value = pessoaEnderecoModel.cobranca;
		plutoRow.cells['correspondencia']?.value = pessoaEnderecoModel.correspondencia;
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
		pessoaEnderecoModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = PessoaEnderecoModel();
			model.plutoRowToObject(plutoRow);
			pessoaEnderecoModelList.add(model);
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
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		cidadeController.dispose();
		cepController.dispose();
		municipioIbgeController.dispose();
		super.onClose();
	}
}