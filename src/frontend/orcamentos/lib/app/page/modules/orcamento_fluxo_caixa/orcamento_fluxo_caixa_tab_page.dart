import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:orcamentos/app/controller/orcamento_fluxo_caixa_controller.dart';
import 'package:orcamentos/app/page/shared_widget/shared_widget_imports.dart';

class OrcamentoFluxoCaixaTabPage extends StatelessWidget {
  OrcamentoFluxoCaixaTabPage({Key? key}) : super(key: key);
  final orcamentoFluxoCaixaController = Get.find<OrcamentoFluxoCaixaController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          orcamentoFluxoCaixaController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: orcamentoFluxoCaixaController.orcamentoFluxoCaixaTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Orçamento - Fluxo de Caixa - ${'editing'.tr}'), actions: [
          saveButton(onPressed: orcamentoFluxoCaixaController.save),
          cancelAndExitButton(onPressed: orcamentoFluxoCaixaController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: orcamentoFluxoCaixaController.tabController,
                  children: orcamentoFluxoCaixaController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: orcamentoFluxoCaixaController.tabController,
                onTap: orcamentoFluxoCaixaController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: orcamentoFluxoCaixaController.tabItems,
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
