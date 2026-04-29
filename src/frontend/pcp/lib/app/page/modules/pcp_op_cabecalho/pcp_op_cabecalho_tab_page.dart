import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:pcp/app/controller/pcp_op_cabecalho_controller.dart';
import 'package:pcp/app/page/shared_widget/shared_widget_imports.dart';

class PcpOpCabecalhoTabPage extends StatelessWidget {
  PcpOpCabecalhoTabPage({Key? key}) : super(key: key);
  final pcpOpCabecalhoController = Get.find<PcpOpCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          pcpOpCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: pcpOpCabecalhoController.pcpOpCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Ordem de Produção - ${'editing'.tr}'), actions: [
          saveButton(onPressed: pcpOpCabecalhoController.save),
          cancelAndExitButton(onPressed: pcpOpCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: pcpOpCabecalhoController.tabController,
                  children: pcpOpCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: pcpOpCabecalhoController.tabController,
                onTap: pcpOpCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: pcpOpCabecalhoController.tabItems,
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
