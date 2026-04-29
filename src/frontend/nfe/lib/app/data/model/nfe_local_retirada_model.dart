import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeLocalRetiradaModel {
	int? id;
	int? idNfeCabecalho;
	String? cnpj;
	String? cpf;
	String? nomeExpedidor;
	String? logradouro;
	String? numero;
	String? complemento;
	String? bairro;
	int? codigoMunicipio;
	String? nomeMunicipio;
	String? uf;
	String? cep;
	int? codigoPais;
	String? nomePais;
	String? telefone;
	String? email;
	String? inscricaoEstadual;

	NfeLocalRetiradaModel({
		this.id,
		this.idNfeCabecalho,
		this.cnpj,
		this.cpf,
		this.nomeExpedidor,
		this.logradouro,
		this.numero,
		this.complemento,
		this.bairro,
		this.codigoMunicipio,
		this.nomeMunicipio,
		this.uf,
		this.cep,
		this.codigoPais,
		this.nomePais,
		this.telefone,
		this.email,
		this.inscricaoEstadual,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'cpf',
		'nome_expedidor',
		'logradouro',
		'numero',
		'complemento',
		'bairro',
		'codigo_municipio',
		'nome_municipio',
		'uf',
		'cep',
		'codigo_pais',
		'nome_pais',
		'telefone',
		'email',
		'inscricao_estadual',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Cpf',
		'Nome Expedidor',
		'Logradouro',
		'Numero',
		'Complemento',
		'Bairro',
		'Codigo Municipio',
		'Nome Municipio',
		'Uf',
		'Cep',
		'Codigo Pais',
		'Nome Pais',
		'Telefone',
		'Email',
		'Inscricao Estadual',
	];

	NfeLocalRetiradaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		cnpj = jsonData['cnpj'];
		cpf = jsonData['cpf'];
		nomeExpedidor = jsonData['nomeExpedidor'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		uf = NfeLocalRetiradaDomain.getUf(jsonData['uf']);
		cep = jsonData['cep'];
		codigoPais = jsonData['codigoPais'];
		nomePais = jsonData['nomePais'];
		telefone = jsonData['telefone'];
		email = jsonData['email'];
		inscricaoEstadual = jsonData['inscricaoEstadual'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['nomeExpedidor'] = nomeExpedidor;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['uf'] = NfeLocalRetiradaDomain.setUf(uf);
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['codigoPais'] = codigoPais;
		jsonData['nomePais'] = nomePais;
		jsonData['telefone'] = telefone;
		jsonData['email'] = email;
		jsonData['inscricaoEstadual'] = inscricaoEstadual;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		nomeExpedidor = plutoRow.cells['nomeExpedidor']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		numero = plutoRow.cells['numero']?.value;
		complemento = plutoRow.cells['complemento']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		codigoMunicipio = plutoRow.cells['codigoMunicipio']?.value;
		nomeMunicipio = plutoRow.cells['nomeMunicipio']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		cep = plutoRow.cells['cep']?.value;
		codigoPais = plutoRow.cells['codigoPais']?.value;
		nomePais = plutoRow.cells['nomePais']?.value;
		telefone = plutoRow.cells['telefone']?.value;
		email = plutoRow.cells['email']?.value;
		inscricaoEstadual = plutoRow.cells['inscricaoEstadual']?.value;
	}	

	NfeLocalRetiradaModel clone() {
		return NfeLocalRetiradaModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			cnpj: cnpj,
			cpf: cpf,
			nomeExpedidor: nomeExpedidor,
			logradouro: logradouro,
			numero: numero,
			complemento: complemento,
			bairro: bairro,
			codigoMunicipio: codigoMunicipio,
			nomeMunicipio: nomeMunicipio,
			uf: uf,
			cep: cep,
			codigoPais: codigoPais,
			nomePais: nomePais,
			telefone: telefone,
			email: email,
			inscricaoEstadual: inscricaoEstadual,
		);			
	}

	
}