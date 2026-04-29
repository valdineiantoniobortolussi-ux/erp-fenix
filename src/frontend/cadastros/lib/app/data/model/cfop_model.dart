import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CfopModel {
	int? id;
	int? codigo;
	String? descricao;
	String? aplicacao;

	CfopModel({
		this.id,
		this.codigo,
		this.descricao,
		this.aplicacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'descricao',
		'aplicacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Descricao',
		'Aplicacao',
	];

	CfopModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		descricao = jsonData['descricao'];
		aplicacao = jsonData['aplicacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['descricao'] = descricao;
		jsonData['aplicacao'] = aplicacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		aplicacao = plutoRow.cells['aplicacao']?.value;
	}	

	CfopModel clone() {
		return CfopModel(
			id: id,
			codigo: codigo,
			descricao: descricao,
			aplicacao: aplicacao,
		);			
	}

	
}