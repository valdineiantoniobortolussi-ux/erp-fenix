import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class PontoTurmaModel {
	int? id;
	int? idPontoEscala;
	String? codigo;
	String? nome;

	PontoTurmaModel({
		this.id,
		this.idPontoEscala,
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

	PontoTurmaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPontoEscala = jsonData['idPontoEscala'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPontoEscala'] = idPontoEscala != 0 ? idPontoEscala : null;
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
		idPontoEscala = plutoRow.cells['idPontoEscala']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		nome = plutoRow.cells['nome']?.value;
	}	

	PontoTurmaModel clone() {
		return PontoTurmaModel(
			id: id,
			idPontoEscala: idPontoEscala,
			codigo: codigo,
			nome: nome,
		);			
	}

	
}