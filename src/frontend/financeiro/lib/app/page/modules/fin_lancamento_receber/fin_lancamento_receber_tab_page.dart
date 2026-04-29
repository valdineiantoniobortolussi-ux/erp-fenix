import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:financeiro/app/controller/fin_lancamento_receber_controller.dart';
import 'package:financeiro/app/page/shared_widget/shared_widget_imports.dart';

class FinLancamentoReceberTabPage extends StatelessWidget {
  FinLancamentoReceberTabPage({Key? key}) : super(key: key);
  final finLancamentoReceberController = Get.find<FinLancamentoReceberController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          finLancamentoReceberController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: finLancamentoReceberController.finLancamentoReceberTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Lançamento a Receber - ${'editing'.tr}'), actions: [
          saveButton(onPressed: finLancamentoReceberController.save),
          cancelAndExitButton(onPressed: finLancamentoReceberController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: finLancamentoReceberController.tabController,
                  children: finLancamentoReceberController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: finLancamentoReceberController.tabController,
                onTap: finLancamentoReceberController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: finLancamentoReceberController.tabItems,
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
