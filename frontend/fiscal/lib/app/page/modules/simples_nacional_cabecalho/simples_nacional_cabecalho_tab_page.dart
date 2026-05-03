import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/controller/simples_nacional_cabecalho_controller.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';

class SimplesNacionalCabecalhoTabPage extends StatelessWidget {
  SimplesNacionalCabecalhoTabPage({Key? key}) : super(key: key);
  final simplesNacionalCabecalhoController = Get.find<SimplesNacionalCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          simplesNacionalCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: simplesNacionalCabecalhoController.simplesNacionalCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Simples Nacional - ${'editing'.tr}'), actions: [
          saveButton(onPressed: simplesNacionalCabecalhoController.save),
          cancelAndExitButton(onPressed: simplesNacionalCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: simplesNacionalCabecalhoController.tabController,
                  children: simplesNacionalCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: simplesNacionalCabecalhoController.tabController,
                onTap: simplesNacionalCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: simplesNacionalCabecalhoController.tabItems,
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
