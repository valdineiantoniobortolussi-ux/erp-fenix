import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_parametro_controller.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';

class FiscalParametroTabPage extends StatelessWidget {
  FiscalParametroTabPage({Key? key}) : super(key: key);
  final fiscalParametroController = Get.find<FiscalParametroController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          fiscalParametroController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: fiscalParametroController.fiscalParametroTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Parâmetros - ${'editing'.tr}'), actions: [
          saveButton(onPressed: fiscalParametroController.save),
          cancelAndExitButton(onPressed: fiscalParametroController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: fiscalParametroController.tabController,
                  children: fiscalParametroController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: fiscalParametroController.tabController,
                onTap: fiscalParametroController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: fiscalParametroController.tabItems,
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
