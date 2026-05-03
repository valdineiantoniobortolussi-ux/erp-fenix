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

class NfeEmitenteController extends GetxController {

	// general
	final gridColumns = nfeEmitenteGridColumns();
	
	var nfeEmitenteModelList = <NfeEmitenteModel>[];

	final _nfeEmitenteModel = NfeEmitenteModel().obs;
	NfeEmitenteModel get nfeEmitenteModel => _nfeEmitenteModel.value;
	set nfeEmitenteModel(value) => _nfeEmitenteModel.value = value ?? NfeEmitenteModel();
	
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
		for (var nfeEmitenteModel in nfeEmitenteModelList) {
			plutoRowList.add(_getPlutoRow(nfeEmitenteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeEmitenteModel nfeEmitenteModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeEmitenteModel: nfeEmitenteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeEmitenteModel? nfeEmitenteModel}) {
		return {
			"id": PlutoCell(value: nfeEmitenteModel?.id ?? 0),
			"cnpj": PlutoCell(value: nfeEmitenteModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: nfeEmitenteModel?.cpf ?? ''),
			"nome": PlutoCell(value: nfeEmitenteModel?.nome ?? ''),
			"fantasia": PlutoCell(value: nfeEmitenteModel?.fantasia ?? ''),
			"logradouro": PlutoCell(value: nfeEmitenteModel?.logradouro ?? ''),
			"numero": PlutoCell(value: nfeEmitenteModel?.numero ?? ''),
			"complemento": PlutoCell(value: nfeEmitenteModel?.complemento ?? ''),
			"bairro": PlutoCell(value: nfeEmitenteModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: nfeEmitenteModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: nfeEmitenteModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: nfeEmitenteModel?.uf ?? ''),
			"cep": PlutoCell(value: nfeEmitenteModel?.cep ?? ''),
			"codigoPais": PlutoCell(value: nfeEmitenteModel?.codigoPais ?? 0),
			"nomePais": PlutoCell(value: nfeEmitenteModel?.nomePais ?? ''),
			"telefone": PlutoCell(value: nfeEmitenteModel?.telefone ?? ''),
			"inscricaoEstadual": PlutoCell(value: nfeEmitenteModel?.inscricaoEstadual ?? ''),
			"inscricaoEstadualSt": PlutoCell(value: nfeEmitenteModel?.inscricaoEstadualSt ?? ''),
			"inscricaoMunicipal": PlutoCell(value: nfeEmitenteModel?.inscricaoMunicipal ?? ''),
			"cnae": PlutoCell(value: nfeEmitenteModel?.cnae ?? ''),
			"crt": PlutoCell(value: nfeEmitenteModel?.crt ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeEmitenteModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeEmitenteModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeEmitenteModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			fantasiaController.text = currentRow.cells['fantasia']?.value ?? '';
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
			inscricaoEstadualStController.text = currentRow.cells['inscricaoEstadualSt']?.value ?? '';
			inscricaoMunicipalController.text = currentRow.cells['inscricaoMunicipal']?.value ?? '';
			cnaeController.text = currentRow.cells['cnae']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeEmitenteEditPage());
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
	final nomeController = TextEditingController();
	final fantasiaController = TextEditingController();
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
	final inscricaoEstadualStController = TextEditingController();
	final inscricaoMunicipalController = TextEditingController();
	final cnaeController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeEmitenteModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeEmitenteModel.idNfeCabecalho;
		plutoRow.cells['cnpj']?.value = nfeEmitenteModel.cnpj;
		plutoRow.cells['cpf']?.value = nfeEmitenteModel.cpf;
		plutoRow.cells['nome']?.value = nfeEmitenteModel.nome;
		plutoRow.cells['fantasia']?.value = nfeEmitenteModel.fantasia;
		plutoRow.cells['logradouro']?.value = nfeEmitenteModel.logradouro;
		plutoRow.cells['numero']?.value = nfeEmitenteModel.numero;
		plutoRow.cells['complemento']?.value = nfeEmitenteModel.complemento;
		plutoRow.cells['bairro']?.value = nfeEmitenteModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = nfeEmitenteModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = nfeEmitenteModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = nfeEmitenteModel.uf;
		plutoRow.cells['cep']?.value = nfeEmitenteModel.cep;
		plutoRow.cells['codigoPais']?.value = nfeEmitenteModel.codigoPais;
		plutoRow.cells['nomePais']?.value = nfeEmitenteModel.nomePais;
		plutoRow.cells['telefone']?.value = nfeEmitenteModel.telefone;
		plutoRow.cells['inscricaoEstadual']?.value = nfeEmitenteModel.inscricaoEstadual;
		plutoRow.cells['inscricaoEstadualSt']?.value = nfeEmitenteModel.inscricaoEstadualSt;
		plutoRow.cells['inscricaoMunicipal']?.value = nfeEmitenteModel.inscricaoMunicipal;
		plutoRow.cells['cnae']?.value = nfeEmitenteModel.cnae;
		plutoRow.cells['crt']?.value = nfeEmitenteModel.crt;
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
		nfeEmitenteModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeEmitenteModel();
			model.plutoRowToObject(plutoRow);
			nfeEmitenteModelList.add(model);
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
		nomeController.dispose();
		fantasiaController.dispose();
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
		inscricaoEstadualStController.dispose();
		inscricaoMunicipalController.dispose();
		cnaeController.dispose();
		super.onClose();
	}
}