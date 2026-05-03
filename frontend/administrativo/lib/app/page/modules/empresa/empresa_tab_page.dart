import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:administrativo/app/controller/empresa_controller.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';

class EmpresaTabPage extends StatelessWidget {
  EmpresaTabPage({Key? key}) : super(key: key);
  final empresaController = Get.find<EmpresaController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          empresaController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: empresaController.empresaTabPageScaffoldKey,
        appBar: AppBar(
					automaticallyImplyLeading: false, 
					title: Text('${ empresaController.screenTitle } - ${ empresaController.isNewRecord ? 'inserting'.tr : 'editing'.tr }',),
					actions: [
						saveButton(onPressed: empresaController.save),
						cancelAndExitButton(onPressed: empresaController.preventDataLoss),
					]
				),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: empresaController.tabController,
                  children: empresaController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: empresaController.tabController,
                onTap: empresaController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: empresaController.tabItems,
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
