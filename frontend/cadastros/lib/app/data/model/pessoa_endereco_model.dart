import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class PessoaEnderecoModel {
	int? id;
	int? idPessoa;
	String? logradouro;
	String? numero;
	String? complemento;
	String? bairro;
	String? cidade;
	String? uf;
	String? cep;
	int? municipioIbge;
	String? principal;
	String? entrega;
	String? cobranca;
	String? correspondencia;

	PessoaEnderecoModel({
		this.id,
		this.idPessoa,
		this.logradouro,
		this.numero,
		this.complemento,
		this.bairro,
		this.cidade,
		this.uf,
		this.cep,
		this.municipioIbge,
		this.principal,
		this.entrega,
		this.cobranca,
		this.correspondencia,
	});

	static List<String> dbColumns = <String>[
		'id',
		'logradouro',
		'numero',
		'complemento',
		'bairro',
		'cidade',
		'uf',
		'cep',
		'municipio_ibge',
		'principal',
		'entrega',
		'cobranca',
		'correspondencia',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Logradouro',
		'Numero',
		'Complemento',
		'Bairro',
		'Cidade',
		'Uf',
		'Cep',
		'Municipio Ibge',
		'Principal',
		'Entrega',
		'Cobranca',
		'Correspondencia',
	];

	PessoaEnderecoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		cidade = jsonData['cidade'];
		uf = PessoaEnderecoDomain.getUf(jsonData['uf']);
		cep = jsonData['cep'];
		municipioIbge = jsonData['municipioIbge'];
		principal = PessoaEnderecoDomain.getPrincipal(jsonData['principal']);
		entrega = PessoaEnderecoDomain.getEntrega(jsonData['entrega']);
		cobranca = PessoaEnderecoDomain.getCobranca(jsonData['cobranca']);
		correspondencia = PessoaEnderecoDomain.getCorrespondencia(jsonData['correspondencia']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['cidade'] = cidade;
		jsonData['uf'] = PessoaEnderecoDomain.setUf(uf);
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['municipioIbge'] = municipioIbge;
		jsonData['principal'] = PessoaEnderecoDomain.setPrincipal(principal);
		jsonData['entrega'] = PessoaEnderecoDomain.setEntrega(entrega);
		jsonData['cobranca'] = PessoaEnderecoDomain.setCobranca(cobranca);
		jsonData['correspondencia'] = PessoaEnderecoDomain.setCorrespondencia(correspondencia);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		numero = plutoRow.cells['numero']?.value;
		complemento = plutoRow.cells['complemento']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		cidade = plutoRow.cells['cidade']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		cep = plutoRow.cells['cep']?.value;
		municipioIbge = plutoRow.cells['municipioIbge']?.value;
		principal = plutoRow.cells['principal']?.value != '' ? plutoRow.cells['principal']?.value : 'Sim';
		entrega = plutoRow.cells['entrega']?.value != '' ? plutoRow.cells['entrega']?.value : 'Sim';
		cobranca = plutoRow.cells['cobranca']?.value != '' ? plutoRow.cells['cobranca']?.value : 'Sim';
		correspondencia = plutoRow.cells['correspondencia']?.value != '' ? plutoRow.cells['correspondencia']?.value : 'Sim';
	}	

	PessoaEnderecoModel clone() {
		return PessoaEnderecoModel(
			id: id,
			idPessoa: idPessoa,
			logradouro: logradouro,
			numero: numero,
			complemento: complemento,
			bairro: bairro,
			cidade: cidade,
			uf: uf,
			cep: cep,
			municipioIbge: municipioIbge,
			principal: principal,
			entrega: entrega,
			cobranca: cobranca,
			correspondencia: correspondencia,
		);			
	}

	
}