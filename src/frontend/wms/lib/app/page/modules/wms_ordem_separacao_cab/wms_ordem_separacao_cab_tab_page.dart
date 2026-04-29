import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:wms/app/controller/wms_ordem_separacao_cab_controller.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';

class WmsOrdemSeparacaoCabTabPage extends StatelessWidget {
  WmsOrdemSeparacaoCabTabPage({Key? key}) : super(key: key);
  final wmsOrdemSeparacaoCabController = Get.find<WmsOrdemSeparacaoCabController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          wmsOrdemSeparacaoCabController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: wmsOrdemSeparacaoCabController.wmsOrdemSeparacaoCabTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Ordem Separação - ${'editing'.tr}'), actions: [
          saveButton(onPressed: wmsOrdemSeparacaoCabController.save),
          cancelAndExitButton(onPressed: wmsOrdemSeparacaoCabController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: wmsOrdemSeparacaoCabController.tabController,
                  children: wmsOrdemSeparacaoCabController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: wmsOrdemSeparacaoCabController.tabController,
                onTap: wmsOrdemSeparacaoCabController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: wmsOrdemSeparacaoCabController.tabItems,
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
