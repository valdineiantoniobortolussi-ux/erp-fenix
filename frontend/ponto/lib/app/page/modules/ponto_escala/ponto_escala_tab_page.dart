import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_escala_controller.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';

class PontoEscalaTabPage extends StatelessWidget {
  PontoEscalaTabPage({Key? key}) : super(key: key);
  final pontoEscalaController = Get.find<PontoEscalaController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          pontoEscalaController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: pontoEscalaController.pontoEscalaTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Escalas - ${'editing'.tr}'), actions: [
          saveButton(onPressed: pontoEscalaController.save),
          cancelAndExitButton(onPressed: pontoEscalaController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: pontoEscalaController.tabController,
                  children: pontoEscalaController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: pontoEscalaController.tabController,
                onTap: pontoEscalaController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: pontoEscalaController.tabItems,
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
