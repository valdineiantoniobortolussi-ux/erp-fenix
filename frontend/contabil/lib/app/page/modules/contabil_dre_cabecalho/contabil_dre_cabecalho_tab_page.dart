import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_dre_cabecalho_controller.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';

class ContabilDreCabecalhoTabPage extends StatelessWidget {
  ContabilDreCabecalhoTabPage({Key? key}) : super(key: key);
  final contabilDreCabecalhoController = Get.find<ContabilDreCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          contabilDreCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: contabilDreCabecalhoController.contabilDreCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('DRE - ${'editing'.tr}'), actions: [
          saveButton(onPressed: contabilDreCabecalhoController.save),
          cancelAndExitButton(onPressed: contabilDreCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: contabilDreCabecalhoController.tabController,
                  children: contabilDreCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: contabilDreCabecalhoController.tabController,
                onTap: contabilDreCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: contabilDreCabecalhoController.tabItems,
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
