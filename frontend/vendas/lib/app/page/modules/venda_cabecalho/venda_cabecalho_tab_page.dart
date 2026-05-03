import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:vendas/app/controller/venda_cabecalho_controller.dart';
import 'package:vendas/app/page/shared_widget/shared_widget_imports.dart';

class VendaCabecalhoTabPage extends StatelessWidget {
  VendaCabecalhoTabPage({Key? key}) : super(key: key);
  final vendaCabecalhoController = Get.find<VendaCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          vendaCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: vendaCabecalhoController.vendaCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Venda - ${'editing'.tr}'), actions: [
          saveButton(onPressed: vendaCabecalhoController.save),
          cancelAndExitButton(onPressed: vendaCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: vendaCabecalhoController.tabController,
                  children: vendaCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: vendaCabecalhoController.tabController,
                onTap: vendaCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: vendaCabecalhoController.tabItems,
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
