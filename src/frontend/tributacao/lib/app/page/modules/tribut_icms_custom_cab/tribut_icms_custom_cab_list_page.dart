import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:tributacao/app/infra/infra_imports.dart';
import 'package:tributacao/app/controller/tribut_icms_custom_cab_controller.dart';
import 'package:tributacao/app/page/shared_widget/shared_widget_imports.dart';

class TributIcmsCustomCabListPage extends GetView<TributIcmsCustomCabController> {
	const TributIcmsCustomCabListPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				automaticallyImplyLeading: false,
				title: const Text('ICMS Customizado'),
				actions: [
					editButton(onPressed: controller.canUpdate ? controller.callEditPage : controller.noPrivilegeMessage),
					deleteButton(onPressed: controller.canDelete ? controller.delete : controller.noPrivilegeMessage),
					exitButton(),
					const SizedBox(
						height: 10,
						width: 5,
					)
				],
			),
			floatingActionButton: FloatingActionButton(
					onPressed: 
          controller.canInsert 
          ? controller.callEditPageToInsert
          : controller.noPrivilegeMessage,
					child: iconButtonInsert(),
        ),
			floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
			bottomNavigationBar: BottomAppBar(
				color: Colors.black26,
				shape: const CircularNotchedRectangle(),
				child: Row(children: [
					printButton(onPressed: controller.printReport),
					filterButton(onPressed: controller.callFilter)
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
						controller.canUpdate ? controller.callEditPage() : controller.noPrivilegeMessage();
					},
					mode: PlutoGridMode.selectWithOneTap,
				),
			),
		);
	}

}
