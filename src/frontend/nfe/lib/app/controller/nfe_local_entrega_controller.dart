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

class NfeLocalEntregaController extends GetxController {

	// general
	final gridColumns = nfeLocalEntregaGridColumns();
	
	var nfeLocalEntregaModelList = <NfeLocalEntregaModel>[];

	final _nfeLocalEntregaModel = NfeLocalEntregaModel().obs;
	NfeLocalEntregaModel get nfeLocalEntregaModel => _nfeLocalEntregaModel.value;
	set nfeLocalEntregaModel(value) => _nfeLocalEntregaModel.value = value ?? NfeLocalEntregaModel();
	
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
		for (var nfeLocalEntregaModel in nfeLocalEntregaModelList) {
			plutoRowList.add(_getPlutoRow(nfeLocalEntregaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeLocalEntregaModel nfeLocalEntregaModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeLocalEntregaModel: nfeLocalEntregaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeLocalEntregaModel? nfeLocalEntregaModel}) {
		return {
			"id": PlutoCell(value: nfeLocalEntregaModel?.id ?? 0),
			"cnpj": PlutoCell(value: nfeLocalEntregaModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: nfeLocalEntregaModel?.cpf ?? ''),
			"nomeRecebedor": PlutoCell(value: nfeLocalEntregaModel?.nomeRecebedor ?? ''),
			"logradouro": PlutoCell(value: nfeLocalEntregaModel?.logradouro ?? ''),
			"numero": PlutoCell(value: nfeLocalEntregaModel?.numero ?? ''),
			"complemento": PlutoCell(value: nfeLocalEntregaModel?.complemento ?? ''),
			"bairro": PlutoCell(value: nfeLocalEntregaModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: nfeLocalEntregaModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: nfeLocalEntregaModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: nfeLocalEntregaModel?.uf ?? ''),
			"cep": PlutoCell(value: nfeLocalEntregaModel?.cep ?? ''),
			"codigoPais": PlutoCell(value: nfeLocalEntregaModel?.codigoPais ?? 0),
			"nomePais": PlutoCell(value: nfeLocalEntregaModel?.nomePais ?? ''),
			"telefone": PlutoCell(value: nfeLocalEntregaModel?.telefone ?? ''),
			"email": PlutoCell(value: nfeLocalEntregaModel?.email ?? ''),
			"inscricaoEstadual": PlutoCell(value: nfeLocalEntregaModel?.inscricaoEstadual ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeLocalEntregaModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeLocalEntregaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeLocalEntregaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			nomeRecebedorController.text = currentRow.cells['nomeRecebedor']?.value ?? '';
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
			emailController.text = currentRow.cells['email']?.value ?? '';
			inscricaoEstadualController.text = currentRow.cells['inscricaoEstadual']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => NfeLocalEntregaEditPage());
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
	final nomeRecebedorController = TextEditingController();
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
	final emailController = TextEditingController();
	final inscricaoEstadualController = TextEditingController();

	final scaffoldKey = GlobalKey<ScaffoldState>();
	final formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	final _userMadeChanges = false.obs;
	get userMadeChanges => _userMadeChanges.value;
	set userMadeChanges(value) => _userMadeChanges.value = value; 

	void objectToPlutoRow() {
		plutoRow.cells['id']?.value = nfeLocalEntregaModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeLocalEntregaModel.idNfeCabecalho;
		plutoRow.cells['cnpj']?.value = nfeLocalEntregaModel.cnpj;
		plutoRow.cells['cpf']?.value = nfeLocalEntregaModel.cpf;
		plutoRow.cells['nomeRecebedor']?.value = nfeLocalEntregaModel.nomeRecebedor;
		plutoRow.cells['logradouro']?.value = nfeLocalEntregaModel.logradouro;
		plutoRow.cells['numero']?.value = nfeLocalEntregaModel.numero;
		plutoRow.cells['complemento']?.value = nfeLocalEntregaModel.complemento;
		plutoRow.cells['bairro']?.value = nfeLocalEntregaModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = nfeLocalEntregaModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = nfeLocalEntregaModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = nfeLocalEntregaModel.uf;
		plutoRow.cells['cep']?.value = nfeLocalEntregaModel.cep;
		plutoRow.cells['codigoPais']?.value = nfeLocalEntregaModel.codigoPais;
		plutoRow.cells['nomePais']?.value = nfeLocalEntregaModel.nomePais;
		plutoRow.cells['telefone']?.value = nfeLocalEntregaModel.telefone;
		plutoRow.cells['email']?.value = nfeLocalEntregaModel.email;
		plutoRow.cells['inscricaoEstadual']?.value = nfeLocalEntregaModel.inscricaoEstadual;
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
		nfeLocalEntregaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeLocalEntregaModel();
			model.plutoRowToObject(plutoRow);
			nfeLocalEntregaModelList.add(model);
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
		nomeRecebedorController.dispose();
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
		emailController.dispose();
		inscricaoEstadualController.dispose();
		super.onClose();
	}
}