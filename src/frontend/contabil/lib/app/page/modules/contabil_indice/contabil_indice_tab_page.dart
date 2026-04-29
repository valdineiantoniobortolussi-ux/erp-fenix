import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_indice_controller.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';

class ContabilIndiceTabPage extends StatelessWidget {
  ContabilIndiceTabPage({Key? key}) : super(key: key);
  final contabilIndiceController = Get.find<ContabilIndiceController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          contabilIndiceController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: contabilIndiceController.contabilIndiceTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Índices - ${'editing'.tr}'), actions: [
          saveButton(onPressed: contabilIndiceController.save),
          cancelAndExitButton(onPressed: contabilIndiceController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: contabilIndiceController.tabController,
                  children: contabilIndiceController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: contabilIndiceController.tabController,
                onTap: contabilIndiceController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: contabilIndiceController.tabItems,
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
