import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class PatrimIndiceAtualizacaoModel {
	int? id;
	DateTime? dataIndice;
	String? nome;
	double? valor;
	double? valorAlternativo;

	PatrimIndiceAtualizacaoModel({
		this.id,
		this.dataIndice,
		this.nome,
		this.valor,
		this.valorAlternativo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_indice',
		'nome',
		'valor',
		'valor_alternativo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Indice',
		'Nome',
		'Valor',
		'Valor Alternativo',
	];

	PatrimIndiceAtualizacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataIndice = jsonData['dataIndice'] != null ? DateTime.tryParse(jsonData['dataIndice']) : null;
		nome = jsonData['nome'];
		valor = jsonData['valor']?.toDouble();
		valorAlternativo = jsonData['valorAlternativo']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataIndice'] = dataIndice != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataIndice!) : null;
		jsonData['nome'] = nome;
		jsonData['valor'] = valor;
		jsonData['valorAlternativo'] = valorAlternativo;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		dataIndice = Util.stringToDate(plutoRow.cells['dataIndice']?.value);
		nome = plutoRow.cells['nome']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
		valorAlternativo = plutoRow.cells['valorAlternativo']?.value?.toDouble();
	}	

	PatrimIndiceAtualizacaoModel clone() {
		return PatrimIndiceAtualizacaoModel(
			id: id,
			dataIndice: dataIndice,
			nome: nome,
			valor: valor,
			valorAlternativo: valorAlternativo,
		);			
	}

	
}