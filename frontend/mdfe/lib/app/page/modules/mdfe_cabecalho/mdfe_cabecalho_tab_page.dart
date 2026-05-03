import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:mdfe/app/controller/mdfe_cabecalho_controller.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';

class MdfeCabecalhoTabPage extends StatelessWidget {
  MdfeCabecalhoTabPage({Key? key}) : super(key: key);
  final mdfeCabecalhoController = Get.find<MdfeCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          mdfeCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: mdfeCabecalhoController.mdfeCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('MDFe - ${'editing'.tr}'), actions: [
          saveButton(onPressed: mdfeCabecalhoController.save),
          cancelAndExitButton(onPressed: mdfeCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: mdfeCabecalhoController.tabController,
                  children: mdfeCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: mdfeCabecalhoController.tabController,
                onTap: mdfeCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: mdfeCabecalhoController.tabItems,
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
