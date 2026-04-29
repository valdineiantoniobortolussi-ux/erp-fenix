import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:ged/app/data/domain/domain_imports.dart';

class ViewPessoaVendedorModel {
	int? id;
	String? nome;
	String? tipo;
	String? email;
	String? site;
	String? cpfCnpj;
	String? rgIe;
	String? matricula;
	DateTime? dataCadastro;
	DateTime? dataAdmissao;
	DateTime? dataDemissao;
	String? ctpsNumero;
	String? ctpsSerie;
	DateTime? ctpsDataExpedicao;
	String? ctpsUf;
	String? observacao;
	String? logradouro;
	String? numero;
	String? complemento;
	String? bairro;
	String? cidade;
	String? cep;
	String? municipioIbge;
	String? uf;
	int? idPessoa;
	int? idCargo;
	int? idSetor;
	double? comissao;
	double? metaVenda;

	ViewPessoaVendedorModel({
		this.id,
		this.nome,
		this.tipo,
		this.email,
		this.site,
		this.cpfCnpj,
		this.rgIe,
		this.matricula,
		this.dataCadastro,
		this.dataAdmissao,
		this.dataDemissao,
		this.ctpsNumero,
		this.ctpsSerie,
		this.ctpsDataExpedicao,
		this.ctpsUf,
		this.observacao,
		this.logradouro,
		this.numero,
		this.complemento,
		this.bairro,
		this.cidade,
		this.cep,
		this.municipioIbge,
		this.uf,
		this.idPessoa,
		this.idCargo,
		this.idSetor,
		this.comissao,
		this.metaVenda,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'tipo',
		'email',
		'site',
		'cpf_cnpj',
		'rg_ie',
		'matricula',
		'data_cadastro',
		'data_admissao',
		'data_demissao',
		'ctps_numero',
		'ctps_serie',
		'ctps_data_expedicao',
		'ctps_uf',
		'observacao',
		'logradouro',
		'numero',
		'complemento',
		'bairro',
		'cidade',
		'cep',
		'municipio_ibge',
		'uf',
		'id_pessoa',
		'id_cargo',
		'id_setor',
		'comissao',
		'meta_venda',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Tipo',
		'Email',
		'Site',
		'Cpf Cnpj',
		'Rg Ie',
		'Matricula',
		'Data Cadastro',
		'Data Admissao',
		'Data Demissao',
		'Ctps Numero',
		'Ctps Serie',
		'Ctps Data Expedicao',
		'Ctps Uf',
		'Observacao',
		'Logradouro',
		'Numero',
		'Complemento',
		'Bairro',
		'Cidade',
		'Cep',
		'Municipio Ibge',
		'Uf',
		'Id Pessoa',
		'Id Cargo',
		'Id Setor',
		'Comissao',
		'Meta Venda',
	];

	ViewPessoaVendedorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		tipo = ViewPessoaVendedorDomain.getTipo(jsonData['tipo']);
		email = jsonData['email'];
		site = jsonData['site'];
		cpfCnpj = jsonData['cpfCnpj'];
		rgIe = jsonData['rgIe'];
		matricula = jsonData['matricula'];
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		dataAdmissao = jsonData['dataAdmissao'] != null ? DateTime.tryParse(jsonData['dataAdmissao']) : null;
		dataDemissao = jsonData['dataDemissao'] != null ? DateTime.tryParse(jsonData['dataDemissao']) : null;
		ctpsNumero = jsonData['ctpsNumero'];
		ctpsSerie = jsonData['ctpsSerie'];
		ctpsDataExpedicao = jsonData['ctpsDataExpedicao'] != null ? DateTime.tryParse(jsonData['ctpsDataExpedicao']) : null;
		ctpsUf = ViewPessoaVendedorDomain.getCtpsUf(jsonData['ctpsUf']);
		observacao = jsonData['observacao'];
		logradouro = jsonData['logradouro'];
		numero = jsonData['numero'];
		complemento = jsonData['complemento'];
		bairro = jsonData['bairro'];
		cidade = jsonData['cidade'];
		cep = jsonData['cep'];
		municipioIbge = jsonData['municipioIbge'];
		uf = ViewPessoaVendedorDomain.getUf(jsonData['uf']);
		idPessoa = jsonData['idPessoa'];
		idCargo = jsonData['idCargo'];
		idSetor = jsonData['idSetor'];
		comissao = jsonData['comissao']?.toDouble();
		metaVenda = jsonData['metaVenda']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['tipo'] = ViewPessoaVendedorDomain.setTipo(tipo);
		jsonData['email'] = email;
		jsonData['site'] = site;
		jsonData['cpfCnpj'] = Util.removeMask(cpfCnpj);
		jsonData['rgIe'] = rgIe;
		jsonData['matricula'] = matricula;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['dataAdmissao'] = dataAdmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAdmissao!) : null;
		jsonData['dataDemissao'] = dataDemissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDemissao!) : null;
		jsonData['ctpsNumero'] = ctpsNumero;
		jsonData['ctpsSerie'] = ctpsSerie;
		jsonData['ctpsDataExpedicao'] = ctpsDataExpedicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(ctpsDataExpedicao!) : null;
		jsonData['ctpsUf'] = ViewPessoaVendedorDomain.setCtpsUf(ctpsUf);
		jsonData['observacao'] = observacao;
		jsonData['logradouro'] = logradouro;
		jsonData['numero'] = numero;
		jsonData['complemento'] = complemento;
		jsonData['bairro'] = bairro;
		jsonData['cidade'] = cidade;
		jsonData['cep'] = Util.removeMask(cep);
		jsonData['municipioIbge'] = municipioIbge;
		jsonData['uf'] = ViewPessoaVendedorDomain.setUf(uf);
		jsonData['idPessoa'] = idPessoa;
		jsonData['idCargo'] = idCargo;
		jsonData['idSetor'] = idSetor;
		jsonData['comissao'] = comissao;
		jsonData['metaVenda'] = metaVenda;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'AAA';
		email = plutoRow.cells['email']?.value;
		site = plutoRow.cells['site']?.value;
		cpfCnpj = plutoRow.cells['cpfCnpj']?.value;
		rgIe = plutoRow.cells['rgIe']?.value;
		matricula = plutoRow.cells['matricula']?.value;
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		dataAdmissao = Util.stringToDate(plutoRow.cells['dataAdmissao']?.value);
		dataDemissao = Util.stringToDate(plutoRow.cells['dataDemissao']?.value);
		ctpsNumero = plutoRow.cells['ctpsNumero']?.value;
		ctpsSerie = plutoRow.cells['ctpsSerie']?.value;
		ctpsDataExpedicao = Util.stringToDate(plutoRow.cells['ctpsDataExpedicao']?.value);
		ctpsUf = plutoRow.cells['ctpsUf']?.value != '' ? plutoRow.cells['ctpsUf']?.value : 'AC';
		observacao = plutoRow.cells['observacao']?.value;
		logradouro = plutoRow.cells['logradouro']?.value;
		numero = plutoRow.cells['numero']?.value;
		complemento = plutoRow.cells['complemento']?.value;
		bairro = plutoRow.cells['bairro']?.value;
		cidade = plutoRow.cells['cidade']?.value;
		cep = plutoRow.cells['cep']?.value;
		municipioIbge = plutoRow.cells['municipioIbge']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		idPessoa = plutoRow.cells['idPessoa']?.value;
		idCargo = plutoRow.cells['idCargo']?.value;
		idSetor = plutoRow.cells['idSetor']?.value;
		comissao = plutoRow.cells['comissao']?.value?.toDouble();
		metaVenda = plutoRow.cells['metaVenda']?.value?.toDouble();
	}	

	ViewPessoaVendedorModel clone() {
		return ViewPessoaVendedorModel(
			id: id,
			nome: nome,
			tipo: tipo,
			email: email,
			site: site,
			cpfCnpj: cpfCnpj,
			rgIe: rgIe,
			matricula: matricula,
			dataCadastro: dataCadastro,
			dataAdmissao: dataAdmissao,
			dataDemissao: dataDemissao,
			ctpsNumero: ctpsNumero,
			ctpsSerie: ctpsSerie,
			ctpsDataExpedicao: ctpsDataExpedicao,
			ctpsUf: ctpsUf,
			observacao: observacao,
			logradouro: logradouro,
			numero: numero,
			complemento: complemento,
			bairro: bairro,
			cidade: cidade,
			cep: cep,
			municipioIbge: municipioIbge,
			uf: uf,
			idPessoa: idPessoa,
			idCargo: idCargo,
			idSetor: idSetor,
			comissao: comissao,
			metaVenda: metaVenda,
		);			
	}

	
}