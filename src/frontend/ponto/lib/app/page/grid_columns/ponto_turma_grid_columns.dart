import 'package:pluto_grid/pluto_grid.dart';
import 'package:ponto/app/infra/util.dart';

List<PlutoColumn> pontoTurmaGridColumns({bool isForLookup = false}) {
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
			title: "Codigo",
			field: "codigo",
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
			title: "Nome",
			field: "nome",
			type: PlutoColumnType.text(),
			formatter: Util.stringFormat,
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.left,
			width: 200,
		),
	];
}
