import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class GondolaRuaModel {
	int? id;
	String? codigo;
	int? quantidadeEstante;
	String? nome;

	GondolaRuaModel({
		this.id,
		this.codigo,
		this.quantidadeEstante,
		this.nome,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'quantidade_estante',
		'nome',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Quantidade Estante',
		'Nome',
	];

	GondolaRuaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		quantidadeEstante = jsonData['quantidadeEstante'];
		nome = jsonData['nome'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['quantidadeEstante'] = quantidadeEstante;
		jsonData['nome'] = nome;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		quantidadeEstante = plutoRow.cells['quantidadeEstante']?.value;
		nome = plutoRow.cells['nome']?.value;
	}	

	GondolaRuaModel clone() {
		return GondolaRuaModel(
			id: id,
			codigo: codigo,
			quantidadeEstante: quantidadeEstante,
			nome: nome,
		);			
	}

	
}