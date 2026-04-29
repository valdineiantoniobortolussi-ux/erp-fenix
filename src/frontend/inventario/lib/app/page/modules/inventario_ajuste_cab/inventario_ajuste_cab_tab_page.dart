import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:inventario/app/controller/inventario_ajuste_cab_controller.dart';
import 'package:inventario/app/page/shared_widget/shared_widget_imports.dart';

class InventarioAjusteCabTabPage extends StatelessWidget {
  InventarioAjusteCabTabPage({Key? key}) : super(key: key);
  final inventarioAjusteCabController = Get.find<InventarioAjusteCabController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          inventarioAjusteCabController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: inventarioAjusteCabController.inventarioAjusteCabTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Ajustes de Preço - ${'editing'.tr}'), actions: [
          saveButton(onPressed: inventarioAjusteCabController.save),
          cancelAndExitButton(onPressed: inventarioAjusteCabController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: inventarioAjusteCabController.tabController,
                  children: inventarioAjusteCabController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: inventarioAjusteCabController.tabController,
                onTap: inventarioAjusteCabController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: inventarioAjusteCabController.tabItems,
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
