import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/domain/domain_imports.dart';

class MdfeEmitenteModel {
	int? id;
	int? idMdfeCabecalho;
	String? nome;
	String? fantasia;
	String? cnpj;
	int? ie;
	String? logradouro;
	String? numero;
	String? complemento;
	String? bairro;
	String? codigoMunicipio;
	String? nomeMunicipio;
	String? cep;
	String? uf;
	String? telefone;
	String? email;

	MdfeEmitenteModel({
		this.id,
		this.idMdfeCabecalho,
		this.nome,
		this.fantasia,
		this.cnpj,
		this.ie,
		this.logradouro,
		this.numero,
		this.complemento,
		this.bairro,
		this.codigoMunicipio,
		this.nomeMunicipio,
		this.cep,
		this.uf,
		this.telefone,
		this.email,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'fantasia',
		'cnpj',
		'ie',
		'logradouro',
		'numero',
		'complemento',
		'bairro',
		'codigo_municipio',
		'nome_municipio',
		'cep',
		'uf',
		'telefone',
		'email',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Fantasia',
		'Cnpj',
		'Ie',
		'Logradouro',
		'Numero',
		'Complemento',
		'Bairro',
		'Codigo Municipio',
		'Nome Municipio',
		'Cep',
		'Uf',
		'Telefone',
		'Email',
	];

	MdfeEmitenteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeCabecalho = jsonData['idMdfeCabecalho'];
		nome = jsonData['nome'];
		fantasia = jsonData['fantasia'];
		cnpj = jsonData['cnpj'];
		ie = jsonData['ie'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		cep = jsonData['cep'];
		uf = MdfeEmitenteDomain.getUf(jsonData['uf']);
		telefone = jsonData['telefone'];
		email = jsonData['email'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeCabecalho'] = idMdfeCabecalho != 0 ? idMdfeCabecalho : null;
		jsonData['nome'] = nome;
		jsonData['fantasia'] = fantasia;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['ie'] = ie;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['uf'] = MdfeEmitenteDomain.setUf(uf);
		jsonData['telefone'] = Util.removeMask(telefone);
		jsonData['email'] = email;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeCabecalho = plutoRow.cells['idMdfeCabecalho']?.value;
		nome = plutoRow.cells['nome']?.value;
		fantasia = plutoRow.cells['fantasia']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		ie = plutoRow.cells['ie']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		numero = plutoRow.cells['numero']?.value;
		complemento = plutoRow.cells['complemento']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		codigoMunicipio = plutoRow.cells['codigoMunicipio']?.value;
		nomeMunicipio = plutoRow.cells['nomeMunicipio']?.value;
		cep = plutoRow.cells['cep']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		telefone = plutoRow.cells['telefone']?.value;
		email = plutoRow.cells['email']?.value;
	}	

	MdfeEmitenteModel clone() {
		return MdfeEmitenteModel(
			id: id,
			idMdfeCabecalho: idMdfeCabecalho,
			nome: nome,
			fantasia: fantasia,
			cnpj: cnpj,
			ie: ie,
			logradouro: logradouro,
			numero: numero,
			complemento: complemento,
			bairro: bairro,
			codigoMunicipio: codigoMunicipio,
			nomeMunicipio: nomeMunicipio,
			cep: cep,
			uf: uf,
			telefone: telefone,
			email: email,
		);			
	}

	
}