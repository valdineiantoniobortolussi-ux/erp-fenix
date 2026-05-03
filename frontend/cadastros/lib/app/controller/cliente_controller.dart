import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/routes/app_routes.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class ClienteController extends GetxController {
	// general
	final _dbColumns = ClienteModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = ClienteModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _clienteModel = ClienteModel().obs;
	ClienteModel get clienteModel => _clienteModel.value;
	set clienteModel(value) => _clienteModel.value = value ?? ClienteModel();

	// edit page
	final scrollController = ScrollController();
	final tabelaPrecoModelController = TextEditingController();
	final taxaDescontoController = MoneyMaskedTextController();
	final limiteCreditoController = MoneyMaskedTextController();
	final observacaoController = TextEditingController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		tabelaPrecoModelController.text = clienteModel.tabelaPrecoModel?.nome ?? '';
		taxaDescontoController.text = clienteModel.taxaDesconto?.toStringAsFixed(2) ?? '';
		limiteCreditoController.text = clienteModel.limiteCredito?.toStringAsFixed(2) ?? '';
		observacaoController.text = clienteModel.observacao ?? '';
	}

	Future callTabelaPrecoLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Tabela Preco]'; 
		lookupController.route = '/tabela-preco/'; 
		lookupController.gridColumns = tabelaPrecoGridColumns(isForLookup: true); 
		lookupController.aliasColumns = TabelaPrecoModel.aliasColumns; 
		lookupController.dbColumns = TabelaPrecoModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			clienteModel.idTabelaPreco = plutoRowResult.cells['id']!.value; 
			clienteModel.tabelaPrecoModel!.plutoRowToObject(plutoRowResult); 
			tabelaPrecoModelController.text = clienteModel.tabelaPrecoModel?.nome ?? ''; 
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
		tabelaPrecoModelController.dispose();
		taxaDescontoController.dispose();
		limiteCreditoController.dispose();
		observacaoController.dispose();
		super.onClose();
	}

}