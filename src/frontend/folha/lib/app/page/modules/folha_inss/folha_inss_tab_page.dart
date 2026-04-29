import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:folha/app/controller/folha_inss_controller.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';

class FolhaInssTabPage extends StatelessWidget {
  FolhaInssTabPage({Key? key}) : super(key: key);
  final folhaInssController = Get.find<FolhaInssController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          folhaInssController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: folhaInssController.folhaInssTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('INSS - ${'editing'.tr}'), actions: [
          saveButton(onPressed: folhaInssController.save),
          cancelAndExitButton(onPressed: folhaInssController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: folhaInssController.tabController,
                  children: folhaInssController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: folhaInssController.tabController,
                onTap: folhaInssController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: folhaInssController.tabItems,
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
