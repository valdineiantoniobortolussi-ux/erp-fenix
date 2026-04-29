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

class MdfeEmitenteController extends GetxController {

	// general
	final gridColumns = mdfeEmitenteGridColumns();
	
	var mdfeEmitenteModelList = <MdfeEmitenteModel>[];

	final _mdfeEmitenteModel = MdfeEmitenteModel().obs;
	MdfeEmitenteModel get mdfeEmitenteModel => _mdfeEmitenteModel.value;
	set mdfeEmitenteModel(value) => _mdfeEmitenteModel.value = value ?? MdfeEmitenteModel();
	
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
		for (var mdfeEmitenteModel in mdfeEmitenteModelList) {
			plutoRowList.add(_getPlutoRow(mdfeEmitenteModel));
		}
		return plutoRowList;
	}

	PlutoRow _getPlutoRow(MdfeEmitenteModel mdfeEmitenteModel) {
		return PlutoRow(
			cells: _getPlutoCells(mdfeEmitenteModel: mdfeEmitenteModel),
		);
	}

	Map<String, PlutoCell> _getPlutoCells({ MdfeEmitenteModel? mdfeEmitenteModel}) {
		return {
			"id": PlutoCell(value: mdfeEmitenteModel?.id ?? 0),
			"nome": PlutoCell(value: mdfeEmitenteModel?.nome ?? ''),
			"fantasia": PlutoCell(value: mdfeEmitenteModel?.fantasia ?? ''),
			"cnpj": PlutoCell(value: mdfeEmitenteModel?.cnpj ?? ''),
			"ie": PlutoCell(value: mdfeEmitenteModel?.ie ?? 0),
			"logradouro": PlutoCell(value: mdfeEmitenteModel?.logradouro ?? ''),
			"numero": PlutoCell(value: mdfeEmitenteModel?.numero ?? ''),
			"complemento": PlutoCell(value: mdfeEmitenteModel?.complemento ?? ''),
			"bairro": PlutoCell(value: mdfeEmitenteModel?.bairro ?? ''),
			"codigoMunicipio": PlutoCell(value: mdfeEmitenteModel?.codigoMunicipio ?? ''),
			"nomeMunicipio": PlutoCell(value: mdfeEmitenteModel?.nomeMunicipio ?? ''),
			"cep": PlutoCell(value: mdfeEmitenteModel?.cep ?? ''),
			"uf": PlutoCell(value: mdfeEmitenteModel?.uf ?? ''),
			"telefone": PlutoCell(value: mdfeEmitenteModel?.telefone ?? ''),
			"email": PlutoCell(value: mdfeEmitenteModel?.email ?? ''),
			"idMdfeCabecalho": PlutoCell(value: mdfeEmitenteModel?.idMdfeCabecalho ?? 0),
		};
	}

	void plutoRowToObject() {
		mdfeEmitenteModel.plutoRowToObject(plutoRow);
	}

	Future loadData() async {
		_plutoGridStateManager.setShowLoading(true);
		_plutoGridStateManager.removeAllRows();
		_plutoGridStateManager.appendRows(plutoRows());
		_plutoGridStateManager.setShowLoading(false);
	}

	Future getList({Filter? filter}) async {
		return mdfeEmitenteModelList;
	}

	void callEditPage() {
		final currentRow = _plutoGridStateManager.currentRow;
		if (currentRow != null) {
			nomeController.text = currentRow.cells['nome']?.value ?? '';
			fantasiaController.text = currentRow.cells['fantasia']?.value ?? '';
			cnpjController.text = currentRow.cells['cnpj']?.value ?? '';
			ieController.text = currentRow.cells['ie']?.value?.toString() ?? '';
			logradouroController.text = currentRow.cells['logradouro']?.value ?? '';
			numeroController.text = currentRow.cells['numero']?.value ?? '';
			complementoController.text = currentRow.cells['complemento']?.value ?? '';
			bairroController.text = currentRow.cells['bairro']?.value ?? '';
			codigoMunicipioController.text = currentRow.cells['codigoMunicipio']?.value ?? '';
			nomeMunicipioController.text = currentRow.cells['nomeMunicipio']?.value ?? '';
			cepController.text = currentRow.cells['cep']?.value ?? '';
			telefoneController.text = currentRow.cells['telefone']?.value ?? '';
			emailController.text = currentRow.cells['email']?.value ?? '';
			plutoRow = currentRow;
			formWasChanged = false;
			plutoRowToObject();
			Get.to(() => MdfeEmitenteEditPage());
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
	final fantasiaController = TextEditingController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final ieController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final bairroController = TextEditingController();
	final codigoMunicipioController = TextEditingController();
	final nomeMunicipioController = TextEditingController();
	final cepController = MaskedTextController(mask: '00000-000',);
	final telefoneController = MaskedTextController(mask: '(00)00000-0000',);
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
		plutoRow.cells['id']?.value = mdfeEmitenteModel.id;
		plutoRow.cells['idMdfeCabecalho']?.value = mdfeEmitenteModel.idMdfeCabecalho;
		plutoRow.cells['nome']?.value = mdfeEmitenteModel.nome;
		plutoRow.cells['fantasia']?.value = mdfeEmitenteModel.fantasia;
		plutoRow.cells['cnpj']?.value = mdfeEmitenteModel.cnpj;
		plutoRow.cells['ie']?.value = mdfeEmitenteModel.ie;
		plutoRow.cells['logradouro']?.value = mdfeEmitenteModel.logradouro;
		plutoRow.cells['numero']?.value = mdfeEmitenteModel.numero;
		plutoRow.cells['complemento']?.value = mdfeEmitenteModel.complemento;
		plutoRow.cells['bairro']?.value = mdfeEmitenteModel.bairro;
		plutoRow.cells['codigoMunicipio']?.value = mdfeEmitenteModel.codigoMunicipio;
		plutoRow.cells['nomeMunicipio']?.value = mdfeEmitenteModel.nomeMunicipio;
		plutoRow.cells['cep']?.value = mdfeEmitenteModel.cep;
		plutoRow.cells['uf']?.value = mdfeEmitenteModel.uf;
		plutoRow.cells['telefone']?.value = mdfeEmitenteModel.telefone;
		plutoRow.cells['email']?.value = mdfeEmitenteModel.email;
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
		mdfeEmitenteModelList.clear();
		for (var plutoRow in _plutoGridStateManager.rows) {
			var model = MdfeEmitenteModel();
			model.plutoRowToObject(plutoRow);
			mdfeEmitenteModelList.add(model);
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
		fantasiaController.dispose();
		cnpjController.dispose();
		ieController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		bairroController.dispose();
		codigoMunicipioController.dispose();
		nomeMunicipioController.dispose();
		cepController.dispose();
		telefoneController.dispose();
		emailController.dispose();
		super.onClose();
	}
}