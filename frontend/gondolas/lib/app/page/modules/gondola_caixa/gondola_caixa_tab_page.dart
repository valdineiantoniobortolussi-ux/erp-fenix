import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:gondolas/app/controller/gondola_caixa_controller.dart';
import 'package:gondolas/app/page/shared_widget/shared_widget_imports.dart';

class GondolaCaixaTabPage extends StatelessWidget {
  GondolaCaixaTabPage({Key? key}) : super(key: key);
  final gondolaCaixaController = Get.find<GondolaCaixaController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          gondolaCaixaController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: gondolaCaixaController.gondolaCaixaTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Caixa - ${'editing'.tr}'), actions: [
          saveButton(onPressed: gondolaCaixaController.save),
          cancelAndExitButton(onPressed: gondolaCaixaController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: gondolaCaixaController.tabController,
                  children: gondolaCaixaController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: gondolaCaixaController.tabController,
                onTap: gondolaCaixaController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: gondolaCaixaController.tabItems,
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
