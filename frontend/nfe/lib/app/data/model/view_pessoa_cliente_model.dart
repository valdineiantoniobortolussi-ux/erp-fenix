import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class ViewPessoaClienteModel {
	int? id;
	String? nome;
	String? tipo;
	String? email;
	String? site;
	String? cpfCnpj;
	String? rgIe;
	DateTime? desde;
	double? taxaDesconto;
	double? limiteCredito;
	DateTime? dataCadastro;
	String? observacao;
	int? idPessoa;

	ViewPessoaClienteModel({
		this.id,
		this.nome,
		this.tipo,
		this.email,
		this.site,
		this.cpfCnpj,
		this.rgIe,
		this.desde,
		this.taxaDesconto,
		this.limiteCredito,
		this.dataCadastro,
		this.observacao,
		this.idPessoa,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'tipo',
		'email',
		'site',
		'cpf_cnpj',
		'rg_ie',
		'desde',
		'taxa_desconto',
		'limite_credito',
		'data_cadastro',
		'observacao',
		'id_pessoa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Tipo',
		'Email',
		'Site',
		'Cpf Cnpj',
		'Rg Ie',
		'Desde',
		'Taxa Desconto',
		'Limite Credito',
		'Data Cadastro',
		'Observacao',
		'Id Pessoa',
	];

	ViewPessoaClienteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		tipo = ViewPessoaClienteDomain.getTipo(jsonData['tipo']);
		email = jsonData['email'];
		site = jsonData['site'];
		cpfCnpj = jsonData['cpfCnpj'];
		rgIe = jsonData['rgIe'];
		desde = jsonData['desde'] != null ? DateTime.tryParse(jsonData['desde']) : null;
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		limiteCredito = jsonData['limiteCredito']?.toDouble();
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		observacao = jsonData['observacao'];
		idPessoa = jsonData['idPessoa'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['tipo'] = ViewPessoaClienteDomain.setTipo(tipo);
		jsonData['email'] = email;
		jsonData['site'] = site;
		jsonData['cpfCnpj'] = Util.removeMask(cpfCnpj);
		jsonData['rgIe'] = rgIe;
		jsonData['desde'] = desde != null ? DateFormat('yyyy-MM-ddT00:00:00').format(desde!) : null;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['limiteCredito'] = limiteCredito;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['observacao'] = observacao;
		jsonData['idPessoa'] = idPessoa;
	
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
		desde = Util.stringToDate(plutoRow.cells['desde']?.value);
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		limiteCredito = plutoRow.cells['limiteCredito']?.value?.toDouble();
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		observacao = plutoRow.cells['observacao']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
	}	

	ViewPessoaClienteModel clone() {
		return ViewPessoaClienteModel(
			id: id,
			nome: nome,
			tipo: tipo,
			email: email,
			site: site,
			cpfCnpj: cpfCnpj,
			rgIe: rgIe,
			desde: desde,
			taxaDesconto: taxaDesconto,
			limiteCredito: limiteCredito,
			dataCadastro: dataCadastro,
			observacao: observacao,
			idPessoa: idPessoa,
		);			
	}

	
}