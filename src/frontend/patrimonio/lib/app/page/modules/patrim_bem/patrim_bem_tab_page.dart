import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:patrimonio/app/controller/patrim_bem_controller.dart';
import 'package:patrimonio/app/page/shared_widget/shared_widget_imports.dart';

class PatrimBemTabPage extends StatelessWidget {
  PatrimBemTabPage({Key? key}) : super(key: key);
  final patrimBemController = Get.find<PatrimBemController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          patrimBemController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: patrimBemController.patrimBemTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Bem - ${'editing'.tr}'), actions: [
          saveButton(onPressed: patrimBemController.save),
          cancelAndExitButton(onPressed: patrimBemController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: patrimBemController.tabController,
                  children: patrimBemController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: patrimBemController.tabController,
                onTap: patrimBemController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: patrimBemController.tabItems,
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
