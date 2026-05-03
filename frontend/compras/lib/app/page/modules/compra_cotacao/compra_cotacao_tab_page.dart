import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:compras/app/controller/compra_cotacao_controller.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';

class CompraCotacaoTabPage extends StatelessWidget {
  CompraCotacaoTabPage({Key? key}) : super(key: key);
  final compraCotacaoController = Get.find<CompraCotacaoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          compraCotacaoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: compraCotacaoController.compraCotacaoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Cotação - ${'editing'.tr}'), actions: [
          saveButton(onPressed: compraCotacaoController.save),
          cancelAndExitButton(onPressed: compraCotacaoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: compraCotacaoController.tabController,
                  children: compraCotacaoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: compraCotacaoController.tabController,
                onTap: compraCotacaoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: compraCotacaoController.tabItems,
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
