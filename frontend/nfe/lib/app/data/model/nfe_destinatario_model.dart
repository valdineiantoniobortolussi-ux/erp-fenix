import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDestinatarioModel {
	int? id;
	int? idNfeCabecalho;
	String? cnpj;
	String? cpf;
	String? estrangeiroIdentificacao;
	String? nome;
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
	String? indicadorIe;
	String? inscricaoEstadual;
	int? suframa;
	String? inscricaoMunicipal;
	String? email;

	NfeDestinatarioModel({
		this.id,
		this.idNfeCabecalho,
		this.cnpj,
		this.cpf,
		this.estrangeiroIdentificacao,
		this.nome,
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
		this.indicadorIe,
		this.inscricaoEstadual,
		this.suframa,
		this.inscricaoMunicipal,
		this.email,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'cpf',
		'estrangeiro_identificacao',
		'nome',
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
		'indicador_ie',
		'inscricao_estadual',
		'suframa',
		'inscricao_municipal',
		'email',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Cpf',
		'Estrangeiro Identificacao',
		'Nome',
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
		'Indicador Ie',
		'Inscricao Estadual',
		'Suframa',
		'Inscricao Municipal',
		'Email',
	];

	NfeDestinatarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		cnpj = jsonData['cnpj'];
		cpf = jsonData['cpf'];
		estrangeiroIdentificacao = jsonData['estrangeiroIdentificacao'];
		nome = jsonData['nome'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		codigoMunicipio = jsonData['codigoMunicipio'];
		nomeMunicipio = jsonData['nomeMunicipio'];
		uf = NfeDestinatarioDomain.getUf(jsonData['uf']);
		cep = jsonData['cep'];
		codigoPais = jsonData['codigoPais'];
		nomePais = jsonData['nomePais'];
		telefone = jsonData['telefone'];
		indicadorIe = NfeDestinatarioDomain.getIndicadorIe(jsonData['indicadorIe']);
		inscricaoEstadual = jsonData['inscricaoEstadual'];
		suframa = jsonData['suframa'];
		inscricaoMunicipal = jsonData['inscricaoMunicipal'];
		email = jsonData['email'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['estrangeiroIdentificacao'] = estrangeiroIdentificacao;
		jsonData['nome'] = nome;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['codigoMunicipio'] = codigoMunicipio;
		jsonData['nomeMunicipio'] = nomeMunicipio;
		jsonData['uf'] = NfeDestinatarioDomain.setUf(uf);
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['codigoPais'] = codigoPais;
		jsonData['nomePais'] = nomePais;
		jsonData['telefone'] = telefone;
		jsonData['indicadorIe'] = NfeDestinatarioDomain.setIndicadorIe(indicadorIe);
		jsonData['inscricaoEstadual'] = inscricaoEstadual;
		jsonData['suframa'] = suframa;
		jsonData['inscricaoMunicipal'] = inscricaoMunicipal;
		jsonData['email'] = email;
	
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
		estrangeiroIdentificacao = plutoRow.cells['estrangeiroIdentificacao']?.value;
		nome = plutoRow.cells['nome']?.value;
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
		indicadorIe = plutoRow.cells['indicadorIe']?.value != '' ? plutoRow.cells['indicadorIe']?.value : 'AAA';
		inscricaoEstadual = plutoRow.cells['inscricaoEstadual']?.value;
		suframa = plutoRow.cells['suframa']?.value;
		inscricaoMunicipal = plutoRow.cells['inscricaoMunicipal']?.value;
		email = plutoRow.cells['email']?.value;
	}	

	NfeDestinatarioModel clone() {
		return NfeDestinatarioModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			cnpj: cnpj,
			cpf: cpf,
			estrangeiroIdentificacao: estrangeiroIdentificacao,
			nome: nome,
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
			indicadorIe: indicadorIe,
			inscricaoEstadual: inscricaoEstadual,
			suframa: suframa,
			inscricaoMunicipal: inscricaoMunicipal,
			email: email,
		);			
	}

	
}