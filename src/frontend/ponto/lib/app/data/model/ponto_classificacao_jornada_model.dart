import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoClassificacaoJornadaModel {
	int? id;
	String? codigo;
	String? nome;
	String? descricao;
	String? padrao;
	String? descontarHoras;

	PontoClassificacaoJornadaModel({
		this.id,
		this.codigo,
		this.nome,
		this.descricao,
		this.padrao,
		this.descontarHoras,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'descricao',
		'padrao',
		'descontar_horas',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Descricao',
		'Padrao',
		'Descontar Horas',
	];

	PontoClassificacaoJornadaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		padrao = PontoClassificacaoJornadaDomain.getPadrao(jsonData['padrao']);
		descontarHoras = PontoClassificacaoJornadaDomain.getDescontarHoras(jsonData['descontarHoras']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['padrao'] = PontoClassificacaoJornadaDomain.setPadrao(padrao);
		jsonData['descontarHoras'] = PontoClassificacaoJornadaDomain.setDescontarHoras(descontarHoras);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		padrao = plutoRow.cells['padrao']?.value != '' ? plutoRow.cells['padrao']?.value : 'Sim';
		descontarHoras = plutoRow.cells['descontarHoras']?.value != '' ? plutoRow.cells['descontarHoras']?.value : 'Sim';
	}	

	PontoClassificacaoJornadaModel clone() {
		return PontoClassificacaoJornadaModel(
			id: id,
			codigo: codigo,
			nome: nome,
			descricao: descricao,
			padrao: padrao,
			descontarHoras: descontarHoras,
		);			
	}

	
}