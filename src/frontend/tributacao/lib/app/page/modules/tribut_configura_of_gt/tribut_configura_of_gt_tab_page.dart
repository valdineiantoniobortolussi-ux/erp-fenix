import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_configura_of_gt_controller.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';

class TributConfiguraOfGtTabPage extends StatelessWidget {
  TributConfiguraOfGtTabPage({Key? key}) : super(key: key);
  final tributConfiguraOfGtController = Get.find<TributConfiguraOfGtController>();

  @override
  Widget build(BuildContext context) {
return KeyboardListener(
      autofocus: false,
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          tributConfiguraOfGtController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: tributConfiguraOfGtController.tributConfiguraOfGtTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('TributConfiguraOfGt - ${'editing'.tr}'), actions: [
          saveButton(onPressed: tributConfiguraOfGtController.save),
          cancelAndExitButton(onPressed: tributConfiguraOfGtController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: tributConfiguraOfGtController.tabController,
                  children: tributConfiguraOfGtController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: tributConfiguraOfGtController.tabController,
                onTap: tributConfiguraOfGtController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: tributConfiguraOfGtController.tabItems,
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
