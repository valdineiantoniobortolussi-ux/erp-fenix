import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/controller/talonario_cheque_controller.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';

class TalonarioChequeTabPage extends StatelessWidget {
  TalonarioChequeTabPage({Key? key}) : super(key: key);
  final talonarioChequeController = Get.find<TalonarioChequeController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          talonarioChequeController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: talonarioChequeController.talonarioChequeTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Talonário Cheque - ${'editing'.tr}'), actions: [
          saveButton(onPressed: talonarioChequeController.save),
          cancelAndExitButton(onPressed: talonarioChequeController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: talonarioChequeController.tabController,
                  children: talonarioChequeController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: talonarioChequeController.tabController,
                onTap: talonarioChequeController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: talonarioChequeController.tabItems,
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
