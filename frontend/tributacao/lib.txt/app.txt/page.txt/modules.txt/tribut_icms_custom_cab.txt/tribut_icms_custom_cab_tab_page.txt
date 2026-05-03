import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:tributacao/app/controller/tribut_icms_custom_cab_controller.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';

class TributIcmsCustomCabTabPage extends StatelessWidget {
  TributIcmsCustomCabTabPage({Key? key}) : super(key: key);
  final tributIcmsCustomCabController = Get.find<TributIcmsCustomCabController>();

  @override
  Widget build(BuildContext context) {
return KeyboardListener(
      autofocus: false,
      focusNode: FocusNode(),
      onKeyEvent: (event) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          tributIcmsCustomCabController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: tributIcmsCustomCabController.tributIcmsCustomCabTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('TributIcmsCustomCab - ${'editing'.tr}'), actions: [
          saveButton(onPressed: tributIcmsCustomCabController.save),
          cancelAndExitButton(onPressed: tributIcmsCustomCabController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: tributIcmsCustomCabController.tabController,
                  children: tributIcmsCustomCabController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: tributIcmsCustomCabController.tabController,
                onTap: tributIcmsCustomCabController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: tributIcmsCustomCabController.tabItems,
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
