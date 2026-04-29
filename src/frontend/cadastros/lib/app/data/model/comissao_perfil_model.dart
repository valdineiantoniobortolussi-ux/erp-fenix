import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/domain/domain_imports.dart';

class ComissaoPerfilModel {
	int? id;
	String? codigo;
	String? nome;

	ComissaoPerfilModel({
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

	ComissaoPerfilModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = ComissaoPerfilDomain.getCodigo(jsonData['codigo']);
		nome = jsonData['nome'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = ComissaoPerfilDomain.setCodigo(codigo);
		jsonData['nome'] = nome;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value != '' ? plutoRow.cells['codigo']?.value : 'AAA';
		nome = plutoRow.cells['nome']?.value;
	}	

	ComissaoPerfilModel clone() {
		return ComissaoPerfilModel(
			id: id,
			codigo: codigo,
			nome: nome,
		);			
	}

	
}