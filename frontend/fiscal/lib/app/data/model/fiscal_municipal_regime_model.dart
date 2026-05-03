import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalMunicipalRegimeModel {
	int? id;
	String? uf;
	String? codigo;
	String? nome;

	FiscalMunicipalRegimeModel({
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

	FiscalMunicipalRegimeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		uf = FiscalMunicipalRegimeDomain.getUf(jsonData['uf']);
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['uf'] = FiscalMunicipalRegimeDomain.setUf(uf);
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

	FiscalMunicipalRegimeModel clone() {
		return FiscalMunicipalRegimeModel(
			id: id,
			uf: uf,
			codigo: codigo,
			nome: nome,
		);			
	}

	
}