import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributCofinsController extends GetxController {
	// general
	final _dbColumns = TributCofinsModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = TributCofinsModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _tributCofinsModel = TributCofinsModel().obs;
	TributCofinsModel get tributCofinsModel => _tributCofinsModel.value;
	set tributCofinsModel(value) => _tributCofinsModel.value = value ?? TributCofinsModel();

	// edit page
	final scrollController = ScrollController();
	final efdTabela435Controller = TextEditingController();
	final porcentoBaseCalculoController = MoneyMaskedTextController();
	final aliquotaPorcentoController = MoneyMaskedTextController();
	final aliquotaUnidadeController = MoneyMaskedTextController();
	final valorPrecoMaximoController = MoneyMaskedTextController();
	final valorPautaFiscalController = MoneyMaskedTextController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		tributCofinsModel.cstCofins = (tributCofinsModel.cstCofins == null || tributCofinsModel.cstCofins == '') ? '00' : tributCofinsModel.cstCofins;
		tributCofinsModel.modalidadeBaseCalculo = (tributCofinsModel.modalidadeBaseCalculo == null || tributCofinsModel.modalidadeBaseCalculo == '') ? '0-Percentual' : tributCofinsModel.modalidadeBaseCalculo;
		efdTabela435Controller.text = tributCofinsModel.efdTabela435 ?? '';
		porcentoBaseCalculoController.text = tributCofinsModel.porcentoBaseCalculo?.toStringAsFixed(2) ?? '';
		aliquotaPorcentoController.text = tributCofinsModel.aliquotaPorcento?.toStringAsFixed(2) ?? '';
		aliquotaUnidadeController.text = tributCofinsModel.aliquotaUnidade?.toStringAsFixed(2) ?? '';
		valorPrecoMaximoController.text = tributCofinsModel.valorPrecoMaximo?.toStringAsFixed(2) ?? '';
		valorPautaFiscalController.text = tributCofinsModel.valorPautaFiscal?.toStringAsFixed(2) ?? '';
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
		efdTabela435Controller.dispose();
		porcentoBaseCalculoController.dispose();
		aliquotaPorcentoController.dispose();
		aliquotaUnidadeController.dispose();
		valorPrecoMaximoController.dispose();
		valorPautaFiscalController.dispose();
		super.onClose();
	}

}