import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:get/get.dart';
import 'package:contabil/app/controller/rateio_centro_resultado_cab_controller.dart';
import 'package:contabil/app/page/shared_widget/shared_widget_imports.dart';

class RateioCentroResultadoCabTabPage extends StatelessWidget {
  RateioCentroResultadoCabTabPage({Key? key}) : super(key: key);
  final rateioCentroResultadoCabController = Get.find<RateioCentroResultadoCabController>();

  @override
  Widget build(BuildContext context) {
		return KeyboardListener(
			autofocus: false,
			focusNode: FocusNode(),
			onKeyEvent: (event) {
				if (event.logicalKey == LogicalKeyboardKey.escape) {
          rateioCentroResultadoCabController.preventDataLoss();
        }
      },
      child: Scaffold(
        key: rateioCentroResultadoCabController.rateioCentroResultadoCabTabPageScaffoldKey,
        appBar: AppBar(automaticallyImplyLeading: false, title: Text('Rateio Centro Resultado - ${'editing'.tr}'), actions: [
          saveButton(onPressed: rateioCentroResultadoCabController.save),
          cancelAndExitButton(onPressed: rateioCentroResultadoCabController.preventDataLoss),
        ]),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: TabBarView(
                  controller: rateioCentroResultadoCabController.tabController,
                  children: rateioCentroResultadoCabController.tabPages(),
                ),
              ),
              ButtonsTabBar(
                controller: rateioCentroResultadoCabController.tabController,
                onTap: rateioCentroResultadoCabController.tabChange,
                height: 40,
                elevation: 2,
                borderWidth: 0,
                backgroundColor: Colors.blueGrey,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                tabs: rateioCentroResultadoCabController.tabItems,
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
