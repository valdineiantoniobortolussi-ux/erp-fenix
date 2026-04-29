import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class EstadoCivilModel {
	int? id;
	String? nome;
	String? descricao;

	EstadoCivilModel({
		this.id,
		this.nome,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
	];

	EstadoCivilModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
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
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	EstadoCivilModel clone() {
		return EstadoCivilModel(
			id: id,
			nome: nome,
			descricao: descricao,
		);			
	}

	
}