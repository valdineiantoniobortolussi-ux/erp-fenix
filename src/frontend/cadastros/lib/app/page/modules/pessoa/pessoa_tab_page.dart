import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:cadastros/app/controller/pessoa_controller.dart';
import 'package:cadastros/app/page/shared_widget/shared_widget_imports.dart';

class PessoaTabPage extends StatelessWidget {
  PessoaTabPage({Key? key}) : super(key: key);
  final pessoaController = Get.find<PessoaController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          pessoaController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: pessoaController.pessoaTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Pessoa - ${'editing'.tr}'), actions: [
          saveButton(onPressed: pessoaController.save),
          cancelAndExitButton(onPressed: pessoaController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: pessoaController.tabController,
                  children: pessoaController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: pessoaController.tabController,
                onTap: pessoaController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: pessoaController.tabItems,
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
