import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';

class SeguradoraModel {
	int? id;
	String? nome;
	String? contato;
	String? telefone;

	SeguradoraModel({
		this.id,
		this.nome,
		this.contato,
		this.telefone,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'contato',
		'telefone',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Contato',
		'Telefone',
	];

	SeguradoraModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		contato = jsonData['contato'];
		telefone = jsonData['telefone'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['contato'] = contato;
		jsonData['telefone'] = Util.removeMask(telefone);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		contato = plutoRow.cells['contato']?.value;
		telefone = plutoRow.cells['telefone']?.value;
	}	

	SeguradoraModel clone() {
		return SeguradoraModel(
			id: id,
			nome: nome,
			contato: contato,
			telefone: telefone,
		);			
	}

	
}