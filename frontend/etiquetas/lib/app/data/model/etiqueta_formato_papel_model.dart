import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class EtiquetaFormatoPapelModel {
	int? id;
	String? nome;
	int? altura;
	int? largura;

	EtiquetaFormatoPapelModel({
		this.id,
		this.nome,
		this.altura,
		this.largura,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'altura',
		'largura',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Altura',
		'Largura',
	];

	EtiquetaFormatoPapelModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		altura = jsonData['altura'];
		largura = jsonData['largura'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['altura'] = altura;
		jsonData['largura'] = largura;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		altura = plutoRow.cells['altura']?.value;
		largura = plutoRow.cells['largura']?.value;
	}	

	EtiquetaFormatoPapelModel clone() {
		return EtiquetaFormatoPapelModel(
			id: id,
			nome: nome,
			altura: altura,
			largura: largura,
		);			
	}

	
}