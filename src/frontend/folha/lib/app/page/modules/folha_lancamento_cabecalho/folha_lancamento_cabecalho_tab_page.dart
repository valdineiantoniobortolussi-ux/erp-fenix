import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:folha/app/controller/folha_lancamento_cabecalho_controller.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';

class FolhaLancamentoCabecalhoTabPage extends StatelessWidget {
  FolhaLancamentoCabecalhoTabPage({Key? key}) : super(key: key);
  final folhaLancamentoCabecalhoController = Get.find<FolhaLancamentoCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          folhaLancamentoCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: folhaLancamentoCabecalhoController.folhaLancamentoCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Lançamento - ${'editing'.tr}'), actions: [
          saveButton(onPressed: folhaLancamentoCabecalhoController.save),
          cancelAndExitButton(onPressed: folhaLancamentoCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: folhaLancamentoCabecalhoController.tabController,
                  children: folhaLancamentoCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: folhaLancamentoCabecalhoController.tabController,
                onTap: folhaLancamentoCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: folhaLancamentoCabecalhoController.tabItems,
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
