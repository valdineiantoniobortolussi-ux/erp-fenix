import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributIpiController extends GetxController {
	// general
	final _dbColumns = TributIpiModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = TributIpiModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _tributIpiModel = TributIpiModel().obs;
	TributIpiModel get tributIpiModel => _tributIpiModel.value;
	set tributIpiModel(value) => _tributIpiModel.value = value ?? TributIpiModel();

	// edit page
	final scrollController = ScrollController();
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
		tributIpiModel.cstIpi = (tributIpiModel.cstIpi == null || tributIpiModel.cstIpi == '') ? '00' : tributIpiModel.cstIpi;
		tributIpiModel.modalidadeBaseCalculo = (tributIpiModel.modalidadeBaseCalculo == null || tributIpiModel.modalidadeBaseCalculo == '') ? '0-Percentual' : tributIpiModel.modalidadeBaseCalculo;
		porcentoBaseCalculoController.text = tributIpiModel.porcentoBaseCalculo?.toStringAsFixed(2) ?? '';
		aliquotaPorcentoController.text = tributIpiModel.aliquotaPorcento?.toStringAsFixed(2) ?? '';
		aliquotaUnidadeController.text = tributIpiModel.aliquotaUnidade?.toStringAsFixed(2) ?? '';
		valorPrecoMaximoController.text = tributIpiModel.valorPrecoMaximo?.toStringAsFixed(2) ?? '';
		valorPautaFiscalController.text = tributIpiModel.valorPautaFiscal?.toStringAsFixed(2) ?? '';
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
		porcentoBaseCalculoController.dispose();
		aliquotaPorcentoController.dispose();
		aliquotaUnidadeController.dispose();
		valorPrecoMaximoController.dispose();
		valorPautaFiscalController.dispose();
		super.onClose();
	}

}