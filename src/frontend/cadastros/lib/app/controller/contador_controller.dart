import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ContadorController extends GetxController {
	// general
	final _dbColumns = ContadorModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ContadorModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _contadorModel = ContadorModel().obs;
	ContadorModel get contadorModel => _contadorModel.value;
	set contadorModel(value) => _contadorModel.value = value ?? ContadorModel();

	// edit page
	final scrollController = ScrollController();
	final crcInscricaoController = TextEditingController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		crcInscricaoController.text = contadorModel.crcInscricao ?? '';
		contadorModel.crcUf = (contadorModel.crcUf == null || contadorModel.crcUf == '') ? 'AC' : contadorModel.crcUf;
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
		crcInscricaoController.dispose();
		super.onClose();
	}

}