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

class CteTomadorController extends GetxController {

	// general
	final gridColumns = cteTomadorGridColumns();
	
	var cteTomadorModelList = <CteTomadorModel>[];

	final _cteTomadorModel = CteTomadorModel().obs;
	CteTomadorModel get cteTomadorModel => _cteTomadorModel.value;
	set cteTomadorModel(value) => _cteTomadorModel.value = value ?? CteTomadorModel();
	
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
		for (var cteTomadorModel in cteTomadorModelList) {
			plutoRowList.add(_getPlutoRow(cteTomadorModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(CteTomadorModel cteTomadorModel) {
		return PlutoRow(
			cells: _getPlutoCells(cteTomadorModel: cteTomadorModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ CteTomadorModel? cteTomadorModel}) {
		return {
			"id": PlutoCell(value: cteTomadorModel?.id ?? 0),
			"cnpj": PlutoCell(value: cteTomadorModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: cteTomadorModel?.cpf ?? ''),
			"ie": PlutoCell(value: cteTomadorModel?.ie ?? ''),
			"nome": PlutoCell(value: cteTomadorModel?.nome ?? ''),
			"fantasia": PlutoCell(value: cteTomadorModel?.fantasia ?? ''),
			"telefone": PlutoCell(value: cteTomadorModel?.telefone ?? ''),
			"logradouro": PlutoCell(value: cteTomadorModel?.logradouro ?? ''),
			"numero": PlutoCell(value: cteTomadorModel?.numero ?? ''),
			"complemento": PlutoCell(value: cteTomadorModel?.complemento ?? ''),
			"bairro": PlutoCell(value: cteTomadorModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: cteTomadorModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: cteTomadorModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: cteTomadorModel?.uf ?? ''),
			"cep": PlutoCell(value: cteTomadorModel?.cep ?? ''),
			"codigoPais": PlutoCell(value: cteTomadorModel?.codigoPais ?? 0),
			"nomePais": PlutoCell(value: cteTomadorModel?.nomePais ?? ''),
			"email": PlutoCell(value: cteTomadorModel?.email ?? ''),
			"idCteCabecalho": PlutoCell(value: cteTomadorModel?.idCteCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		cteTomadorModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return cteTomadorModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			ieController.text = currentRow.cells['ie']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			fantasiaController.text = currentRow.cells['fantasia']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			codigoMunicipioController.text = currentRow.cells['codigoMunicipio']?.value?.toString() ?? '';
			nomeMunicipioController.text = currentRow.cells['nomeMunicipio']?.value ?? '';
			cepController.text = currentRow.cells['cep']?.value ?? '';
			codigoPaisController.text = currentRow.cells['codigoPais']?.value?.toString() ?? '';
			nomePaisController.text = currentRow.cells['nomePais']?.value ?? '';
			emailController.text = currentRow.cells['email']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => CteTomadorEditPage());
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
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final ieController = TextEditingController();
	final nomeController = TextEditingController();
	final fantasiaController = TextEditingController();
	final telefoneController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final codigoMunicipioController = TextEditingController();
	final nomeMunicipioController = TextEditingController();
	final cepController = MaskedTextController(mask: '00000-000',);
	final codigoPaisController = TextEditingController();
	final nomePaisController = TextEditingController();
	final emailController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = cteTomadorModel.id;
		plutoRow.cells['idCteCabecalho']?.value = cteTomadorModel.idCteCabecalho;
		plutoRow.cells['cnpj']?.value = cteTomadorModel.cnpj;
		plutoRow.cells['cpf']?.value = cteTomadorModel.cpf;
		plutoRow.cells['ie']?.value = cteTomadorModel.ie;
		plutoRow.cells['nome']?.value = cteTomadorModel.nome;
		plutoRow.cells['fantasia']?.value = cteTomadorModel.fantasia;
		plutoRow.cells['telefone']?.value = cteTomadorModel.telefone;
		plutoRow.cells['logradouro']?.value = cteTomadorModel.logradouro;
		plutoRow.cells['numero']?.value = cteTomadorModel.numero;
		plutoRow.cells['complemento']?.value = cteTomadorModel.complemento;
		plutoRow.cells['bairro']?.value = cteTomadorModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = cteTomadorModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = cteTomadorModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = cteTomadorModel.uf;
		plutoRow.cells['cep']?.value = cteTomadorModel.cep;
		plutoRow.cells['codigoPais']?.value = cteTomadorModel.codigoPais;
		plutoRow.cells['nomePais']?.value = cteTomadorModel.nomePais;
		plutoRow.cells['email']?.value = cteTomadorModel.email;
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
		cteTomadorModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = CteTomadorModel();
			model.plutoRowToObject(plutoRow);
			cteTomadorModelList.add(model);
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
		cpfController.dispose();
		ieController.dispose();
		nomeController.dispose();
		fantasiaController.dispose();
		telefoneController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		codigoMunicipioController.dispose();
		nomeMunicipioController.dispose();
		cepController.dispose();
		codigoPaisController.dispose();
		nomePaisController.dispose();
		emailController.dispose();
		super.onClose();
	}
}