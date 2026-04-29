import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_lancamento_pagar_controller.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';

class FinLancamentoPagarTabPage extends StatelessWidget {
  FinLancamentoPagarTabPage({Key? key}) : super(key: key);
  final finLancamentoPagarController = Get.find<FinLancamentoPagarController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          finLancamentoPagarController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: finLancamentoPagarController.finLancamentoPagarTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Lançamento a Pagar - ${'editing'.tr}'), actions: [
          saveButton(onPressed: finLancamentoPagarController.save),
          cancelAndExitButton(onPressed: finLancamentoPagarController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: finLancamentoPagarController.tabController,
                  children: finLancamentoPagarController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: finLancamentoPagarController.tabController,
                onTap: finLancamentoPagarController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: finLancamentoPagarController.tabItems,
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
