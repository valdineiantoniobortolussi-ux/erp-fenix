import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nfe/app/controller/login_controller.dart';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/page/login/widget/login_widget_imports.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginScaffold(scaffoldChildren: _scaffoldChildren());
  }

  List<Widget> _scaffoldChildren() {
    return [
      LoginCenterCard(centerCardChildren: _centerCardChildren()),
      const SizedBox(height: 10),
      ForgotPasswordButton(),
      const SizedBox(height: 10),
      Visibility(
        visible: !Session.empresaComPlanoAtivo, // só vai mostrar a opção de contratação do plano caso a empresa não tenha plano ativo
        child: LoginOuterCard(
          textLabel: 'plan_upgrade_message'.tr,
          textButton: 'plan_upgrade_button'.tr,
          function: () async {
            controller.callPaymentPage();
          },
        ),
      ),
    ];
  }

  List<Widget> _centerCardChildren() {
    return [
      const LoginImage(),
      const SizedBox(
        height: 10,
      ),
      LoginLabel(label: 'login_please_signin'.tr),
      const SizedBox(
        height: 20,
      ),
      LoginInputEmail(),
      const SizedBox(
        height: 20,
      ),
      LoginInputPassword(),
      const SizedBox(
        height: 20,
      ),
      LoginButton(text: 'login'.tr, function: () async {
        await controller.doLogin();
      }),
    ];
  }
}
