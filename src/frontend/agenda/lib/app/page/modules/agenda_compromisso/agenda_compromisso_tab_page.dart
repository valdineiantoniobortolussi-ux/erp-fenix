import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:agenda/app/controller/agenda_compromisso_controller.dart';
import 'package:agenda/app/page/shared_widget/shared_widget_imports.dart';

class AgendaCompromissoTabPage extends StatelessWidget {
  AgendaCompromissoTabPage({Key? key}) : super(key: key);
  final agendaCompromissoController = Get.find<AgendaCompromissoController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          agendaCompromissoController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: agendaCompromissoController.agendaCompromissoTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Compromissos - ${'editing'.tr}'), actions: [
          saveButton(onPressed: agendaCompromissoController.save),
          cancelAndExitButton(onPressed: agendaCompromissoController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: agendaCompromissoController.tabController,
                  children: agendaCompromissoController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: agendaCompromissoController.tabController,
                onTap: agendaCompromissoController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: agendaCompromissoController.tabItems,
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
