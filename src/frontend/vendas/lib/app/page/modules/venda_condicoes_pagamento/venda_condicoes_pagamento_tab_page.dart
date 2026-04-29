import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_condicoes_pagamento_controller.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';

class VendaCondicoesPagamentoTabPage extends StatelessWidget {
  VendaCondicoesPagamentoTabPage({Key? key}) : super(key: key);
  final vendaCondicoesPagamentoController = Get.find<VendaCondicoesPagamentoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          vendaCondicoesPagamentoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: vendaCondicoesPagamentoController.vendaCondicoesPagamentoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Condições de Pagamento - ${'editing'.tr}'), actions: [
          saveButton(onPressed: vendaCondicoesPagamentoController.save),
          cancelAndExitButton(onPressed: vendaCondicoesPagamentoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: vendaCondicoesPagamentoController.tabController,
                  children: vendaCondicoesPagamentoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: vendaCondicoesPagamentoController.tabController,
                onTap: vendaCondicoesPagamentoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: vendaCondicoesPagamentoController.tabItems,
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
