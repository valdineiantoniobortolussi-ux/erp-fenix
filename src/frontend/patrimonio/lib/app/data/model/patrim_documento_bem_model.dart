import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class PatrimDocumentoBemModel {
	int? id;
	int? idPatrimBem;
	String? nome;
	String? descricao;
	String? imagem;

	PatrimDocumentoBemModel({
		this.id,
		this.idPatrimBem,
		this.nome,
		this.descricao,
		this.imagem,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
		'imagem',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
		'Imagem',
	];

	PatrimDocumentoBemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPatrimBem = jsonData['idPatrimBem'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		imagem = jsonData['imagem'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPatrimBem'] = idPatrimBem != 0 ? idPatrimBem : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['imagem'] = imagem;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPatrimBem = plutoRow.cells['idPatrimBem']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		imagem = plutoRow.cells['imagem']?.value;
	}	

	PatrimDocumentoBemModel clone() {
		return PatrimDocumentoBemModel(
			id: id,
			idPatrimBem: idPatrimBem,
			nome: nome,
			descricao: descricao,
			imagem: imagem,
		);			
	}

	
}