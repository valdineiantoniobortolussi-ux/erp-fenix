import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/centro_resultado_controller.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';

class CentroResultadoTabPage extends StatelessWidget {
  CentroResultadoTabPage({Key? key}) : super(key: key);
  final centroResultadoController = Get.find<CentroResultadoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          centroResultadoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: centroResultadoController.centroResultadoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Centro de Resultado - ${'editing'.tr}'), actions: [
          saveButton(onPressed: centroResultadoController.save),
          cancelAndExitButton(onPressed: centroResultadoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: centroResultadoController.tabController,
                  children: centroResultadoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: centroResultadoController.tabController,
                onTap: centroResultadoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: centroResultadoController.tabItems,
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
