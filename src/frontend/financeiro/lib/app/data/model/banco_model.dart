import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class BancoModel {
	int? id;
	String? codigo;
	String? nome;
	String? url;

	BancoModel({
		this.id,
		this.codigo,
		this.nome,
		this.url,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'url',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Url',
	];

	BancoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		url = jsonData['url'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['url'] = url;
	
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
		url = plutoRow.cells['url']?.value;
	}	

	BancoModel clone() {
		return BancoModel(
			id: id,
			codigo: codigo,
			nome: nome,
			url: url,
		);			
	}

	
}