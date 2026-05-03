import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:estoque/app/controller/estoque_reajuste_cabecalho_controller.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';

class EstoqueReajusteCabecalhoTabPage extends StatelessWidget {
  EstoqueReajusteCabecalhoTabPage({Key? key}) : super(key: key);
  final estoqueReajusteCabecalhoController = Get.find<EstoqueReajusteCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          estoqueReajusteCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: estoqueReajusteCabecalhoController.estoqueReajusteCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Reajuste de Preços - ${'editing'.tr}'), actions: [
          saveButton(onPressed: estoqueReajusteCabecalhoController.save),
          cancelAndExitButton(onPressed: estoqueReajusteCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: estoqueReajusteCabecalhoController.tabController,
                  children: estoqueReajusteCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: estoqueReajusteCabecalhoController.tabController,
                onTap: estoqueReajusteCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: estoqueReajusteCabecalhoController.tabItems,
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
