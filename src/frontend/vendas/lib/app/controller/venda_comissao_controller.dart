import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:vendas/app/page/grid_columns/grid_columns_imports.dart';
import 'package:vendas/app/controller/controller_imports.dart';
import 'package:vendas/app/routes/app_routes.dart';

import 'package:vendas/app/infra/infra_imports.dart';
import 'package:vendas/app/data/model/model_imports.dart';

class VendaComissaoController extends GetxController {
	// general
	final _dbColumns = VendaComissaoModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = VendaComissaoModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _vendaComissaoModel = VendaComissaoModel().obs;
	VendaComissaoModel get vendaComissaoModel => _vendaComissaoModel.value;
	set vendaComissaoModel(value) => _vendaComissaoModel.value = value ?? VendaComissaoModel();

	// edit page
	final scrollController = ScrollController();
	final viewPessoaVendedorModelController = TextEditingController();
	final valorVendaController = MoneyMaskedTextController();
	final valorComissaoController = MoneyMaskedTextController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		viewPessoaVendedorModelController.text = vendaComissaoModel.viewPessoaVendedorModel?.nome ?? '';
		valorVendaController.text = vendaComissaoModel.valorVenda?.toStringAsFixed(2) ?? '';
		vendaComissaoModel.tipoContabil = (vendaComissaoModel.tipoContabil == null || vendaComissaoModel.tipoContabil == '') ? 'Crédito' : vendaComissaoModel.tipoContabil;
		valorComissaoController.text = vendaComissaoModel.valorComissao?.toStringAsFixed(2) ?? '';
		vendaComissaoModel.situacao = (vendaComissaoModel.situacao == null || vendaComissaoModel.situacao == '') ? 'Aberto' : vendaComissaoModel.situacao;
	}

	Future callViewPessoaVendedorLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Id Vendedor]'; 
		lookupController.route = '/view-pessoa-vendedor/'; 
		lookupController.gridColumns = viewPessoaVendedorGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ViewPessoaVendedorModel.aliasColumns; 
		lookupController.dbColumns = ViewPessoaVendedorModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendaComissaoModel.idVendedor = plutoRowResult.cells['id']!.value; 
			vendaComissaoModel.viewPessoaVendedorModel!.plutoRowToObject(plutoRowResult); 
			viewPessoaVendedorModelController.text = vendaComissaoModel.viewPessoaVendedorModel?.nome ?? ''; 
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
		viewPessoaVendedorModelController.dispose();
		valorVendaController.dispose();
		valorComissaoController.dispose();
		super.onClose();
	}

}