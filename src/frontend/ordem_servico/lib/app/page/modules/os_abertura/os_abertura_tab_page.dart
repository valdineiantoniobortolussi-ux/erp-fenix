import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:ordem_servico/app/controller/os_abertura_controller.dart';
import 'package:ordem_servico/app/page/shared_widget/shared_widget_imports.dart';

class OsAberturaTabPage extends StatelessWidget {
  OsAberturaTabPage({Key? key}) : super(key: key);
  final osAberturaController = Get.find<OsAberturaController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          osAberturaController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: osAberturaController.osAberturaTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Abertura OS - ${'editing'.tr}'), actions: [
          saveButton(onPressed: osAberturaController.save),
          cancelAndExitButton(onPressed: osAberturaController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: osAberturaController.tabController,
                  children: osAberturaController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: osAberturaController.tabController,
                onTap: osAberturaController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: osAberturaController.tabItems,
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
