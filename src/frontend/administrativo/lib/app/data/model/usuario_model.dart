import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class UsuarioModel extends ModelBase {
  int? id;
  int? idPapel;
  int? idColaborador;
  String? login;
  String? senha;
  String? administrador;
  DateTime? dataCadastro;
  ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
  PapelModel? papelModel;

  UsuarioModel({
    this.id,
    this.idPapel,
    this.idColaborador,
    this.login,
    this.senha,
    this.administrador = 'Sim',
    this.dataCadastro,
    ViewPessoaColaboradorModel? viewPessoaColaboradorModel,
    PapelModel? papelModel,
  }) {
    this.viewPessoaColaboradorModel = viewPessoaColaboradorModel ?? ViewPessoaColaboradorModel();
    this.papelModel = papelModel ?? PapelModel();
  }

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
    viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
    papelModel = jsonData['papelModel'] == null ? PapelModel() : PapelModel.fromJson(jsonData['papelModel']);
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
    jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
    jsonData['viewPessoaColaborador'] = viewPessoaColaboradorModel?.nome ?? '';
    jsonData['papelModel'] = papelModel?.toJson;
    jsonData['papel'] = papelModel?.nome ?? '';

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static UsuarioModel fromPlutoRow(PlutoRow row) {
    return UsuarioModel(
      id: row.cells['id']?.value,
      idPapel: row.cells['idPapel']?.value,
      idColaborador: row.cells['idColaborador']?.value,
      login: row.cells['login']?.value,
      senha: row.cells['senha']?.value,
      administrador: row.cells['administrador']?.value,
      dataCadastro: Util.stringToDate(row.cells['dataCadastro']?.value),
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'idPapel': PlutoCell(value: idPapel ?? 0),
        'idColaborador': PlutoCell(value: idColaborador ?? 0),
        'login': PlutoCell(value: login ?? ''),
        'senha': PlutoCell(value: senha ?? ''),
        'administrador': PlutoCell(value: administrador ?? ''),
        'dataCadastro': PlutoCell(value: dataCadastro),
        'viewPessoaColaborador': PlutoCell(value: viewPessoaColaboradorModel?.nome ?? ''),
        'papel': PlutoCell(value: papelModel?.nome ?? ''),
      },
    );
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
      viewPessoaColaboradorModel: ViewPessoaColaboradorModel.cloneFrom(viewPessoaColaboradorModel),
      papelModel: PapelModel.cloneFrom(papelModel),
    );
  }

  static UsuarioModel cloneFrom(UsuarioModel? model) {
    return UsuarioModel(
      id: model?.id,
      idPapel: model?.idPapel,
      idColaborador: model?.idColaborador,
      login: model?.login,
      senha: model?.senha,
      administrador: model?.administrador,
      dataCadastro: model?.dataCadastro,
      viewPessoaColaboradorModel: ViewPessoaColaboradorModel.cloneFrom(model?.viewPessoaColaboradorModel),
      papelModel: PapelModel.cloneFrom(model?.papelModel),
    );
  }


}