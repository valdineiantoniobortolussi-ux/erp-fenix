import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:etiquetas/app/controller/etiqueta_layout_controller.dart';
import 'package:etiquetas/app/page/shared_widget/shared_widget_imports.dart';

class EtiquetaLayoutTabPage extends StatelessWidget {
  EtiquetaLayoutTabPage({Key? key}) : super(key: key);
  final etiquetaLayoutController = Get.find<EtiquetaLayoutController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          etiquetaLayoutController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: etiquetaLayoutController.etiquetaLayoutTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Layout - ${'editing'.tr}'), actions: [
          saveButton(onPressed: etiquetaLayoutController.save),
          cancelAndExitButton(onPressed: etiquetaLayoutController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: etiquetaLayoutController.tabController,
                  children: etiquetaLayoutController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: etiquetaLayoutController.tabController,
                onTap: etiquetaLayoutController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: etiquetaLayoutController.tabItems,
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
