import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FapModel {
	int? id;
	double? fap;
	DateTime? dataInicial;
	DateTime? dataFinal;

	FapModel({
		this.id,
		this.fap,
		this.dataInicial,
		this.dataFinal,
	});

	static List<String> dbColumns = <String>[
		'id',
		'fap',
		'data_inicial',
		'data_final',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Fap',
		'Data Inicial',
		'Data Final',
	];

	FapModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		fap = jsonData['fap']?.toDouble();
		dataInicial = jsonData['dataInicial'] != null ? DateTime.tryParse(jsonData['dataInicial']) : null;
		dataFinal = jsonData['dataFinal'] != null ? DateTime.tryParse(jsonData['dataFinal']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['fap'] = fap;
		jsonData['dataInicial'] = dataInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicial!) : null;
		jsonData['dataFinal'] = dataFinal != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFinal!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		fap = plutoRow.cells['fap']?.value?.toDouble();
		dataInicial = Util.stringToDate(plutoRow.cells['dataInicial']?.value);
		dataFinal = Util.stringToDate(plutoRow.cells['dataFinal']?.value);
	}	

	FapModel clone() {
		return FapModel(
			id: id,
			fap: fap,
			dataInicial: dataInicial,
			dataFinal: dataFinal,
		);			
	}

	
}