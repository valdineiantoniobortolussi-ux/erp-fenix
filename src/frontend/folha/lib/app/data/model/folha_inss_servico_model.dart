import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class FolhaInssServicoModel {
	int? id;
	String? codigo;
	String? nome;

	FolhaInssServicoModel({
		this.id,
		this.codigo,
		this.nome,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
	];

	FolhaInssServicoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
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
		nome = plutoRow.cells['nome']?.value;
	}	

	FolhaInssServicoModel clone() {
		return FolhaInssServicoModel(
			id: id,
			codigo: codigo,
			nome: nome,
		);			
	}

	
}