import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/domain/domain_imports.dart';

class TabelaPrecoModel {
	int? id;
	String? nome;
	String? principal;
	double? coeficiente;

	TabelaPrecoModel({
		this.id,
		this.nome,
		this.principal,
		this.coeficiente,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'principal',
		'coeficiente',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Principal',
		'Coeficiente',
	];

	TabelaPrecoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		principal = TabelaPrecoDomain.getPrincipal(jsonData['principal']);
		coeficiente = jsonData['coeficiente']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['principal'] = TabelaPrecoDomain.setPrincipal(principal);
		jsonData['coeficiente'] = coeficiente;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		principal = plutoRow.cells['principal']?.value != '' ? plutoRow.cells['principal']?.value : 'Sim';
		coeficiente = plutoRow.cells['coeficiente']?.value?.toDouble();
	}	

	TabelaPrecoModel clone() {
		return TabelaPrecoModel(
			id: id,
			nome: nome,
			principal: principal,
			coeficiente: coeficiente,
		);			
	}

	
}