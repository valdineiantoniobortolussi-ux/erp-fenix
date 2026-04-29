import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/data/domain/domain_imports.dart';

class PatrimEstadoConservacaoModel {
	int? id;
	String? codigo;
	String? nome;
	String? descricao;

	PatrimEstadoConservacaoModel({
		this.id,
		this.codigo,
		this.nome,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Descricao',
	];

	PatrimEstadoConservacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = PatrimEstadoConservacaoDomain.getCodigo(jsonData['codigo']);
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = PatrimEstadoConservacaoDomain.setCodigo(codigo);
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
		codigo = plutoRow.cells['codigo']?.value != '' ? plutoRow.cells['codigo']?.value : '1=Novo';
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	PatrimEstadoConservacaoModel clone() {
		return PatrimEstadoConservacaoModel(
			id: id,
			codigo: codigo,
			nome: nome,
			descricao: descricao,
		);			
	}

	
}