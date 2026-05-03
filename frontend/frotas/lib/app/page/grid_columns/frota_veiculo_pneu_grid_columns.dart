import 'package:pluto_grid/pluto_grid.dart';
import 'package:frotas/app/infra/util.dart';
import 'package:get/get.dart';

List<PlutoColumn> frotaVeiculoPneuGridColumns({bool isForLookup = false}) {
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
			title: "Data Troca",
			field: "dataTroca",
			type: PlutoColumnType.date(format: "dd/MM/yyyy"),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.center,
			width: 200,
		),
		PlutoColumn(
			title: "Valor Troca",
			field: "valorTroca",
			type: PlutoColumnType.currency(format: '###,###.##', decimalDigits: 2, locale: Get.locale.toString(),),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.right,
			width: 200,
		),
		PlutoColumn(
			title: "Posicao Pneu",
			field: "posicaoPneu",
			type: PlutoColumnType.text(),
			formatter: Util.stringFormat,
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.left,
			width: 400,
		),
		PlutoColumn(
			title: "Marca Pneu",
			field: "marcaPneu",
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
