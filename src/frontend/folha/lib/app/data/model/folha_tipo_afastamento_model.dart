import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class FolhaTipoAfastamentoModel {
	int? id;
	String? codigo;
	String? nome;
	String? codigoEsocial;
	String? descricao;

	FolhaTipoAfastamentoModel({
		this.id,
		this.codigo,
		this.nome,
		this.codigoEsocial,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'codigo_esocial',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Codigo Esocial',
		'Descricao',
	];

	FolhaTipoAfastamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		codigoEsocial = jsonData['codigoEsocial'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['codigoEsocial'] = codigoEsocial;
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
		codigoEsocial = plutoRow.cells['codigoEsocial']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	FolhaTipoAfastamentoModel clone() {
		return FolhaTipoAfastamentoModel(
			id: id,
			codigo: codigo,
			nome: nome,
			codigoEsocial: codigoEsocial,
			descricao: descricao,
		);			
	}

	
}