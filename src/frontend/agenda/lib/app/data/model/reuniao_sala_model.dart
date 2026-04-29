import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class ReuniaoSalaModel {
	int? id;
	String? predio;
	String? nome;
	String? andar;
	String? numero;

	ReuniaoSalaModel({
		this.id,
		this.predio,
		this.nome,
		this.andar,
		this.numero,
	});

	static List<String> dbColumns = <String>[
		'id',
		'predio',
		'nome',
		'andar',
		'numero',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Predio',
		'Nome',
		'Andar',
		'Numero',
	];

	ReuniaoSalaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		predio = jsonData['predio'];
		nome = jsonData['nome'];
		andar = jsonData['andar'];
		numero = jsonData['numero'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['predio'] = predio;
		jsonData['nome'] = nome;
		jsonData['andar'] = andar;
		jsonData['numero'] = numero;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		predio = plutoRow.cells['predio']?.value;
		nome = plutoRow.cells['nome']?.value;
		andar = plutoRow.cells['andar']?.value;
		numero = plutoRow.cells['numero']?.value;
	}	

	ReuniaoSalaModel clone() {
		return ReuniaoSalaModel(
			id: id,
			predio: predio,
			nome: nome,
			andar: andar,
			numero: numero,
		);			
	}

	
}