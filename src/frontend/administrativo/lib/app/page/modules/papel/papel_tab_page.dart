import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/controller/papel_controller.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';

class PapelTabPage extends StatelessWidget {
  PapelTabPage({Key? key}) : super(key: key);
  final papelController = Get.find<PapelController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          papelController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: papelController.papelTabPageScaffoldKey,
        appBar: AppBar(
					automaticallyImplyLeading: false, 
					title: Text('${ papelController.screenTitle } - ${ papelController.isNewRecord ? 'inserting'.tr : 'editing'.tr }',),
					actions: [
						saveButton(onPressed: papelController.save),
						cancelAndExitButton(onPressed: papelController.preventDataLoss),
					]
				),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: papelController.tabController,
                  children: papelController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: papelController.tabController,
                onTap: papelController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: papelController.tabItems,
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
