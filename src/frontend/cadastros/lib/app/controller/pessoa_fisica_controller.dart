import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/routes/app_routes.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class PessoaFisicaController extends GetxController {
	// general
	final _dbColumns = PessoaFisicaModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = PessoaFisicaModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _pessoaFisicaModel = PessoaFisicaModel().obs;
	PessoaFisicaModel get pessoaFisicaModel => _pessoaFisicaModel.value;
	set pessoaFisicaModel(value) => _pessoaFisicaModel.value = value ?? PessoaFisicaModel();

	// edit page
	final scrollController = ScrollController();
	final nivelFormacaoModelController = TextEditingController();
	final estadoCivilModelController = TextEditingController();
	final cpfController = MaskedTextController(mask: '000.000.000-00',);
	final rgController = TextEditingController();
	final orgaoRgController = TextEditingController();
	final nacionalidadeController = TextEditingController();
	final naturalidadeController = TextEditingController();
	final nomePaiController = TextEditingController();
	final nomeMaeController = TextEditingController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		nivelFormacaoModelController.text = pessoaFisicaModel.nivelFormacaoModel?.nome ?? '';
		estadoCivilModelController.text = pessoaFisicaModel.estadoCivilModel?.nome ?? '';
		cpfController.text = pessoaFisicaModel.cpf ?? '';
		rgController.text = pessoaFisicaModel.rg ?? '';
		orgaoRgController.text = pessoaFisicaModel.orgaoRg ?? '';
		pessoaFisicaModel.sexo = (pessoaFisicaModel.sexo == null || pessoaFisicaModel.sexo == '') ? 'Masculino' : pessoaFisicaModel.sexo;
		pessoaFisicaModel.raca = (pessoaFisicaModel.raca == null || pessoaFisicaModel.raca == '') ? 'Branco' : pessoaFisicaModel.raca;
		nacionalidadeController.text = pessoaFisicaModel.nacionalidade ?? '';
		naturalidadeController.text = pessoaFisicaModel.naturalidade ?? '';
		nomePaiController.text = pessoaFisicaModel.nomePai ?? '';
		nomeMaeController.text = pessoaFisicaModel.nomeMae ?? '';
	}

	Future callNivelFormacaoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Nivel Formacao]'; 
		lookupController.route = '/nivel-formacao/'; 
		lookupController.gridColumns = nivelFormacaoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = NivelFormacaoModel.aliasColumns; 
		lookupController.dbColumns = NivelFormacaoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pessoaFisicaModel.idNivelFormacao = plutoRowResult.cells['id']!.value; 
			pessoaFisicaModel.nivelFormacaoModel!.plutoRowToObject(plutoRowResult); 
			nivelFormacaoModelController.text = pessoaFisicaModel.nivelFormacaoModel?.nome ?? ''; 
			formWasChanged = true; 
		}
	}

	Future callEstadoCivilLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Estado Civil]'; 
		lookupController.route = '/estado-civil/'; 
		lookupController.gridColumns = estadoCivilGridColumns(isForLookup: true); 
		lookupController.aliasColumns = EstadoCivilModel.aliasColumns; 
		lookupController.dbColumns = EstadoCivilModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			pessoaFisicaModel.idEstadoCivil = plutoRowResult.cells['id']!.value; 
			pessoaFisicaModel.estadoCivilModel!.plutoRowToObject(plutoRowResult); 
			estadoCivilModelController.text = pessoaFisicaModel.estadoCivilModel?.nome ?? ''; 
			formWasChanged = true; 
		}
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
		nivelFormacaoModelController.dispose();
		estadoCivilModelController.dispose();
		cpfController.dispose();
		rgController.dispose();
		orgaoRgController.dispose();
		nacionalidadeController.dispose();
		naturalidadeController.dispose();
		nomePaiController.dispose();
		nomeMaeController.dispose();
		super.onClose();
	}

}