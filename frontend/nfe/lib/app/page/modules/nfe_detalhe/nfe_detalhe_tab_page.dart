import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_detalhe_controller.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';

class NfeDetalheTabPage extends StatelessWidget {
  NfeDetalheTabPage({Key? key}) : super(key: key);
  final nfeDetalheController = Get.find<NfeDetalheController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          nfeDetalheController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: nfeDetalheController.nfeDetalheTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Itens da Nota - ${'editing'.tr}'), actions: [
          saveButton(onPressed: nfeDetalheController.save),
          cancelAndExitButton(onPressed: nfeDetalheController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: nfeDetalheController.tabController,
                  children: nfeDetalheController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: nfeDetalheController.tabController,
                onTap: nfeDetalheController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: nfeDetalheController.tabItems,
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
