import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/data/model/model_imports.dart';

class TributPisController extends GetxController {
	// general
	final _dbColumns = TributPisModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = TributPisModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _tributPisModel = TributPisModel().obs;
	TributPisModel get tributPisModel => _tributPisModel.value;
	set tributPisModel(value) => _tributPisModel.value = value ?? TributPisModel();

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
		tributPisModel.cstPis = (tributPisModel.cstPis == null || tributPisModel.cstPis == '') ? '00' : tributPisModel.cstPis;
		tributPisModel.modalidadeBaseCalculo = (tributPisModel.modalidadeBaseCalculo == null || tributPisModel.modalidadeBaseCalculo == '') ? '0-Percentual' : tributPisModel.modalidadeBaseCalculo;
		efdTabela435Controller.text = tributPisModel.efdTabela435 ?? '';
		porcentoBaseCalculoController.text = tributPisModel.porcentoBaseCalculo?.toStringAsFixed(2) ?? '';
		aliquotaPorcentoController.text = tributPisModel.aliquotaPorcento?.toStringAsFixed(2) ?? '';
		aliquotaUnidadeController.text = tributPisModel.aliquotaUnidade?.toStringAsFixed(2) ?? '';
		valorPrecoMaximoController.text = tributPisModel.valorPrecoMaximo?.toStringAsFixed(2) ?? '';
		valorPautaFiscalController.text = tributPisModel.valorPautaFiscal?.toStringAsFixed(2) ?? '';
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