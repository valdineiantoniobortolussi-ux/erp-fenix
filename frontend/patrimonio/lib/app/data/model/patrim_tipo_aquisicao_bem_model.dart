import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/data/domain/domain_imports.dart';

class PatrimTipoAquisicaoBemModel {
	int? id;
	String? tipo;
	String? nome;
	String? descricao;

	PatrimTipoAquisicaoBemModel({
		this.id,
		this.tipo,
		this.nome,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo',
		'nome',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo',
		'Nome',
		'Descricao',
	];

	PatrimTipoAquisicaoBemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		tipo = PatrimTipoAquisicaoBemDomain.getTipo(jsonData['tipo']);
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['tipo'] = PatrimTipoAquisicaoBemDomain.setTipo(tipo);
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : '1=Compra';
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	PatrimTipoAquisicaoBemModel clone() {
		return PatrimTipoAquisicaoBemModel(
			id: id,
			tipo: tipo,
			nome: nome,
			descricao: descricao,
		);			
	}

	
}