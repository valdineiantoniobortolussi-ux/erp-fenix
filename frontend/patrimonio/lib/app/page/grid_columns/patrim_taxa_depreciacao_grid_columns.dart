import 'package:pluto_grid/pluto_grid.dart';
import 'package:patrimonio/app/infra/util.dart';
import 'package:get/get.dart';

List<PlutoColumn> patrimTaxaDepreciacaoGridColumns({bool isForLookup = false}) {
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
			title: "NCM",
			field: "ncm",
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
			title: "Bem",
			field: "bem",
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
			title: "Vida",
			field: "vida",
			type: PlutoColumnType.currency(format: '###,###.##', decimalDigits: 2, locale: Get.locale.toString(),),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.right,
			width: 200,
		),
		PlutoColumn(
			title: "Taxa",
			field: "taxa",
			type: PlutoColumnType.currency(format: '###,###.##', decimalDigits: 2, locale: Get.locale.toString(),),
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.right,
			width: 200,
		),
	];
}
