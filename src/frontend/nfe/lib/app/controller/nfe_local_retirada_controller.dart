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

class NfeLocalRetiradaController extends GetxController {

	// general
	final gridColumns = nfeLocalRetiradaGridColumns();
	
	var nfeLocalRetiradaModelList = <NfeLocalRetiradaModel>[];

	final _nfeLocalRetiradaModel = NfeLocalRetiradaModel().obs;
	NfeLocalRetiradaModel get nfeLocalRetiradaModel => _nfeLocalRetiradaModel.value;
	set nfeLocalRetiradaModel(value) => _nfeLocalRetiradaModel.value = value ?? NfeLocalRetiradaModel();
	
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
		for (var nfeLocalRetiradaModel in nfeLocalRetiradaModelList) {
			plutoRowList.add(_getPlutoRow(nfeLocalRetiradaModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(NfeLocalRetiradaModel nfeLocalRetiradaModel) {
		return PlutoRow(
			cells: _getPlutoCells(nfeLocalRetiradaModel: nfeLocalRetiradaModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ NfeLocalRetiradaModel? nfeLocalRetiradaModel}) {
		return {
			"id": PlutoCell(value: nfeLocalRetiradaModel?.id ?? 0),
			"cnpj": PlutoCell(value: nfeLocalRetiradaModel?.cnpj ?? ''),
			"cpf": PlutoCell(value: nfeLocalRetiradaModel?.cpf ?? ''),
			"nomeExpedidor": PlutoCell(value: nfeLocalRetiradaModel?.nomeExpedidor ?? ''),
			"logradouro": PlutoCell(value: nfeLocalRetiradaModel?.logradouro ?? ''),
			"numero": PlutoCell(value: nfeLocalRetiradaModel?.numero ?? ''),
			"complemento": PlutoCell(value: nfeLocalRetiradaModel?.complemento ?? ''),
			"bairro": PlutoCell(value: nfeLocalRetiradaModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: nfeLocalRetiradaModel?.codigoMunicipio ?? 0),
			"nomeMunicipio": PlutoCell(value: nfeLocalRetiradaModel?.nomeMunicipio ?? ''),
			"uf": PlutoCell(value: nfeLocalRetiradaModel?.uf ?? ''),
			"cep": PlutoCell(value: nfeLocalRetiradaModel?.cep ?? ''),
			"codigoPais": PlutoCell(value: nfeLocalRetiradaModel?.codigoPais ?? 0),
			"nomePais": PlutoCell(value: nfeLocalRetiradaModel?.nomePais ?? ''),
			"telefone": PlutoCell(value: nfeLocalRetiradaModel?.telefone ?? ''),
			"email": PlutoCell(value: nfeLocalRetiradaModel?.email ?? ''),
			"inscricaoEstadual": PlutoCell(value: nfeLocalRetiradaModel?.inscricaoEstadual ?? ''),
			"idNfeCabecalho": PlutoCell(value: nfeLocalRetiradaModel?.idNfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		nfeLocalRetiradaModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return nfeLocalRetiradaModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			cpfController.text = currentRow.cells['cpf']?.value ?? '';
			nomeExpedidorController.text = currentRow.cells['nomeExpedidor']?.value ?? '';
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
			Get.to(() => NfeLocalRetiradaEditPage());
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
	final nomeExpedidorController = TextEditingController();
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
		plutoRow.cells['id']?.value = nfeLocalRetiradaModel.id;
		plutoRow.cells['idNfeCabecalho']?.value = nfeLocalRetiradaModel.idNfeCabecalho;
		plutoRow.cells['cnpj']?.value = nfeLocalRetiradaModel.cnpj;
		plutoRow.cells['cpf']?.value = nfeLocalRetiradaModel.cpf;
		plutoRow.cells['nomeExpedidor']?.value = nfeLocalRetiradaModel.nomeExpedidor;
		plutoRow.cells['logradouro']?.value = nfeLocalRetiradaModel.logradouro;
		plutoRow.cells['numero']?.value = nfeLocalRetiradaModel.numero;
		plutoRow.cells['complemento']?.value = nfeLocalRetiradaModel.complemento;
		plutoRow.cells['bairro']?.value = nfeLocalRetiradaModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = nfeLocalRetiradaModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = nfeLocalRetiradaModel.nomeMunicipio;
		plutoRow.cells['uf']?.value = nfeLocalRetiradaModel.uf;
		plutoRow.cells['cep']?.value = nfeLocalRetiradaModel.cep;
		plutoRow.cells['codigoPais']?.value = nfeLocalRetiradaModel.codigoPais;
		plutoRow.cells['nomePais']?.value = nfeLocalRetiradaModel.nomePais;
		plutoRow.cells['telefone']?.value = nfeLocalRetiradaModel.telefone;
		plutoRow.cells['email']?.value = nfeLocalRetiradaModel.email;
		plutoRow.cells['inscricaoEstadual']?.value = nfeLocalRetiradaModel.inscricaoEstadual;
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
		nfeLocalRetiradaModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = NfeLocalRetiradaModel();
			model.plutoRowToObject(plutoRow);
			nfeLocalRetiradaModelList.add(model);
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
		nomeExpedidorController.dispose();
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