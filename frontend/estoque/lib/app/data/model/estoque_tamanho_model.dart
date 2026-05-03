import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class EstoqueTamanhoModel {
	int? id;
	String? codigo;
	String? nome;
	double? altura;
	double? comprimento;
	double? largura;

	EstoqueTamanhoModel({
		this.id,
		this.codigo,
		this.nome,
		this.altura,
		this.comprimento,
		this.largura,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
		'altura',
		'comprimento',
		'largura',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
		'Altura',
		'Comprimento',
		'Largura',
	];

	EstoqueTamanhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		nome = jsonData['nome'];
		altura = jsonData['altura']?.toDouble();
		comprimento = jsonData['comprimento']?.toDouble();
		largura = jsonData['largura']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['nome'] = nome;
		jsonData['altura'] = altura;
		jsonData['comprimento'] = comprimento;
		jsonData['largura'] = largura;
	
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
		altura = plutoRow.cells['altura']?.value?.toDouble();
		comprimento = plutoRow.cells['comprimento']?.value?.toDouble();
		largura = plutoRow.cells['largura']?.value?.toDouble();
	}	

	EstoqueTamanhoModel clone() {
		return EstoqueTamanhoModel(
			id: id,
			codigo: codigo,
			nome: nome,
			altura: altura,
			comprimento: comprimento,
			largura: largura,
		);			
	}

	
}