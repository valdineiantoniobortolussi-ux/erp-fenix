import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:agenda/app/controller/recado_remetente_controller.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';

class RecadoRemetenteTabPage extends StatelessWidget {
  RecadoRemetenteTabPage({Key? key}) : super(key: key);
  final recadoRemetenteController = Get.find<RecadoRemetenteController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          recadoRemetenteController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: recadoRemetenteController.recadoRemetenteTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Recado - ${'editing'.tr}'), actions: [
          saveButton(onPressed: recadoRemetenteController.save),
          cancelAndExitButton(onPressed: recadoRemetenteController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: recadoRemetenteController.tabController,
                  children: recadoRemetenteController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: recadoRemetenteController.tabController,
                onTap: recadoRemetenteController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: recadoRemetenteController.tabItems,
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
