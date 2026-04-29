import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:compras/app/data/domain/domain_imports.dart';

class ViewPessoaFornecedorModel {
	int? id;
	String? nome;
	String? tipo;
	String? email;
	String? site;
	String? cpfCnpj;
	String? rgIe;
	DateTime? desde;
	DateTime? dataCadastro;
	String? observacao;
	int? idPessoa;

	ViewPessoaFornecedorModel({
		this.id,
		this.nome,
		this.tipo,
		this.email,
		this.site,
		this.cpfCnpj,
		this.rgIe,
		this.desde,
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
		'Data Cadastro',
		'Observacao',
		'Id Pessoa',
	];

	ViewPessoaFornecedorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		tipo = ViewPessoaFornecedorDomain.getTipo(jsonData['tipo']);
		email = jsonData['email'];
		site = jsonData['site'];
		cpfCnpj = jsonData['cpfCnpj'];
		rgIe = jsonData['rgIe'];
		desde = jsonData['desde'] != null ? DateTime.tryParse(jsonData['desde']) : null;
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		observacao = jsonData['observacao'];
		idPessoa = jsonData['idPessoa'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['tipo'] = ViewPessoaFornecedorDomain.setTipo(tipo);
		jsonData['email'] = email;
		jsonData['site'] = site;
		jsonData['cpfCnpj'] = Util.removeMask(cpfCnpj);
		jsonData['rgIe'] = rgIe;
		jsonData['desde'] = desde != null ? DateFormat('yyyy-MM-ddT00:00:00').format(desde!) : null;
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
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		observacao = plutoRow.cells['observacao']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
	}	

	ViewPessoaFornecedorModel clone() {
		return ViewPessoaFornecedorModel(
			id: id,
			nome: nome,
			tipo: tipo,
			email: email,
			site: site,
			cpfCnpj: cpfCnpj,
			rgIe: rgIe,
			desde: desde,
			dataCadastro: dataCadastro,
			observacao: observacao,
			idPessoa: idPessoa,
		);			
	}

	
}