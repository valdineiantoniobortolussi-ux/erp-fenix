import 'package:administrativo/app/data/provider/api/empresa_api_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/data/model/model_imports.dart';
import 'package:administrativo/app/data/provider/api/view_controle_acesso_api_provider.dart';
import 'package:administrativo/app/data/provider/api/view_pessoa_usuario_api_provider.dart';
import 'package:administrativo/app/data/provider/drift/view_controle_acesso_drift_provider.dart';
import 'package:administrativo/app/data/provider/drift/view_pessoa_usuario_drift_provider.dart';
import 'package:administrativo/app/data/repository/view_controle_acesso_repository.dart';
import 'package:administrativo/app/data/repository/view_pessoa_usuario_repository.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/message_dialog.dart';
import 'package:administrativo/app/routes/app_routes.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();  
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final cnpjController = TextEditingController();

  final enabledColor = const Color.fromARGB(255, 63, 56, 89);
  final enabledTxt = Colors.white;
  final disabledTxt = Colors.grey;
  final backgroundColor = const Color(0xFF1F1A30);
  
  final _isPasswordShown = true.obs;
  get isPasswordShown => _isPasswordShown.value;
  set isPasswordShown(value) => _isPasswordShown.value = value;  

  Future<void> doLogin() async {
    if (cnpjController.text.isEmpty || cnpjController.text.length < 14) {
      showErrorSnackBar(message: "Informe um CNPJ Válido");
    } else {
      EmpresaApiProvider empresaApiProvider = EmpresaApiProvider();
      Session.empresaSessao = await empresaApiProvider.getEmpresaPorCnpj(cnpjController.text);

      if (Session.empresaSessao != null) {

        ViewPessoaUsuarioRepository viewPessoaUsuarioRepository = ViewPessoaUsuarioRepository(viewPessoaUsuarioApiProvider: ViewPessoaUsuarioApiProvider(), viewPessoaUsuarioDriftProvider: ViewPessoaUsuarioDriftProvider());
        ViewPessoaUsuarioModel viewPessoaUsuarioModel = ViewPessoaUsuarioModel(
          login: emailController.text,
          senha: passwordController.text,
        );
        final result = await viewPessoaUsuarioRepository.doLogin(viewPessoaUsuarioModel: viewPessoaUsuarioModel);
        if (result != null && result.administrador == "S") {
          Session.loggedInUser = result;
          // Popula a lista de controle de acesso
          final viewControleAcessoRepository = ViewControleAcessoRepository(
            viewControleAcessoApiProvider: ViewControleAcessoApiProvider(), 
            viewControleAcessoDriftProvider: ViewControleAcessoDriftProvider()
          );
          final filter = Filter(
            condition: 'eq',
            field: 'id_usuario',
            value: result.idUsuario.toString(),
          );
          Session.accessControlList = await viewControleAcessoRepository.getList(filter: filter);
          Get.offAndToNamed(Routes.homePage);
        } else {
          showErrorSnackBar(message: "login_error".tr);
        } 
        
      }

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
  
}