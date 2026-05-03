import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class TransportadoraController extends GetxController {
	// general
	final _dbColumns = TransportadoraModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = TransportadoraModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _transportadoraModel = TransportadoraModel().obs;
	TransportadoraModel get transportadoraModel => _transportadoraModel.value;
	set transportadoraModel(value) => _transportadoraModel.value = value ?? TransportadoraModel();

	// edit page
	final scrollController = ScrollController();
	final observacaoController = TextEditingController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		observacaoController.text = transportadoraModel.observacao ?? '';
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
		observacaoController.dispose();
		super.onClose();
	}

}