import 'dart:convert';
import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class EmpresaModel {
	int? id;
	String? razaoSocial;
	String? nomeFantasia;
	String? cnpj;
	String? inscricaoEstadual;
	String? inscricaoMunicipal;
	String? tipoRegime;
	String? crt;
	DateTime? dataConstituicao;
	String? tipo;
	String? email;
	String? logradouro;
	String? numero;
	String? complemento;
	String? cep;
	String? bairro;
	String? cidade;
	String? uf;
	String? fone;
	String? contato;
	int? codigoIbgeCidade;
	int? codigoIbgeUf;
	String? logotipo;
	String? registrado;
	String? naturezaJuridica;
	String? simei;
	String? emailPagamento;
	DateTime? dataRegistro;
	String? horaRegistro;
	String? idPlataformaPagamento;
	List<EmpresaPlanoModel>? empresaPlanoModelList;
	List<AdmModuloModel>? admModuloModelList;

	EmpresaModel({
		this.id,
		this.razaoSocial,
		this.nomeFantasia,
		this.cnpj,
		this.inscricaoEstadual,
		this.inscricaoMunicipal,
		this.tipoRegime,
		this.crt,
		this.dataConstituicao,
		this.tipo,
		this.email,
		this.logradouro,
		this.numero,
		this.complemento,
		this.cep,
		this.bairro,
		this.cidade,
		this.uf,
		this.fone,
		this.contato,
		this.codigoIbgeCidade,
		this.codigoIbgeUf,
		this.logotipo,
		this.registrado,
		this.naturezaJuridica,
		this.simei,
		this.emailPagamento,
		this.dataRegistro,
		this.horaRegistro,
		this.idPlataformaPagamento,
		this.empresaPlanoModelList,
		this.admModuloModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'razao_social',
		'nome_fantasia',
		'cnpj',
		'inscricao_estadual',
		'inscricao_municipal',
		'tipo_regime',
		'crt',
		'data_constituicao',
		'tipo',
		'email',
		'logradouro',
		'numero',
		'complemento',
		'cep',
		'bairro',
		'cidade',
		'uf',
		'fone',
		'contato',
		'codigo_ibge_cidade',
		'codigo_ibge_uf',
		'logotipo',
		'registrado',
		'natureza_juridica',
		'simei',
		'email_pagamento',
		'data_registro',
		'hora_registro',
		'id_plataforma_pagamento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Razao Social',
		'Nome Fantasia',
		'Cnpj',
		'Inscricao Estadual',
		'Inscricao Municipal',
		'Tipo Regime',
		'Crt',
		'Data Constituicao',
		'Tipo',
		'Email',
		'Logradouro',
		'Numero',
		'Complemento',
		'Cep',
		'Bairro',
		'Cidade',
		'Uf',
		'Fone',
		'Contato',
		'Codigo Ibge Cidade',
		'Codigo Ibge Uf',
		'Logotipo',
		'Registrado',
		'Natureza Juridica',
		'Simei',
		'Email Pagamento',
		'Data Registro',
		'Hora Registro',
		'Id Plataforma Pagamento',
	];

	EmpresaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		razaoSocial = jsonData['razaoSocial'];
		nomeFantasia = jsonData['nomeFantasia'];
		cnpj = jsonData['cnpj'];
		inscricaoEstadual = jsonData['inscricaoEstadual'];
		inscricaoMunicipal = jsonData['inscricaoMunicipal'];
		tipoRegime = jsonData['tipoRegime'];
		crt = jsonData['crt'];
		dataConstituicao = jsonData['dataConstituicao'] != null ? DateTime.tryParse(jsonData['dataConstituicao']) : null;
		tipo = jsonData['tipo'];
		email = jsonData['email'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		cep = jsonData['cep'];
		bairro = jsonData['bairro'];
		cidade = jsonData['cidade'];
		uf = jsonData['uf'];
		fone = jsonData['fone'];
		contato = jsonData['contato'];
		codigoIbgeCidade = jsonData['codigoIbgeCidade'];
		codigoIbgeUf = jsonData['codigoIbgeUf'];
		logotipo = jsonData['logotipo'];
		registrado = jsonData['registrado'];
		naturezaJuridica = jsonData['naturezaJuridica'];
		simei = jsonData['simei'];
		emailPagamento = jsonData['emailPagamento'];
		dataRegistro = jsonData['dataRegistro'] != null ? DateTime.tryParse(jsonData['dataRegistro']) : null;
		horaRegistro = jsonData['horaRegistro'];
		idPlataformaPagamento = jsonData['idPlataformaPagamento'];
		empresaPlanoModelList = (jsonData['empresaPlanoModelList'] as Iterable?)?.map((m) => EmpresaPlanoModel.fromJson(m)).toList() ?? [];
		admModuloModelList = (jsonData['admModuloModelList'] as Iterable?)?.map((m) => AdmModuloModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['razaoSocial'] = razaoSocial;
		jsonData['nomeFantasia'] = nomeFantasia;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['inscricaoEstadual'] = inscricaoEstadual;
		jsonData['inscricaoMunicipal'] = inscricaoMunicipal;
		jsonData['tipoRegime'] = tipoRegime;
		jsonData['crt'] = crt;
		jsonData['dataConstituicao'] = dataConstituicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataConstituicao!) : null;
		jsonData['tipo'] = tipo;
		jsonData['email'] = email;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['bairro'] = bairro;
		jsonData['cidade'] = cidade;
		jsonData['uf'] = uf;
		jsonData['fone'] = fone;
		jsonData['contato'] = contato;
		jsonData['codigoIbgeCidade'] = codigoIbgeCidade;
		jsonData['codigoIbgeUf'] = codigoIbgeUf;
		jsonData['logotipo'] = logotipo;
		jsonData['registrado'] = registrado;
		jsonData['naturezaJuridica'] = naturezaJuridica;
		jsonData['simei'] = simei;
		jsonData['emailPagamento'] = emailPagamento;
		jsonData['dataRegistro'] = dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRegistro!) : null;
		jsonData['horaRegistro'] = horaRegistro;
		jsonData['idPlataformaPagamento'] = idPlataformaPagamento;
			
		var empresaPlanoModelLocalList = []; 
		for (EmpresaPlanoModel object in empresaPlanoModelList ?? []) { 
			empresaPlanoModelLocalList.add(object.toJson); 
		}
		jsonData['empresaPlanoModelList'] = empresaPlanoModelLocalList;
		
		var admModuloModelLocalList = []; 
		for (AdmModuloModel object in admModuloModelList ?? []) { 
			admModuloModelLocalList.add(object.toJson); 
		}
		jsonData['admModuloModelList'] = admModuloModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}
	
}