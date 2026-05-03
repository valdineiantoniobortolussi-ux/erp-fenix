import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteDestinatarioModel {
	int? id;
	int? idCteCabecalho;
	String? cnpj;
	String? cpf;
	String? ie;
	String? nome;
	String? fantasia;
	String? telefone;
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
	String? email;

	CteDestinatarioModel({
		this.id,
		this.idCteCabecalho,
		this.cnpj,
		this.cpf,
		this.ie,
		this.nome,
		this.fantasia,
		this.telefone,
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
		this.email,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'cpf',
		'ie',
		'nome',
		'fantasia',
		'telefone',
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
		'email',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Cpf',
		'Ie',
		'Nome',
		'Fantasia',
		'Telefone',
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
		'Email',
	];

	CteDestinatarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		cnpj = jsonData['cnpj'];
		cpf = jsonData['cpf'];
		ie = jsonData['ie'];
		nome = jsonData['nome'];
		fantasia = jsonData['fantasia'];
		telefone = jsonData['telefone'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		uf = CteDestinatarioDomain.getUf(jsonData['uf']);
		cep = jsonData['cep'];
		codigoPais = jsonData['codigoPais'];
		nomePais = jsonData['nomePais'];
		email = jsonData['email'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['ie'] = ie;
		jsonData['nome'] = nome;
		jsonData['fantasia'] = fantasia;
		jsonData['telefone'] = telefone;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['uf'] = CteDestinatarioDomain.setUf(uf);
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['codigoPais'] = codigoPais;
		jsonData['nomePais'] = nomePais;
		jsonData['email'] = email;
	
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
		ie = plutoRow.cells['ie']?.value;
		nome = plutoRow.cells['nome']?.value;
		fantasia = plutoRow.cells['fantasia']?.value;
		telefone = plutoRow.cells['telefone']?.value;
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
		email = plutoRow.cells['email']?.value;
	}	

	CteDestinatarioModel clone() {
		return CteDestinatarioModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			cnpj: cnpj,
			cpf: cpf,
			ie: ie,
			nome: nome,
			fantasia: fantasia,
			telefone: telefone,
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
			email: email,
		);			
	}

	
}