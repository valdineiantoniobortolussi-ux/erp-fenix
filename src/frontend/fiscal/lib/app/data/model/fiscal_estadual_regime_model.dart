import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalEstadualRegimeModel {
	int? id;
	String? uf;
	String? codigo;
	String? nome;

	FiscalEstadualRegimeModel({
		this.id,
		this.uf,
		this.codigo,
		this.nome,
	});

	static List<String> dbColumns = <String>[
		'id',
		'uf',
		'codigo',
		'nome',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Uf',
		'Codigo',
		'Nome',
	];

	FiscalEstadualRegimeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		uf = FiscalEstadualRegimeDomain.getUf(jsonData['uf']);
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['uf'] = FiscalEstadualRegimeDomain.setUf(uf);
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
	}	

	FiscalEstadualRegimeModel clone() {
		return FiscalEstadualRegimeModel(
			id: id,
			uf: uf,
			codigo: codigo,
			nome: nome,
		);			
	}

	
}