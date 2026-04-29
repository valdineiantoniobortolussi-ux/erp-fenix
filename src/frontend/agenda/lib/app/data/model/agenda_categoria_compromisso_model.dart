import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class AgendaCategoriaCompromissoModel {
	int? id;
	String? nome;
	String? cor;

	AgendaCategoriaCompromissoModel({
		this.id,
		this.nome,
		this.cor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'cor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Cor',
	];

	AgendaCategoriaCompromissoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		cor = jsonData['cor'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['cor'] = cor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		cor = plutoRow.cells['cor']?.value;
	}	

	AgendaCategoriaCompromissoModel clone() {
		return AgendaCategoriaCompromissoModel(
			id: id,
			nome: nome,
			cor: cor,
		);			
	}

	
}