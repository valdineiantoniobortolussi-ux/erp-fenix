import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_encerramento_exe_cab_controller.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';

class ContabilEncerramentoExeCabTabPage extends StatelessWidget {
  ContabilEncerramentoExeCabTabPage({Key? key}) : super(key: key);
  final contabilEncerramentoExeCabController = Get.find<ContabilEncerramentoExeCabController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          contabilEncerramentoExeCabController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: contabilEncerramentoExeCabController.contabilEncerramentoExeCabTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Encerramento do Exercício - ${'editing'.tr}'), actions: [
          saveButton(onPressed: contabilEncerramentoExeCabController.save),
          cancelAndExitButton(onPressed: contabilEncerramentoExeCabController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: contabilEncerramentoExeCabController.tabController,
                  children: contabilEncerramentoExeCabController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: contabilEncerramentoExeCabController.tabController,
                onTap: contabilEncerramentoExeCabController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: contabilEncerramentoExeCabController.tabItems,
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
