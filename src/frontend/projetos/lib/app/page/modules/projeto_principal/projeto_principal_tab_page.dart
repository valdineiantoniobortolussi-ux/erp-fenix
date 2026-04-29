import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:projetos/app/controller/projeto_principal_controller.dart';
import 'package:projetos/app/page/shared_widget/shared_widget_imports.dart';

class ProjetoPrincipalTabPage extends StatelessWidget {
  ProjetoPrincipalTabPage({Key? key}) : super(key: key);
  final projetoPrincipalController = Get.find<ProjetoPrincipalController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          projetoPrincipalController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: projetoPrincipalController.projetoPrincipalTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Projeto - ${'editing'.tr}'), actions: [
          saveButton(onPressed: projetoPrincipalController.save),
          cancelAndExitButton(onPressed: projetoPrincipalController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: projetoPrincipalController.tabController,
                  children: projetoPrincipalController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: projetoPrincipalController.tabController,
                onTap: projetoPrincipalController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: projetoPrincipalController.tabItems,
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
