import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeNumeroModel {
	int? id;
	String? serie;
	int? numero;

	NfeNumeroModel({
		this.id,
		this.serie,
		this.numero,
	});

	static List<String> dbColumns = <String>[
		'id',
		'serie',
		'numero',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Serie',
		'Numero',
	];

	NfeNumeroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		serie = NfeNumeroDomain.getSerie(jsonData['serie']);
		numero = jsonData['numero'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['serie'] = NfeNumeroDomain.setSerie(serie);
		jsonData['numero'] = numero;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		serie = plutoRow.cells['serie']?.value != '' ? plutoRow.cells['serie']?.value : 'AAA';
		numero = plutoRow.cells['numero']?.value;
	}	

	NfeNumeroModel clone() {
		return NfeNumeroModel(
			id: id,
			serie: serie,
			numero: numero,
		);			
	}

	
}