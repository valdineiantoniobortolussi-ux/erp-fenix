import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoRelogioModel {
	int? id;
	String? localizacao;
	String? marca;
	String? fabricante;
	String? numeroSerie;
	String? utilizacao;

	PontoRelogioModel({
		this.id,
		this.localizacao,
		this.marca,
		this.fabricante,
		this.numeroSerie,
		this.utilizacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'localizacao',
		'marca',
		'fabricante',
		'numero_serie',
		'utilizacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Localizacao',
		'Marca',
		'Fabricante',
		'Numero Serie',
		'Utilizacao',
	];

	PontoRelogioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		localizacao = jsonData['localizacao'];
		marca = jsonData['marca'];
		fabricante = jsonData['fabricante'];
		numeroSerie = jsonData['numeroSerie'];
		utilizacao = PontoRelogioDomain.getUtilizacao(jsonData['utilizacao']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['localizacao'] = localizacao;
		jsonData['marca'] = marca;
		jsonData['fabricante'] = fabricante;
		jsonData['numeroSerie'] = numeroSerie;
		jsonData['utilizacao'] = PontoRelogioDomain.setUtilizacao(utilizacao);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		localizacao = plutoRow.cells['localizacao']?.value;
		marca = plutoRow.cells['marca']?.value;
		fabricante = plutoRow.cells['fabricante']?.value;
		numeroSerie = plutoRow.cells['numeroSerie']?.value;
		utilizacao = plutoRow.cells['utilizacao']?.value != '' ? plutoRow.cells['utilizacao']?.value : 'Ponto';
	}	

	PontoRelogioModel clone() {
		return PontoRelogioModel(
			id: id,
			localizacao: localizacao,
			marca: marca,
			fabricante: fabricante,
			numeroSerie: numeroSerie,
			utilizacao: utilizacao,
		);			
	}

	
}