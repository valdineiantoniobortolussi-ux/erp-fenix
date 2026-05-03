import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class ViewPessoaUsuarioModel extends ModelBase {
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

  static ViewPessoaUsuarioModel fromPlutoRow(PlutoRow row) {
    return ViewPessoaUsuarioModel(
      id: row.cells['id']?.value,
      idPessoa: row.cells['idPessoa']?.value,
      pessoaNome: row.cells['pessoaNome']?.value,
      tipo: row.cells['tipo']?.value,
      email: row.cells['email']?.value,
      idColaborador: row.cells['idColaborador']?.value,
      idUsuario: row.cells['idUsuario']?.value,
      login: row.cells['login']?.value,
      senha: row.cells['senha']?.value,
      dataCadastro: Util.stringToDate(row.cells['dataCadastro']?.value),
      administrador: row.cells['administrador']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'idPessoa': PlutoCell(value: idPessoa ?? 0),
        'pessoaNome': PlutoCell(value: pessoaNome ?? ''),
        'tipo': PlutoCell(value: tipo ?? ''),
        'email': PlutoCell(value: email ?? ''),
        'idColaborador': PlutoCell(value: idColaborador ?? 0),
        'idUsuario': PlutoCell(value: idUsuario ?? 0),
        'login': PlutoCell(value: login ?? ''),
        'senha': PlutoCell(value: senha ?? ''),
        'dataCadastro': PlutoCell(value: dataCadastro),
        'administrador': PlutoCell(value: administrador ?? ''),
      },
    );
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

  static ViewPessoaUsuarioModel cloneFrom(ViewPessoaUsuarioModel? model) {
    return ViewPessoaUsuarioModel(
      id: model?.id,
      idPessoa: model?.idPessoa,
      pessoaNome: model?.pessoaNome,
      tipo: model?.tipo,
      email: model?.email,
      idColaborador: model?.idColaborador,
      idUsuario: model?.idUsuario,
      login: model?.login,
      senha: model?.senha,
      dataCadastro: model?.dataCadastro,
      administrador: model?.administrador,
    );
  }


}