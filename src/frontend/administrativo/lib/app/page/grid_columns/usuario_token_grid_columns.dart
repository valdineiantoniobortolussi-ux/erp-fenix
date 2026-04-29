import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/infra/util.dart';
import 'package:intl/intl.dart';

List<PlutoColumn> usuarioTokenGridColumns({bool isForLookup = false}) {
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
			title: "Login",
			field: "login",
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
			title: "Token",
			field: "token",
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
			title: "Data Criacao",
			field: "dataCriacao",
			type: PlutoColumnType.date(format: "dd/MM/yyyy"),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
			formatter: (value) {
				if (value is DateTime) {
					return DateFormat('dd/MM/yyyy').format(value);
				}
				return value?.toString() ?? '';
			},
		),
		PlutoColumn(
			title: "Hora Criacao",
			field: "horaCriacao",
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
			title: "Data Expiracao",
			field: "dataExpiracao",
			type: PlutoColumnType.date(format: "dd/MM/yyyy"),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
			formatter: (value) {
				if (value is DateTime) {
					return DateFormat('dd/MM/yyyy').format(value);
				}
				return value?.toString() ?? '';
			},
		),
		PlutoColumn(
			title: "Hora Expiracao",
			field: "horaExpiracao",
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
			title: "Id Temporário",
			field: "tempId",
			type: PlutoColumnType.text(),
			enableFilterMenuItem: false,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
			hide: true,
		),
		
	];
}
