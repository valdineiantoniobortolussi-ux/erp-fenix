import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class FornecedorController extends GetxController {
	// general
	final _dbColumns = FornecedorModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = FornecedorModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _fornecedorModel = FornecedorModel().obs;
	FornecedorModel get fornecedorModel => _fornecedorModel.value;
	set fornecedorModel(value) => _fornecedorModel.value = value ?? FornecedorModel();

	// edit page
	final scrollController = ScrollController();
	final observacaoController = TextEditingController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		observacaoController.text = fornecedorModel.observacao ?? '';
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