import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:pcp/app/controller/pcp_servico_controller.dart';
import 'package:pcp/app/page/shared_widget/shared_widget_imports.dart';

class PcpServicoTabPage extends StatelessWidget {
  PcpServicoTabPage({Key? key}) : super(key: key);
  final pcpServicoController = Get.find<PcpServicoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          pcpServicoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: pcpServicoController.pcpServicoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Serviços - ${'editing'.tr}'), actions: [
          saveButton(onPressed: pcpServicoController.save),
          cancelAndExitButton(onPressed: pcpServicoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: pcpServicoController.tabController,
                  children: pcpServicoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: pcpServicoController.tabController,
                onTap: pcpServicoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: pcpServicoController.tabItems,
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
