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

class NfeDestinatarioController extends GetxController {

	// general
	final gridColumns = nfeDestinatarioGridColumns();
	
	var nfeDestinatarioModelList = <NfeDestinatarioModel>[];

	final _nfeDestinatarioModel = NfeDestinatarioModel().obs;
	NfeDestinatarioModel get nfeDestinatarioModel => _nfeDestinatarioModel.value;
	set nfeDestinatarioModel(value) => _nfeDestinatarioModel.value = value ?? NfeDestinatarioModel();
	
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
		for (var nfeDestinatarioModel in nfeDestinatarioModelList) {
			plutoRowList.add(_getPlutoRow(nfeDestinatarioModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeDestinatarioModel nfeDestinatarioModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeDestinatarioModel: nfeDestinatarioModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeDestinatarioModel? nfeDestinatarioModel}) {
		return {
			"id": PlutoCell(value: nfeDestinatarioModel?.id ?? 0),
			"cnpj": PlutoCell(value: nfeDestinatarioModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: nfeDestinatarioModel?.cpf ?? ''),
			"estrangeiroIdentificacao": PlutoCell(value: nfeDestinatarioModel?.estrangeiroIdentificacao ?? ''),
			"nome": PlutoCell(value: nfeDestinatarioModel?.nome ?? ''),
			"logradouro": PlutoCell(value: nfeDestinatarioModel?.logradouro ?? ''),
			"numero": PlutoCell(value: nfeDestinatarioModel?.numero ?? ''),
			"complemento": PlutoCell(value: nfeDestinatarioModel?.complemento ?? ''),
			"bairro": PlutoCell(value: nfeDestinatarioModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: nfeDestinatarioModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: nfeDestinatarioModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: nfeDestinatarioModel?.uf ?? ''),
			"cep": PlutoCell(value: nfeDestinatarioModel?.cep ?? ''),
			"codigoPais": PlutoCell(value: nfeDestinatarioModel?.codigoPais ?? 0),
			"nomePais": PlutoCell(value: nfeDestinatarioModel?.nomePais ?? ''),
			"telefone": PlutoCell(value: nfeDestinatarioModel?.telefone ?? ''),
			"indicadorIe": PlutoCell(value: nfeDestinatarioModel?.indicadorIe ?? ''),
			"inscricaoEstadual": PlutoCell(value: nfeDestinatarioModel?.inscricaoEstadual ?? ''),
			"suframa": PlutoCell(value: nfeDestinatarioModel?.suframa ?? 0),
			"inscricaoMunicipal": PlutoCell(value: nfeDestinatarioModel?.inscricaoMunicipal ?? ''),
			"email": PlutoCell(value: nfeDestinatarioModel?.email ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeDestinatarioModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeDestinatarioModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeDestinatarioModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			estrangeiroIdentificacaoController.text = currentRow.cells['estrangeiroIdentificacao']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			codigoMunicipioController.text = currentRow.cells['codigoMunicipio']?.value?.toString() ?? '';
			nomeMunicipioController.text = currentRow.cells['nomeMunicipio']?.value ?? '';
			cepController.text = currentRow.cells['cep']?.value ?? '';
			codigoPaisController.text = currentRow.cells['codigoPais']?.value?.toString() ?? '';
			nomePaisController.text = currentRow.cells['nomePais']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';
			inscricaoEstadualController.text = currentRow.cells['inscricaoEstadual']?.value ?? '';
			suframaController.text = currentRow.cells['suframa']?.value?.toString() ?? '';
			inscricaoMunicipalController.text = currentRow.cells['inscricaoMunicipal']?.value ?? '';
			emailController.text = currentRow.cells['email']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeDestinatarioEditPage());
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
	final estrangeiroIdentificacaoController = TextEditingController();
	final nomeController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final codigoMunicipioController = TextEditingController();
	final nomeMunicipioController = TextEditingController();
	final cepController = MaskedTextController(mask: '00000-000',);
	final codigoPaisController = TextEditingController();
	final nomePaisController = TextEditingController();
	final telefoneController = TextEditingController();
	final inscricaoEstadualController = TextEditingController();
	final suframaController = TextEditingController();
	final inscricaoMunicipalController = TextEditingController();
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
		plutoRow.cells['id']?.value = nfeDestinatarioModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeDestinatarioModel.idNfeCabecalho;
		plutoRow.cells['cnpj']?.value = nfeDestinatarioModel.cnpj;
		plutoRow.cells['cpf']?.value = nfeDestinatarioModel.cpf;
		plutoRow.cells['estrangeiroIdentificacao']?.value = nfeDestinatarioModel.estrangeiroIdentificacao;
		plutoRow.cells['nome']?.value = nfeDestinatarioModel.nome;
		plutoRow.cells['logradouro']?.value = nfeDestinatarioModel.logradouro;
		plutoRow.cells['numero']?.value = nfeDestinatarioModel.numero;
		plutoRow.cells['complemento']?.value = nfeDestinatarioModel.complemento;
		plutoRow.cells['bairro']?.value = nfeDestinatarioModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = nfeDestinatarioModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = nfeDestinatarioModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = nfeDestinatarioModel.uf;
		plutoRow.cells['cep']?.value = nfeDestinatarioModel.cep;
		plutoRow.cells['codigoPais']?.value = nfeDestinatarioModel.codigoPais;
		plutoRow.cells['nomePais']?.value = nfeDestinatarioModel.nomePais;
		plutoRow.cells['telefone']?.value = nfeDestinatarioModel.telefone;
		plutoRow.cells['indicadorIe']?.value = nfeDestinatarioModel.indicadorIe;
		plutoRow.cells['inscricaoEstadual']?.value = nfeDestinatarioModel.inscricaoEstadual;
		plutoRow.cells['suframa']?.value = nfeDestinatarioModel.suframa;
		plutoRow.cells['inscricaoMunicipal']?.value = nfeDestinatarioModel.inscricaoMunicipal;
		plutoRow.cells['email']?.value = nfeDestinatarioModel.email;
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
		nfeDestinatarioModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeDestinatarioModel();
			model.plutoRowToObject(plutoRow);
			nfeDestinatarioModelList.add(model);
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
		estrangeiroIdentificacaoController.dispose();
		nomeController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		codigoMunicipioController.dispose();
		nomeMunicipioController.dispose();
		cepController.dispose();
		codigoPaisController.dispose();
		nomePaisController.dispose();
		telefoneController.dispose();
		inscricaoEstadualController.dispose();
		suframaController.dispose();
		inscricaoMunicipalController.dispose();
		emailController.dispose();
		super.onClose();
	}
}