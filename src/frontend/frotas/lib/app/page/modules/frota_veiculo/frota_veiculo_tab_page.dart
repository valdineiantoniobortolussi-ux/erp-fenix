import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:frotas/app/controller/frota_veiculo_controller.dart';
import 'package:frotas/app/page/shared_widget/shared_widget_imports.dart';

class FrotaVeiculoTabPage extends StatelessWidget {
  FrotaVeiculoTabPage({Key? key}) : super(key: key);
  final frotaVeiculoController = Get.find<FrotaVeiculoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          frotaVeiculoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: frotaVeiculoController.frotaVeiculoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Frota Veiculo - ${'editing'.tr}'), actions: [
          saveButton(onPressed: frotaVeiculoController.save),
          cancelAndExitButton(onPressed: frotaVeiculoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: frotaVeiculoController.tabController,
                  children: frotaVeiculoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: frotaVeiculoController.tabController,
                onTap: frotaVeiculoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: frotaVeiculoController.tabItems,
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
