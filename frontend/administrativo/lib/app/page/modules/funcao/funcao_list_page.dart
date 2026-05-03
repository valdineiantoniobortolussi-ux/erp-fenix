import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';
import 'package:administrativo/app/controller/funcao_controller.dart';
import 'package:administrativo/app/page/shared_page/list_page_base.dart';

class FuncaoListPage extends ListPageBase<FuncaoController> {
  const FuncaoListPage({Key? key}) : super(key: key);

  @override
  List<Map<String, dynamic>> get mobileItems => controller.mobileItems;

  @override
  Map<String, dynamic> get mobileConfig => controller.mobileConfig;

  @override
  String get standardFieldForFilter => controller.standardFieldForFilter;

  @override
  Widget buildMobileView() {
    return buildDesktopView();
  }

  @override
  Widget buildDesktopView() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(controller.screenTitle),
        actions: [
          ...additionalAppBarActions(),
          exitButton(),
          const SizedBox(
            height: 10,
            width: 5,
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black26,
        shape: const CircularNotchedRectangle(),
        child: Row(children: [
          ...standardBottomActions(),
          ...additionalBottomActions(),
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: PlutoGrid(
                configuration: gridConfiguration(),
                noRowsWidget: Text('grid_no_rows'.tr),
                createFooter: (stateManager) {
                  stateManager.setPageSize(Constants.gridRowsPerPage, notify: false);
                  return PlutoPagination(stateManager);
                },
                columns: controller.gridColumns,
                rows: controller.plutoRows(),
                onLoaded: (event) {
                  controller.plutoGridStateManager = event.stateManager;
                  controller.plutoGridStateManager.setSelectingMode(PlutoGridSelectingMode.row);
                  controller.keyboardListener = controller.plutoGridStateManager.keyManager!.subject.stream.listen(controller.handleKeyboard);
                  controller.loadData();
                },
                mode: PlutoGridMode.selectWithOneTap,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  List<Widget> additionalAppBarActions() {
    return [
    ];
  }

  @override
  List<Widget> additionalBottomActions() {
    return [
    ];
  }
}