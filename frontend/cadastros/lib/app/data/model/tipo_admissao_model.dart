import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class TipoAdmissaoModel {
	int? id;
	String? codigo;
	String? nome;
	String? descricao;

	TipoAdmissaoModel({
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

	TipoAdmissaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
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
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	TipoAdmissaoModel clone() {
		return TipoAdmissaoModel(
			id: id,
			codigo: codigo,
			nome: nome,
			descricao: descricao,
		);			
	}

	
}