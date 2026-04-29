import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/controller/papel_funcao_controller.dart';
import 'package:administrativo/app/page/shared_widget/shared_widget_imports.dart';

class PapelFuncaoListPage extends GetView<PapelFuncaoController> {
	const PapelFuncaoListPage({Key? key}) : super(key: key);

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			bottomNavigationBar: BottomAppBar(
				color: Colors.black45,
				shape: const CircularNotchedRectangle(),
				child: Row(
          children: [
            IconButton(
              tooltip: 'Gerar Funções',
              icon: const Icon(Icons.generating_tokens),
              color: Colors.yellow,
              onPressed: controller.gerarFuncoes,
            )            
					  // deleteButton(onPressed: controller.delete),
				  ]
        ),
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
					onRowDoubleTap: controller.atualizarValorDaCelula,
					mode: PlutoGridMode.selectWithOneTap,
				),
			),
		);
	}

}
