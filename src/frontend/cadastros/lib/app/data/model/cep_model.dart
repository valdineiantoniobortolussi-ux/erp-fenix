import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/domain/domain_imports.dart';

class CepModel {
	int? id;
	String? numero;
	String? logradouro;
	String? complemento;
	String? bairro;
	String? municipio;
	String? uf;
	int? codigoIbgeMunicipio;

	CepModel({
		this.id,
		this.numero,
		this.logradouro,
		this.complemento,
		this.bairro,
		this.municipio,
		this.uf,
		this.codigoIbgeMunicipio,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'logradouro',
		'complemento',
		'bairro',
		'municipio',
		'uf',
		'codigo_ibge_municipio',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Logradouro',
		'Complemento',
		'Bairro',
		'Municipio',
		'Uf',
		'Codigo Ibge Municipio',
	];

	CepModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		numero = jsonData['numero'];
		logradouro = jsonData['logradouro'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		municipio = jsonData['municipio'];
		uf = CepDomain.getUf(jsonData['uf']);
		codigoIbgeMunicipio = jsonData['codigoIbgeMunicipio'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['numero'] = numero;
		jsonData['logradouro'] = logradouro;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['municipio'] = municipio;
		jsonData['uf'] = CepDomain.setUf(uf);
		jsonData['codigoIbgeMunicipio'] = codigoIbgeMunicipio;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		numero = plutoRow.cells['numero']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		complemento = plutoRow.cells['complemento']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		municipio = plutoRow.cells['municipio']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		codigoIbgeMunicipio = plutoRow.cells['codigoIbgeMunicipio']?.value;
	}	

	CepModel clone() {
		return CepModel(
			id: id,
			numero: numero,
			logradouro: logradouro,
			complemento: complemento,
			bairro: bairro,
			municipio: municipio,
			uf: uf,
			codigoIbgeMunicipio: codigoIbgeMunicipio,
		);			
	}

	
}