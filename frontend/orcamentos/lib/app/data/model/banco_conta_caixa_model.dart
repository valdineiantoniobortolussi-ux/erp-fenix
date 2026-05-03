import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:orcamentos/app/data/domain/domain_imports.dart';

class BancoContaCaixaModel {
	int? id;
	String? numero;
	String? digito;
	String? nome;
	String? tipo;
	String? descricao;

	BancoContaCaixaModel({
		this.id,
		this.numero,
		this.digito,
		this.nome,
		this.tipo,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'digito',
		'nome',
		'tipo',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Digito',
		'Nome',
		'Tipo',
		'Descricao',
	];

	BancoContaCaixaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		numero = jsonData['numero'];
		digito = BancoContaCaixaDomain.getDigito(jsonData['digito']);
		nome = jsonData['nome'];
		tipo = BancoContaCaixaDomain.getTipo(jsonData['tipo']);
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['numero'] = numero;
		jsonData['digito'] = BancoContaCaixaDomain.setDigito(digito);
		jsonData['nome'] = nome;
		jsonData['tipo'] = BancoContaCaixaDomain.setTipo(tipo);
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		numero = plutoRow.cells['numero']?.value;
		digito = plutoRow.cells['digito']?.value != '' ? plutoRow.cells['digito']?.value : 'AAA';
		nome = plutoRow.cells['nome']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'AAA';
		descricao = plutoRow.cells['descricao']?.value;
	}	

	BancoContaCaixaModel clone() {
		return BancoContaCaixaModel(
			id: id,
			numero: numero,
			digito: digito,
			nome: nome,
			tipo: tipo,
			descricao: descricao,
		);			
	}

	
}