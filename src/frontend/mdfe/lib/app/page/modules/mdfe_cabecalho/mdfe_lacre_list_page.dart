import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/controller/mdfe_lacre_controller.dart';
import 'package:mdfe/app/page/shared_widget/shared_widget_imports.dart';

class MdfeLacreListPage extends GetView<MdfeLacreController> {
	const MdfeLacreListPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			floatingActionButton: FloatingActionButton(
					child: iconButtonInsert(),
					onPressed: () {
						controller.callEditPageToInsert();
					}),
			floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
			bottomNavigationBar: BottomAppBar(
				color: Colors.black45,
				shape: const CircularNotchedRectangle(),
				child: Row(children: [
					deleteButton(onPressed: controller.delete),
				]),
			),
			body: Padding(
				padding: const EdgeInsets.all(5),
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
					onRowDoubleTap: (event) {
						controller.callEditPage();
					},
					mode: PlutoGridMode.selectWithOneTap,
				),
			),
		);
	}

}
