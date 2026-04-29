import 'package:pluto_grid/pluto_grid.dart';
import 'package:cte/app/infra/util.dart';

List<PlutoColumn> cteRodoviarioLacreGridColumns({bool isForLookup = false}) {
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
			title: "Id Cte Rodoviario",
			field: "cteRodoviario",
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
			title: "Numero",
			field: "numero",
			type: PlutoColumnType.text(),
			formatter: Util.stringFormat,
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.left,
			width: 200,
		),
		PlutoColumn(
			title: "Id Cte Rodoviario",
			field: "idCteRodoviario",
			type: PlutoColumnType.number(),
			enableFilterMenuItem: false,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
			hide: !isForLookup,
		),
	];
}
