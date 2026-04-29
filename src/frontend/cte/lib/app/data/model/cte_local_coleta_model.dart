import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteLocalColetaModel {
	int? id;
	int? idCteCabecalho;
	String? cnpj;
	String? cpf;
	String? nome;
	String? logradouro;
	String? numero;
	String? complemento;
	String? bairro;
	int? codigoMunicipio;
	String? nomeMunicipio;
	String? uf;

	CteLocalColetaModel({
		this.id,
		this.idCteCabecalho,
		this.cnpj,
		this.cpf,
		this.nome,
		this.logradouro,
		this.numero,
		this.complemento,
		this.bairro,
		this.codigoMunicipio,
		this.nomeMunicipio,
		this.uf,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'cpf',
		'nome',
		'logradouro',
		'numero',
		'complemento',
		'bairro',
		'codigo_municipio',
		'nome_municipio',
		'uf',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Cpf',
		'Nome',
		'Logradouro',
		'Numero',
		'Complemento',
		'Bairro',
		'Codigo Municipio',
		'Nome Municipio',
		'Uf',
	];

	CteLocalColetaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		cnpj = jsonData['cnpj'];
		cpf = jsonData['cpf'];
		nome = jsonData['nome'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		uf = CteLocalColetaDomain.getUf(jsonData['uf']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['nome'] = nome;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['uf'] = CteLocalColetaDomain.setUf(uf);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		nome = plutoRow.cells['nome']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		numero = plutoRow.cells['numero']?.value;
		complemento = plutoRow.cells['complemento']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		codigoMunicipio = plutoRow.cells['codigoMunicipio']?.value;
		nomeMunicipio = plutoRow.cells['nomeMunicipio']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
	}	

	CteLocalColetaModel clone() {
		return CteLocalColetaModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			cnpj: cnpj,
			cpf: cpf,
			nome: nome,
			logradouro: logradouro,
			numero: numero,
			complemento: complemento,
			bairro: bairro,
			codigoMunicipio: codigoMunicipio,
			nomeMunicipio: nomeMunicipio,
			uf: uf,
		);			
	}

	
}