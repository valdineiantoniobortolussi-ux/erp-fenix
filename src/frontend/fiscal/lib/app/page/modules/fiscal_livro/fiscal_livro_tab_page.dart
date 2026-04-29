import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:fiscal/app/controller/fiscal_livro_controller.dart';
import 'package:fiscal/app/page/shared_widget/shared_widget_imports.dart';

class FiscalLivroTabPage extends StatelessWidget {
  FiscalLivroTabPage({Key? key}) : super(key: key);
  final fiscalLivroController = Get.find<FiscalLivroController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          fiscalLivroController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: fiscalLivroController.fiscalLivroTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Livros - ${'editing'.tr}'), actions: [
          saveButton(onPressed: fiscalLivroController.save),
          cancelAndExitButton(onPressed: fiscalLivroController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: fiscalLivroController.tabController,
                  children: fiscalLivroController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: fiscalLivroController.tabController,
                onTap: fiscalLivroController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: fiscalLivroController.tabItems,
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
