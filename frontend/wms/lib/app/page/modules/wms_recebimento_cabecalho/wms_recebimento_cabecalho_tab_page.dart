import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:wms/app/controller/wms_recebimento_cabecalho_controller.dart';
import 'package:wms/app/page/shared_widget/shared_widget_imports.dart';

class WmsRecebimentoCabecalhoTabPage extends StatelessWidget {
  WmsRecebimentoCabecalhoTabPage({Key? key}) : super(key: key);
  final wmsRecebimentoCabecalhoController = Get.find<WmsRecebimentoCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          wmsRecebimentoCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: wmsRecebimentoCabecalhoController.wmsRecebimentoCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Recebimento - ${'editing'.tr}'), actions: [
          saveButton(onPressed: wmsRecebimentoCabecalhoController.save),
          cancelAndExitButton(onPressed: wmsRecebimentoCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: wmsRecebimentoCabecalhoController.tabController,
                  children: wmsRecebimentoCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: wmsRecebimentoCabecalhoController.tabController,
                onTap: wmsRecebimentoCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: wmsRecebimentoCabecalhoController.tabItems,
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
