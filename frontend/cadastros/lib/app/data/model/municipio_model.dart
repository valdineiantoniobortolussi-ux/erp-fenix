import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/model/model_imports.dart';

class MunicipioModel {
	int? id;
	int? idUf;
	String? nome;
	int? codigoIbge;
	int? codigoReceitaFederal;
	int? codigoEstadual;
	UfModel? ufModel;

	MunicipioModel({
		this.id,
		this.idUf,
		this.nome,
		this.codigoIbge,
		this.codigoReceitaFederal,
		this.codigoEstadual,
		this.ufModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'codigo_ibge',
		'codigo_receita_federal',
		'codigo_estadual',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Codigo Ibge',
		'Codigo Receita Federal',
		'Codigo Estadual',
	];

	MunicipioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idUf = jsonData['idUf'];
		nome = jsonData['nome'];
		codigoIbge = jsonData['codigoIbge'];
		codigoReceitaFederal = jsonData['codigoReceitaFederal'];
		codigoEstadual = jsonData['codigoEstadual'];
		ufModel = jsonData['ufModel'] == null ? UfModel() : UfModel.fromJson(jsonData['ufModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idUf'] = idUf != 0 ? idUf : null;
		jsonData['nome'] = nome;
		jsonData['codigoIbge'] = codigoIbge;
		jsonData['codigoReceitaFederal'] = codigoReceitaFederal;
		jsonData['codigoEstadual'] = codigoEstadual;
		jsonData['ufModel'] = ufModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idUf = plutoRow.cells['idUf']?.value;
		nome = plutoRow.cells['nome']?.value;
		codigoIbge = plutoRow.cells['codigoIbge']?.value;
		codigoReceitaFederal = plutoRow.cells['codigoReceitaFederal']?.value;
		codigoEstadual = plutoRow.cells['codigoEstadual']?.value;
		ufModel = UfModel();
		ufModel?.sigla = plutoRow.cells['ufModel']?.value;
	}	

	MunicipioModel clone() {
		return MunicipioModel(
			id: id,
			idUf: idUf,
			nome: nome,
			codigoIbge: codigoIbge,
			codigoReceitaFederal: codigoReceitaFederal,
			codigoEstadual: codigoEstadual,
		);			
	}

	
}