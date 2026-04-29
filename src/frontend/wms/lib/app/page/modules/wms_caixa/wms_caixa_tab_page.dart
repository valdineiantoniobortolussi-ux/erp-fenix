import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:wms/app/controller/wms_caixa_controller.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';

class WmsCaixaTabPage extends StatelessWidget {
  WmsCaixaTabPage({Key? key}) : super(key: key);
  final wmsCaixaController = Get.find<WmsCaixaController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          wmsCaixaController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: wmsCaixaController.wmsCaixaTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Caixa - ${'editing'.tr}'), actions: [
          saveButton(onPressed: wmsCaixaController.save),
          cancelAndExitButton(onPressed: wmsCaixaController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: wmsCaixaController.tabController,
                  children: wmsCaixaController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: wmsCaixaController.tabController,
                onTap: wmsCaixaController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: wmsCaixaController.tabItems,
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
