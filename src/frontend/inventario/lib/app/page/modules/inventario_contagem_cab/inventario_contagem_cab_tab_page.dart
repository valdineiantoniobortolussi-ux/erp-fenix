import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:inventario/app/controller/inventario_contagem_cab_controller.dart';
import 'package:inventario/app/page/shared_widget/shared_widget_imports.dart';

class InventarioContagemCabTabPage extends StatelessWidget {
  InventarioContagemCabTabPage({Key? key}) : super(key: key);
  final inventarioContagemCabController = Get.find<InventarioContagemCabController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          inventarioContagemCabController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: inventarioContagemCabController.inventarioContagemCabTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Contagem de Produtos - ${'editing'.tr}'), actions: [
          saveButton(onPressed: inventarioContagemCabController.save),
          cancelAndExitButton(onPressed: inventarioContagemCabController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: inventarioContagemCabController.tabController,
                  children: inventarioContagemCabController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: inventarioContagemCabController.tabController,
                onTap: inventarioContagemCabController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: inventarioContagemCabController.tabItems,
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
