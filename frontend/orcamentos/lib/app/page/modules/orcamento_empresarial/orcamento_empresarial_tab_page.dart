import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/controller/orcamento_empresarial_controller.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';

class OrcamentoEmpresarialTabPage extends StatelessWidget {
  OrcamentoEmpresarialTabPage({Key? key}) : super(key: key);
  final orcamentoEmpresarialController = Get.find<OrcamentoEmpresarialController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          orcamentoEmpresarialController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: orcamentoEmpresarialController.orcamentoEmpresarialTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Orçamento - ${'editing'.tr}'), actions: [
          saveButton(onPressed: orcamentoEmpresarialController.save),
          cancelAndExitButton(onPressed: orcamentoEmpresarialController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: orcamentoEmpresarialController.tabController,
                  children: orcamentoEmpresarialController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: orcamentoEmpresarialController.tabController,
                onTap: orcamentoEmpresarialController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: orcamentoEmpresarialController.tabItems,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
