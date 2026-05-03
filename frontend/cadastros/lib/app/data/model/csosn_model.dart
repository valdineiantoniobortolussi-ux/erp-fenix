import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CsosnModel {
	int? id;
	String? codigo;
	String? descricao;
	String? observacao;

	CsosnModel({
		this.id,
		this.codigo,
		this.descricao,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'descricao',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Descricao',
		'Observacao',
	];

	CsosnModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		descricao = jsonData['descricao'];
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['descricao'] = descricao;
		jsonData['observacao'] = observacao;
	
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
		observacao = plutoRow.cells['observacao']?.value;
	}	

	CsosnModel clone() {
		return CsosnModel(
			id: id,
			codigo: codigo,
			descricao: descricao,
			observacao: observacao,
		);			
	}

	
}