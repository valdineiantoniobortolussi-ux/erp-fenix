import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class ViewPessoaUsuarioModel {
	int? id;
	int? idPessoa;
	String? pessoaNome;
	String? tipo;
	String? email;
	int? idColaborador;
	int? idUsuario;
	String? login;
	String? senha;
	DateTime? dataCadastro;
	String? administrador;

	ViewPessoaUsuarioModel({
		this.id,
		this.idPessoa,
		this.pessoaNome,
		this.tipo,
		this.email,
		this.idColaborador,
		this.idUsuario,
		this.login,
		this.senha,
		this.dataCadastro,
		this.administrador,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_pessoa',
		'pessoa_nome',
		'tipo',
		'email',
		'id_colaborador',
		'id_usuario',
		'login',
		'senha',
		'data_cadastro',
		'administrador',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Pessoa',
		'Pessoa Nome',
		'Tipo',
		'Email',
		'Id Colaborador',
		'Id Usuario',
		'Login',
		'Senha',
		'Data Cadastro',
		'Administrador',
	];

	ViewPessoaUsuarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		pessoaNome = jsonData['pessoaNome'];
		tipo = jsonData['tipo'];
		email = jsonData['email'];
		idColaborador = jsonData['idColaborador'];
		idUsuario = jsonData['idUsuario'];
		login = jsonData['login'];
		senha = jsonData['senha'];
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
		administrador = jsonData['administrador'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa;
		jsonData['pessoaNome'] = pessoaNome;
		jsonData['tipo'] = tipo;
		jsonData['email'] = email;
		jsonData['idColaborador'] = idColaborador;
		jsonData['idUsuario'] = idUsuario;
		jsonData['login'] = login;
		jsonData['senha'] = senha;
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
		jsonData['administrador'] = administrador;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		pessoaNome = plutoRow.cells['pessoaNome']?.value;
		tipo = plutoRow.cells['tipo']?.value;
		email = plutoRow.cells['email']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		idUsuario = plutoRow.cells['idUsuario']?.value;
		login = plutoRow.cells['login']?.value;
		senha = plutoRow.cells['senha']?.value;
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
		administrador = plutoRow.cells['administrador']?.value;
	}	

	ViewPessoaUsuarioModel clone() {
		return ViewPessoaUsuarioModel(
			id: id,
			idPessoa: idPessoa,
			pessoaNome: pessoaNome,
			tipo: tipo,
			email: email,
			idColaborador: idColaborador,
			idUsuario: idUsuario,
			login: login,
			senha: senha,
			dataCadastro: dataCadastro,
			administrador: administrador,
		);			
	}

	
}