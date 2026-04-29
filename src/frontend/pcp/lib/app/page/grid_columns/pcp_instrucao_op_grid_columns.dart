import 'package:pluto_grid/pluto_grid.dart';
import 'package:pcp/app/infra/util.dart';

List<PlutoColumn> pcpInstrucaoOpGridColumns({bool isForLookup = false}) {
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
			hide: true,
		),
		PlutoColumn(
			title: "Instrucao",
			field: "pcpInstrucao",
			type: PlutoColumnType.text(),
			formatter: Util.stringFormat,
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.left,
			width: 400,
			hide: isForLookup,
		),
		PlutoColumn(
			title: "Id Pcp Instrucao",
			field: "idPcpInstrucao",
			type: PlutoColumnType.number(),
			enableFilterMenuItem: false,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
		),
	];
}
