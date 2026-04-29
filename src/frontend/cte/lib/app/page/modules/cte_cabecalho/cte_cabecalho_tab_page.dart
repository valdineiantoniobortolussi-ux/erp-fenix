import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:cte/app/controller/cte_cabecalho_controller.dart';
import 'package:cte/app/page/shared_widget/shared_widget_imports.dart';

class CteCabecalhoTabPage extends StatelessWidget {
  CteCabecalhoTabPage({Key? key}) : super(key: key);
  final cteCabecalhoController = Get.find<CteCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          cteCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: cteCabecalhoController.cteCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('CT-e - ${'editing'.tr}'), actions: [
          saveButton(onPressed: cteCabecalhoController.save),
          cancelAndExitButton(onPressed: cteCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: cteCabecalhoController.tabController,
                  children: cteCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: cteCabecalhoController.tabController,
                onTap: cteCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: cteCabecalhoController.tabItems,
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
