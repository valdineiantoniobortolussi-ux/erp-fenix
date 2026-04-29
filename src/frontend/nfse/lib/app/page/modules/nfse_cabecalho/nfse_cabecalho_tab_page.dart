import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:nfse/app/controller/nfse_cabecalho_controller.dart';
import 'package:nfse/app/page/shared_widget/shared_widget_imports.dart';

class NfseCabecalhoTabPage extends StatelessWidget {
  NfseCabecalhoTabPage({Key? key}) : super(key: key);
  final nfseCabecalhoController = Get.find<NfseCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          nfseCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: nfseCabecalhoController.nfseCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('NFS-e - ${'editing'.tr}'), actions: [
          saveButton(onPressed: nfseCabecalhoController.save),
          cancelAndExitButton(onPressed: nfseCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: nfseCabecalhoController.tabController,
                  children: nfseCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: nfseCabecalhoController.tabController,
                onTap: nfseCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: nfseCabecalhoController.tabItems,
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
