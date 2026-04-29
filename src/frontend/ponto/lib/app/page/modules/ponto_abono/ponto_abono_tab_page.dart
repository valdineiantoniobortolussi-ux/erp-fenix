import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_abono_controller.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';

class PontoAbonoTabPage extends StatelessWidget {
  PontoAbonoTabPage({Key? key}) : super(key: key);
  final pontoAbonoController = Get.find<PontoAbonoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          pontoAbonoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: pontoAbonoController.pontoAbonoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Abonos - ${'editing'.tr}'), actions: [
          saveButton(onPressed: pontoAbonoController.save),
          cancelAndExitButton(onPressed: pontoAbonoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: pontoAbonoController.tabController,
                  children: pontoAbonoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: pontoAbonoController.tabController,
                onTap: pontoAbonoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: pontoAbonoController.tabItems,
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
