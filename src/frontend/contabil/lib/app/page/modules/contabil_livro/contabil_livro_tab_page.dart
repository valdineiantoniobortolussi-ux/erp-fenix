import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/contabil_livro_controller.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';

class ContabilLivroTabPage extends StatelessWidget {
  ContabilLivroTabPage({Key? key}) : super(key: key);
  final contabilLivroController = Get.find<ContabilLivroController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          contabilLivroController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: contabilLivroController.contabilLivroTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Livros - ${'editing'.tr}'), actions: [
          saveButton(onPressed: contabilLivroController.save),
          cancelAndExitButton(onPressed: contabilLivroController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: contabilLivroController.tabController,
                  children: contabilLivroController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: contabilLivroController.tabController,
                onTap: contabilLivroController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: contabilLivroController.tabItems,
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
