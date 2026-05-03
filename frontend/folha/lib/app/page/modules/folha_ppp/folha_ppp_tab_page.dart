import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:folha/app/controller/folha_ppp_controller.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';

class FolhaPppTabPage extends StatelessWidget {
  FolhaPppTabPage({Key? key}) : super(key: key);
  final folhaPppController = Get.find<FolhaPppController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          folhaPppController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: folhaPppController.folhaPppTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('PPP - ${'editing'.tr}'), actions: [
          saveButton(onPressed: folhaPppController.save),
          cancelAndExitButton(onPressed: folhaPppController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: folhaPppController.tabController,
                  children: folhaPppController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: folhaPppController.tabController,
                onTap: folhaPppController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: folhaPppController.tabItems,
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
