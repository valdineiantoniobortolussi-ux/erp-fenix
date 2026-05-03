import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:compras/app/controller/compra_pedido_controller.dart';
import 'package:compras/app/page/shared_widget/shared_widget_imports.dart';

class CompraPedidoTabPage extends StatelessWidget {
  CompraPedidoTabPage({Key? key}) : super(key: key);
  final compraPedidoController = Get.find<CompraPedidoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          compraPedidoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: compraPedidoController.compraPedidoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Pedido - ${'editing'.tr}'), actions: [
          saveButton(onPressed: compraPedidoController.save),
          cancelAndExitButton(onPressed: compraPedidoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: compraPedidoController.tabController,
                  children: compraPedidoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: compraPedidoController.tabController,
                onTap: compraPedidoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: compraPedidoController.tabItems,
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
