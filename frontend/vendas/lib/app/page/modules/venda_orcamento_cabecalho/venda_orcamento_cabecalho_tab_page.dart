import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_orcamento_cabecalho_controller.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';

class VendaOrcamentoCabecalhoTabPage extends StatelessWidget {
  VendaOrcamentoCabecalhoTabPage({Key? key}) : super(key: key);
  final vendaOrcamentoCabecalhoController = Get.find<VendaOrcamentoCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          vendaOrcamentoCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: vendaOrcamentoCabecalhoController.vendaOrcamentoCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Orçamento de Venda - ${'editing'.tr}'), actions: [
          saveButton(onPressed: vendaOrcamentoCabecalhoController.save),
          cancelAndExitButton(onPressed: vendaOrcamentoCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: vendaOrcamentoCabecalhoController.tabController,
                  children: vendaOrcamentoCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: vendaOrcamentoCabecalhoController.tabController,
                onTap: vendaOrcamentoCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: vendaOrcamentoCabecalhoController.tabItems,
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
