import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:nfe/app/controller/nfe_cabecalho_controller.dart';
import 'package:nfe/app/page/shared_widget/shared_widget_imports.dart';

class NfeCabecalhoTabPage extends StatelessWidget {
  NfeCabecalhoTabPage({Key? key}) : super(key: key);
  final nfeCabecalhoController = Get.find<NfeCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          nfeCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: nfeCabecalhoController.nfeCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('NF-e - ${'editing'.tr}'), actions: [
          saveButton(onPressed: nfeCabecalhoController.save),
          cancelAndExitButton(onPressed: nfeCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: nfeCabecalhoController.tabController,
                  children: nfeCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: nfeCabecalhoController.tabController,
                onTap: nfeCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: nfeCabecalhoController.tabItems,
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
