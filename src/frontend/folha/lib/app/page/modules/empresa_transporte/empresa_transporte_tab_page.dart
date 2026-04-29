import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:folha/app/controller/empresa_transporte_controller.dart';
import 'package:folha/app/page/shared_widget/shared_widget_imports.dart';

class EmpresaTransporteTabPage extends StatelessWidget {
  EmpresaTransporteTabPage({Key? key}) : super(key: key);
  final empresaTransporteController = Get.find<EmpresaTransporteController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          empresaTransporteController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: empresaTransporteController.empresaTransporteTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Empresa de Transporte - ${'editing'.tr}'), actions: [
          saveButton(onPressed: empresaTransporteController.save),
          cancelAndExitButton(onPressed: empresaTransporteController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: empresaTransporteController.tabController,
                  children: empresaTransporteController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: empresaTransporteController.tabController,
                onTap: empresaTransporteController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: empresaTransporteController.tabItems,
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
