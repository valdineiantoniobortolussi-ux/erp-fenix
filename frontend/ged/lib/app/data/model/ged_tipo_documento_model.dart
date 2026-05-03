import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class GedTipoDocumentoModel {
	int? id;
	String? nome;
	double? tamanhoMaximo;

	GedTipoDocumentoModel({
		this.id,
		this.nome,
		this.tamanhoMaximo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'tamanho_maximo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Tamanho Maximo',
	];

	GedTipoDocumentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		tamanhoMaximo = jsonData['tamanhoMaximo']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['tamanhoMaximo'] = tamanhoMaximo;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		tamanhoMaximo = plutoRow.cells['tamanhoMaximo']?.value?.toDouble();
	}	

	GedTipoDocumentoModel clone() {
		return GedTipoDocumentoModel(
			id: id,
			nome: nome,
			tamanhoMaximo: tamanhoMaximo,
		);			
	}

	
}