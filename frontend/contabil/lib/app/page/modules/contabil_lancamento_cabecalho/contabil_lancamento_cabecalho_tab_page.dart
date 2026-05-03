import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_lancamento_cabecalho_controller.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';

class ContabilLancamentoCabecalhoTabPage extends StatelessWidget {
  ContabilLancamentoCabecalhoTabPage({Key? key}) : super(key: key);
  final contabilLancamentoCabecalhoController = Get.find<ContabilLancamentoCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          contabilLancamentoCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: contabilLancamentoCabecalhoController.contabilLancamentoCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Lancamento Contábil - ${'editing'.tr}'), actions: [
          saveButton(onPressed: contabilLancamentoCabecalhoController.save),
          cancelAndExitButton(onPressed: contabilLancamentoCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: contabilLancamentoCabecalhoController.tabController,
                  children: contabilLancamentoCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: contabilLancamentoCabecalhoController.tabController,
                onTap: contabilLancamentoCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: contabilLancamentoCabecalhoController.tabItems,
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
