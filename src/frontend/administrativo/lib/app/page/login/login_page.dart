import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/controller/login_controller.dart';
import 'package:administrativo/app/page/login/widget/login_widget_imports.dart';

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
      // ForgotPasswordButton(),
      // const SizedBox(height: 10),
      // Visibility(
      //   visible: !Session.empresaComPlanoAtivo
      //   child: LoginOuterCard(
      //     textLabel: 'plan_upgrade_message'.tr,
      //     textButton: 'plan_upgrade_button'.tr,
      //     function: () async {
      //       controller.callPaymentPage();
      //     },
      //   ),
      // ),
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
      LoginInputCnpj(),
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
