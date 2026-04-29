import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class EsocialNaturezaJuridicaModel {
	int? id;
	int? grupo;
	String? codigo;
	String? descricao;

	EsocialNaturezaJuridicaModel({
		this.id,
		this.grupo,
		this.codigo,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'grupo',
		'codigo',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Grupo',
		'Codigo',
		'Descricao',
	];

	EsocialNaturezaJuridicaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		grupo = jsonData['grupo'];
		codigo = jsonData['codigo'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['grupo'] = grupo;
		jsonData['codigo'] = codigo;
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		grupo = plutoRow.cells['grupo']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	EsocialNaturezaJuridicaModel clone() {
		return EsocialNaturezaJuridicaModel(
			id: id,
			grupo: grupo,
			codigo: codigo,
			descricao: descricao,
		);			
	}

	
}