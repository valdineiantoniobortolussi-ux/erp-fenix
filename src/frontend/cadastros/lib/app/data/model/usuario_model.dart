import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class UsuarioModel {
	int? id;
	int? idPapel;
	int? idColaborador;
	String? login;
	String? senha;
	String? administrador;
	DateTime? dataCadastro;

	UsuarioModel({
		this.id,
		this.idPapel,
		this.idColaborador,
		this.login,
		this.senha,
		this.administrador,
		this.dataCadastro,
	});

	static List<String> dbColumns = <String>[
		'id',
		'login',
		'senha',
		'administrador',
		'data_cadastro',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Login',
		'Senha',
		'Administrador',
		'Data Cadastro',
	];

	UsuarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPapel = jsonData['idPapel'];
		idColaborador = jsonData['idColaborador'];
		login = jsonData['login'];
		senha = jsonData['senha'];
		administrador = UsuarioDomain.getAdministrador(jsonData['administrador']);
		dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPapel'] = idPapel != 0 ? idPapel : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['login'] = login;
		jsonData['senha'] = senha;
		jsonData['administrador'] = UsuarioDomain.setAdministrador(administrador);
		jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPapel = plutoRow.cells['idPapel']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		login = plutoRow.cells['login']?.value;
		senha = plutoRow.cells['senha']?.value;
		administrador = plutoRow.cells['administrador']?.value != '' ? plutoRow.cells['administrador']?.value : 'Sim';
		dataCadastro = Util.stringToDate(plutoRow.cells['dataCadastro']?.value);
	}	

	UsuarioModel clone() {
		return UsuarioModel(
			id: id,
			idPapel: idPapel,
			idColaborador: idColaborador,
			login: login,
			senha: senha,
			administrador: administrador,
			dataCadastro: dataCadastro,
		);			
	}

	
}