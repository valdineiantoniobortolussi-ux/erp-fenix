import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contratos/app/controller/contrato_controller.dart';
import 'package:contratos/app/page/shared_widget/shared_widget_imports.dart';

class ContratoTabPage extends StatelessWidget {
  ContratoTabPage({Key? key}) : super(key: key);
  final contratoController = Get.find<ContratoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          contratoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: contratoController.contratoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Contrato - ${'editing'.tr}'), actions: [
          saveButton(onPressed: contratoController.save),
          cancelAndExitButton(onPressed: contratoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: contratoController.tabController,
                  children: contratoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: contratoController.tabController,
                onTap: contratoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: contratoController.tabItems,
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
