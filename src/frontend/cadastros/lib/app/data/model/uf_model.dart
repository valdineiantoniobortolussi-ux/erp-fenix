import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class UfModel {
	int? id;
	String? nome;
	String? sigla;
	int? codigoIbge;

	UfModel({
		this.id,
		this.nome,
		this.sigla,
		this.codigoIbge,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'sigla',
		'codigo_ibge',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Sigla',
		'Codigo Ibge',
	];

	UfModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		sigla = jsonData['sigla'];
		codigoIbge = jsonData['codigoIbge'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['sigla'] = sigla;
		jsonData['codigoIbge'] = codigoIbge;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		sigla = plutoRow.cells['sigla']?.value;
		codigoIbge = plutoRow.cells['codigoIbge']?.value;
	}	

	UfModel clone() {
		return UfModel(
			id: id,
			nome: nome,
			sigla: sigla,
			codigoIbge: codigoIbge,
		);			
	}

	
}