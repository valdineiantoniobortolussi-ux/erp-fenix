import 'dart:async';

import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:inventario/app/data/model/model_imports.dart';
import 'package:inventario/app/data/provider/api/empresa_api_provider.dart';

import 'package:inventario/app/infra/infra_imports.dart';
import 'package:inventario/app/page/shared_widget/message_dialog.dart';

class PaymentController extends GetxController {
  PaymentController();

  final scrollController = ScrollController();
  final formKey = GlobalKey<FormState>();	

  // textbox controllers
	final razaoSocialController = TextEditingController();
	final nomeFantasiaController = TextEditingController();
	final cnpjController = MaskedTextController(mask: '00.000.000/0000-00',);
	final emailController = TextEditingController();
	final logradouroController = TextEditingController();
	final numeroController = TextEditingController();
	final complementoController = TextEditingController();
	final cepController = MaskedTextController(mask: '00000-000',);
	final bairroController = TextEditingController();
	final cidadeController = TextEditingController();
	final foneController = MaskedTextController(mask: '(00)00000-0000',);
	final ufController = TextEditingController();

  final _formWasChanged = false.obs;
  get formWasChanged => _formWasChanged.value;
  set formWasChanged(value) => _formWasChanged.value = value; 

  void preventDataLoss() {
    if (formWasChanged) {
      showQuestionDialog('message_data_loss'.tr, () => Get.back());
    } else {
      Get.back();
    }
  }  

  Future contratarPlano(ErpTipoPlanoModel planModel) async {
    // TODO: implemente o controle de pagamento de acordo com sua necessidade - use o controle de pagamento do Pegasus PDV como base
    final FormState form = formKey.currentState!;
    if (!form.validate()) {
      showErrorSnackBar(message: 'validator_form_message'.tr);
    } else {
      showQuestionDialog('Deseja contratar o plano selecionado?', () async {
        EmpresaModel empresaModel = EmpresaModel(
          razaoSocial: razaoSocialController.text,
          nomeFantasia: nomeFantasiaController.text,
          cnpj: cnpjController.text,
          email: emailController.text,
          logradouro: logradouroController.text,
          numero: numeroController.text,
          complemento: complementoController.text,
          cep: cepController.text,
          bairro: bairroController.text,
          cidade: cidadeController.text,
          fone: foneController.text,
          uf: ufController.text
        );
        EmpresaApiProvider empresaApiProvider = EmpresaApiProvider();
        await empresaApiProvider.registrar(empresaModel);

        await Session.confirmarEmpresaPlanoAtivo();
        await Session.verificarEmpresaPlanoAtivo();
        Get.back();
        Get.forceAppUpdate();
      });
    }    
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
		razaoSocialController.dispose();
		nomeFantasiaController.dispose();
		cnpjController.dispose();
		emailController.dispose();
		logradouroController.dispose();
		numeroController.dispose();
		complementoController.dispose();
		cepController.dispose();
		bairroController.dispose();
		cidadeController.dispose();
		foneController.dispose();
		ufController.dispose();

    scrollController.dispose(); 
    super.onClose();
  }
}