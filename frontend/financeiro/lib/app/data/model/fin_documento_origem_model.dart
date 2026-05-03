import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class FinDocumentoOrigemModel {
	int? id;
	String? codigo;
	String? sigla;
	String? descricao;

	FinDocumentoOrigemModel({
		this.id,
		this.codigo,
		this.sigla,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'sigla',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Sigla',
		'Descricao',
	];

	FinDocumentoOrigemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		sigla = jsonData['sigla'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['sigla'] = sigla;
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
		sigla = plutoRow.cells['sigla']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	FinDocumentoOrigemModel clone() {
		return FinDocumentoOrigemModel(
			id: id,
			codigo: codigo,
			sigla: sigla,
			descricao: descricao,
		);			
	}

	
}