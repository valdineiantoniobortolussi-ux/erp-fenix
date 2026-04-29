import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:cadastros/app/page/grid_columns/grid_columns_imports.dart';
import 'package:cadastros/app/controller/controller_imports.dart';
import 'package:cadastros/app/routes/app_routes.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class VendedorController extends GetxController {
	// general
	final _dbColumns = VendedorModel.dbColumns;
	get dbColumns => _dbColumns;

	final _aliasColumns = VendedorModel.aliasColumns;
	get aliasColumns => _aliasColumns;

	final _vendedorModel = VendedorModel().obs;
	VendedorModel get vendedorModel => _vendedorModel.value;
	set vendedorModel(value) => _vendedorModel.value = value ?? VendedorModel();

	// edit page
	final scrollController = ScrollController();
	final comissaoPerfilModelController = TextEditingController();
	final comissaoController = MoneyMaskedTextController();
	final metaVendaController = MoneyMaskedTextController();

	var scaffoldKey = GlobalKey<ScaffoldState>();
	var formKey = GlobalKey<FormState>();

	final _formWasChanged = false.obs;
	get formWasChanged => _formWasChanged.value;
	set formWasChanged(value) => _formWasChanged.value = value; 

	void callEditPage() {
		comissaoPerfilModelController.text = vendedorModel.comissaoPerfilModel?.nome ?? '';
		comissaoController.text = vendedorModel.comissao?.toStringAsFixed(2) ?? '';
		metaVendaController.text = vendedorModel.metaVenda?.toStringAsFixed(2) ?? '';
	}

	Future callComissaoPerfilLookup() async { 
		final lookupController = Get.find<LookupController>(); 
		lookupController.refreshItems(standardValue: '%'); 
		lookupController.title = '${'lookup_page_title'.tr} [Perfil Comissão]'; 
		lookupController.route = '/comissao-perfil/'; 
		lookupController.gridColumns = comissaoPerfilGridColumns(isForLookup: true); 
		lookupController.aliasColumns = ComissaoPerfilModel.aliasColumns; 
		lookupController.dbColumns = ComissaoPerfilModel.dbColumns; 

		final plutoRowResult = await Get.toNamed(Routes.lookupPage); 
		if (plutoRowResult != null) { 
			vendedorModel.idComissaoPerfil = plutoRowResult.cells['id']!.value; 
			vendedorModel.comissaoPerfilModel!.plutoRowToObject(plutoRowResult); 
			comissaoPerfilModelController.text = vendedorModel.comissaoPerfilModel?.nome ?? ''; 
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
		comissaoPerfilModelController.dispose();
		comissaoController.dispose();
		metaVendaController.dispose();
		super.onClose();
	}

}