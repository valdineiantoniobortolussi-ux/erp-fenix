import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:compras/app/controller/compra_requisicao_controller.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';

class CompraRequisicaoTabPage extends StatelessWidget {
  CompraRequisicaoTabPage({Key? key}) : super(key: key);
  final compraRequisicaoController = Get.find<CompraRequisicaoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          compraRequisicaoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: compraRequisicaoController.compraRequisicaoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Requisição - ${'editing'.tr}'), actions: [
          saveButton(onPressed: compraRequisicaoController.save),
          cancelAndExitButton(onPressed: compraRequisicaoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: compraRequisicaoController.tabController,
                  children: compraRequisicaoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: compraRequisicaoController.tabController,
                onTap: compraRequisicaoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: compraRequisicaoController.tabItems,
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
