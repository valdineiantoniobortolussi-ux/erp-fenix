import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class PessoaJuridicaController extends GetxController {
	// general
	final _dbColumns = PessoaJuridicaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PessoaJuridicaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _pessoaJuridicaModel = PessoaJuridicaModel().obs;
	PessoaJuridicaModel get pessoaJuridicaModel => _pessoaJuridicaModel.value;
	set pessoaJuridicaModel(value) => _pessoaJuridicaModel.value = value ?? PessoaJuridicaModel();

	// edit page
	final scrollController = ScrollController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final nomeFantasiaController = TextEditingController();
	final inscricaoEstadualController = TextEditingController();
	final inscricaoMunicipalController = TextEditingController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		cnpjController.text = pessoaJuridicaModel.cnpj ?? '';
		nomeFantasiaController.text = pessoaJuridicaModel.nomeFantasia ?? '';
		inscricaoEstadualController.text = pessoaJuridicaModel.inscricaoEstadual ?? '';
		inscricaoMunicipalController.text = pessoaJuridicaModel.inscricaoMunicipal ?? '';
		pessoaJuridicaModel.tipoRegime = (pessoaJuridicaModel.tipoRegime == null || pessoaJuridicaModel.tipoRegime == '') ? '1-Lucro Real' : pessoaJuridicaModel.tipoRegime;
		pessoaJuridicaModel.crt = (pessoaJuridicaModel.crt == null || pessoaJuridicaModel.crt == '') ? '1-Simples Nacional' : pessoaJuridicaModel.crt;
	}


	bool validateForm() {
		return true;
	}

	// override
	@override
	void onInit() {
		bootstrapGridParameters(
			gutterSize: Constants.flutterBootstrapGutterSize,
		);
		super.onInit();
	}

	@override
	void onClose() {
		scrollController.dispose(); 	
		cnpjController.dispose();
		nomeFantasiaController.dispose();
		inscricaoEstadualController.dispose();
		inscricaoMunicipalController.dispose();
		super.onClose();
	}

}