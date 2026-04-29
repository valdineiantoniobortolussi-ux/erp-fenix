import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeEmitenteModel {
	int? id;
	int? idNfeCabecalho;
	String? cnpj;
	String? cpf;
	String? nome;
	String? fantasia;
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
	String? inscricaoEstadual;
	String? inscricaoEstadualSt;
	String? inscricaoMunicipal;
	String? cnae;
	String? crt;

	NfeEmitenteModel({
		this.id,
		this.idNfeCabecalho,
		this.cnpj,
		this.cpf,
		this.nome,
		this.fantasia,
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
		this.inscricaoEstadual,
		this.inscricaoEstadualSt,
		this.inscricaoMunicipal,
		this.cnae,
		this.crt,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'cpf',
		'nome',
		'fantasia',
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
		'inscricao_estadual',
		'inscricao_estadual_st',
		'inscricao_municipal',
		'cnae',
		'crt',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Cpf',
		'Nome',
		'Fantasia',
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
		'Inscricao Estadual',
		'Inscricao Estadual St',
		'Inscricao Municipal',
		'Cnae',
		'Crt',
	];

	NfeEmitenteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		cnpj = jsonData['cnpj'];
		cpf = jsonData['cpf'];
		nome = jsonData['nome'];
		fantasia = jsonData['fantasia'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		uf = NfeEmitenteDomain.getUf(jsonData['uf']);
		cep = jsonData['cep'];
		codigoPais = jsonData['codigoPais'];
		nomePais = jsonData['nomePais'];
		telefone = jsonData['telefone'];
		inscricaoEstadual = jsonData['inscricaoEstadual'];
		inscricaoEstadualSt = jsonData['inscricaoEstadualSt'];
		inscricaoMunicipal = jsonData['inscricaoMunicipal'];
		cnae = jsonData['cnae'];
		crt = NfeEmitenteDomain.getCrt(jsonData['crt']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['nome'] = nome;
		jsonData['fantasia'] = fantasia;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['uf'] = NfeEmitenteDomain.setUf(uf);
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['codigoPais'] = codigoPais;
		jsonData['nomePais'] = nomePais;
		jsonData['telefone'] = telefone;
		jsonData['inscricaoEstadual'] = inscricaoEstadual;
		jsonData['inscricaoEstadualSt'] = inscricaoEstadualSt;
		jsonData['inscricaoMunicipal'] = inscricaoMunicipal;
		jsonData['cnae'] = cnae;
		jsonData['crt'] = NfeEmitenteDomain.setCrt(crt);
	
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
		nome = plutoRow.cells['nome']?.value;
		fantasia = plutoRow.cells['fantasia']?.value;
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
		inscricaoEstadual = plutoRow.cells['inscricaoEstadual']?.value;
		inscricaoEstadualSt = plutoRow.cells['inscricaoEstadualSt']?.value;
		inscricaoMunicipal = plutoRow.cells['inscricaoMunicipal']?.value;
		cnae = plutoRow.cells['cnae']?.value;
		crt = plutoRow.cells['crt']?.value != '' ? plutoRow.cells['crt']?.value : 'AAA';
	}	

	NfeEmitenteModel clone() {
		return NfeEmitenteModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			cnpj: cnpj,
			cpf: cpf,
			nome: nome,
			fantasia: fantasia,
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
			inscricaoEstadual: inscricaoEstadual,
			inscricaoEstadualSt: inscricaoEstadualSt,
			inscricaoMunicipal: inscricaoMunicipal,
			cnae: cnae,
			crt: crt,
		);			
	}

	
}