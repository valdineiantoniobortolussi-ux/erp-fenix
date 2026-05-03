import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:ponto/app/controller/ponto_banco_horas_controller.dart';
import 'package:ponto/app/page/shared_widget/shared_widget_imports.dart';

class PontoBancoHorasTabPage extends StatelessWidget {
  PontoBancoHorasTabPage({Key? key}) : super(key: key);
  final pontoBancoHorasController = Get.find<PontoBancoHorasController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          pontoBancoHorasController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: pontoBancoHorasController.pontoBancoHorasTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Banco de Horas - ${'editing'.tr}'), actions: [
          saveButton(onPressed: pontoBancoHorasController.save),
          cancelAndExitButton(onPressed: pontoBancoHorasController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: pontoBancoHorasController.tabController,
                  children: pontoBancoHorasController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: pontoBancoHorasController.tabController,
                onTap: pontoBancoHorasController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: pontoBancoHorasController.tabItems,
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
