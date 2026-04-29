import 'package:pluto_grid/pluto_grid.dart';
import 'package:contabil/app/infra/util.dart';

List<PlutoColumn> contabilEncerramentoExeCabGridColumns({bool isForLookup = false}) {
	return <PlutoColumn>[
		PlutoColumn(
			title: "Id",
			field: "id",
			type: PlutoColumnType.number(format: '##########',),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 100,
		),
		PlutoColumn(
			title: "Data Inicio",
			field: "dataInicio",
			type: PlutoColumnType.date(format: "dd/MM/yyyy"),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
		),
		PlutoColumn(
			title: "Data Fim",
			field: "dataFim",
			type: PlutoColumnType.date(format: "dd/MM/yyyy"),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
		),
		PlutoColumn(
			title: "Data Inclusao",
			field: "dataInclusao",
			type: PlutoColumnType.date(format: "dd/MM/yyyy"),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
		),
		PlutoColumn(
			title: "Motivo",
			field: "motivo",
			type: PlutoColumnType.text(),
			formatter: Util.stringFormat,
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.left,
			width: 400,
		),
	];
}
