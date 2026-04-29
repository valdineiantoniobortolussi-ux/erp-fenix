import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteFerroviarioFerroviaModel {
	int? id;
	int? idCteFerroviario;
	String? cnpj;
	String? codigoInterno;
	String? ie;
	String? nome;
	String? logradouro;
	String? numero;
	String? complemento;
	String? bairro;
	int? codigoMunicipio;
	String? nomeMunicipio;
	String? uf;
	String? cep;
	CteFerroviarioModel? cteFerroviarioModel;

	CteFerroviarioFerroviaModel({
		this.id,
		this.idCteFerroviario,
		this.cnpj,
		this.codigoInterno,
		this.ie,
		this.nome,
		this.logradouro,
		this.numero,
		this.complemento,
		this.bairro,
		this.codigoMunicipio,
		this.nomeMunicipio,
		this.uf,
		this.cep,
		this.cteFerroviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'codigo_interno',
		'ie',
		'nome',
		'logradouro',
		'numero',
		'complemento',
		'bairro',
		'codigo_municipio',
		'nome_municipio',
		'uf',
		'cep',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Codigo Interno',
		'Ie',
		'Nome',
		'Logradouro',
		'Numero',
		'Complemento',
		'Bairro',
		'Codigo Municipio',
		'Nome Municipio',
		'Uf',
		'Cep',
	];

	CteFerroviarioFerroviaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteFerroviario = jsonData['idCteFerroviario'];
		cnpj = jsonData['cnpj'];
		codigoInterno = jsonData['codigoInterno'];
		ie = jsonData['ie'];
		nome = jsonData['nome'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		uf = CteFerroviarioFerroviaDomain.getUf(jsonData['uf']);
		cep = jsonData['cep'];
		cteFerroviarioModel = jsonData['cteFerroviarioModel'] == null ? CteFerroviarioModel() : CteFerroviarioModel.fromJson(jsonData['cteFerroviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteFerroviario'] = idCteFerroviario != 0 ? idCteFerroviario : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['codigoInterno'] = codigoInterno;
		jsonData['ie'] = ie;
		jsonData['nome'] = nome;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['uf'] = CteFerroviarioFerroviaDomain.setUf(uf);
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['cteFerroviarioModel'] = cteFerroviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteFerroviario = plutoRow.cells['idCteFerroviario']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		codigoInterno = plutoRow.cells['codigoInterno']?.value;
		ie = plutoRow.cells['ie']?.value;
		nome = plutoRow.cells['nome']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		numero = plutoRow.cells['numero']?.value;
		complemento = plutoRow.cells['complemento']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		codigoMunicipio = plutoRow.cells['codigoMunicipio']?.value;
		nomeMunicipio = plutoRow.cells['nomeMunicipio']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		cep = plutoRow.cells['cep']?.value;
		cteFerroviarioModel = CteFerroviarioModel();
		cteFerroviarioModel?.fluxo = plutoRow.cells['cteFerroviarioModel']?.value;
	}	

	CteFerroviarioFerroviaModel clone() {
		return CteFerroviarioFerroviaModel(
			id: id,
			idCteFerroviario: idCteFerroviario,
			cnpj: cnpj,
			codigoInterno: codigoInterno,
			ie: ie,
			nome: nome,
			logradouro: logradouro,
			numero: numero,
			complemento: complemento,
			bairro: bairro,
			codigoMunicipio: codigoMunicipio,
			nomeMunicipio: nomeMunicipio,
			uf: uf,
			cep: cep,
		);			
	}

	
}