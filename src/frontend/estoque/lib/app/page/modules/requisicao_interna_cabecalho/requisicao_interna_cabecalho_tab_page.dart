import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:estoque/app/controller/requisicao_interna_cabecalho_controller.dart';
import 'package:estoque/app/page/shared_widget/shared_widget_imports.dart';

class RequisicaoInternaCabecalhoTabPage extends StatelessWidget {
  RequisicaoInternaCabecalhoTabPage({Key? key}) : super(key: key);
  final requisicaoInternaCabecalhoController = Get.find<RequisicaoInternaCabecalhoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          requisicaoInternaCabecalhoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: requisicaoInternaCabecalhoController.requisicaoInternaCabecalhoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Requisicao Interna - ${'editing'.tr}'), actions: [
          saveButton(onPressed: requisicaoInternaCabecalhoController.save),
          cancelAndExitButton(onPressed: requisicaoInternaCabecalhoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: requisicaoInternaCabecalhoController.tabController,
                  children: requisicaoInternaCabecalhoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: requisicaoInternaCabecalhoController.tabController,
                onTap: requisicaoInternaCabecalhoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: requisicaoInternaCabecalhoController.tabItems,
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
