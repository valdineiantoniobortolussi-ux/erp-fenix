import 'package:pluto_grid/pluto_grid.dart';
import 'package:cadastros/app/infra/util.dart';
import 'package:extended_masked_text/extended_masked_text.dart';

List<PlutoColumn> pessoaTelefoneGridColumns({bool isForLookup = false}) {
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
			title: "Tipo",
			field: "tipo",
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
			title: "Numero",
			field: "numero",
			type: PlutoColumnType.text(),
			formatter: (dynamic value) { return MaskedTextController(text: value, mask: '(00)00000-0000').text; },
			enableFilterMenuItem: true,
			enableSetColumnsMenuItem: false,
			enableHideColumnMenuItem: false,
			titleTextAlign: PlutoColumnTextAlign.center,
			textAlign: PlutoColumnTextAlign.left,
			width: 200,
		),
	];
}
