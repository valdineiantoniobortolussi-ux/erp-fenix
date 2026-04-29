import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class UsuarioTokenModel extends ModelBase {
  int? id;
  String? login;
  String? token;
  DateTime? dataCriacao;
  String? horaCriacao;
  DateTime? dataExpiracao;
  String? horaExpiracao;

  UsuarioTokenModel({
    this.id,
    this.login,
    this.token,
    this.dataCriacao,
    this.horaCriacao,
    this.dataExpiracao,
    this.horaExpiracao,
  });

  static List<String> dbColumns = <String>[
    'id',
    'login',
    'token',
    'data_criacao',
    'hora_criacao',
    'data_expiracao',
    'hora_expiracao',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Login',
    'Token',
    'Data Criacao',
    'Hora Criacao',
    'Data Expiracao',
    'Hora Expiracao',
  ];

  UsuarioTokenModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    login = jsonData['login'];
    token = jsonData['token'];
    dataCriacao = jsonData['dataCriacao'] != null ? DateTime.tryParse(jsonData['dataCriacao']) : null;
    horaCriacao = jsonData['horaCriacao'];
    dataExpiracao = jsonData['dataExpiracao'] != null ? DateTime.tryParse(jsonData['dataExpiracao']) : null;
    horaExpiracao = jsonData['horaExpiracao'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['login'] = login;
    jsonData['token'] = token;
    jsonData['dataCriacao'] = dataCriacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCriacao!) : null;
    jsonData['horaCriacao'] = horaCriacao;
    jsonData['dataExpiracao'] = dataExpiracao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataExpiracao!) : null;
    jsonData['horaExpiracao'] = horaExpiracao;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static UsuarioTokenModel fromPlutoRow(PlutoRow row) {
    return UsuarioTokenModel(
      id: row.cells['id']?.value,
      login: row.cells['login']?.value,
      token: row.cells['token']?.value,
      dataCriacao: Util.stringToDate(row.cells['dataCriacao']?.value),
      horaCriacao: row.cells['horaCriacao']?.value,
      dataExpiracao: Util.stringToDate(row.cells['dataExpiracao']?.value),
      horaExpiracao: row.cells['horaExpiracao']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'login': PlutoCell(value: login ?? ''),
        'token': PlutoCell(value: token ?? ''),
        'dataCriacao': PlutoCell(value: dataCriacao),
        'horaCriacao': PlutoCell(value: horaCriacao ?? ''),
        'dataExpiracao': PlutoCell(value: dataExpiracao),
        'horaExpiracao': PlutoCell(value: horaExpiracao ?? ''),
      },
    );
  }

  UsuarioTokenModel clone() {
    return UsuarioTokenModel(
      id: id,
      login: login,
      token: token,
      dataCriacao: dataCriacao,
      horaCriacao: horaCriacao,
      dataExpiracao: dataExpiracao,
      horaExpiracao: horaExpiracao,
    );
  }

  static UsuarioTokenModel cloneFrom(UsuarioTokenModel? model) {
    return UsuarioTokenModel(
      id: model?.id,
      login: model?.login,
      token: model?.token,
      dataCriacao: model?.dataCriacao,
      horaCriacao: model?.horaCriacao,
      dataExpiracao: model?.dataExpiracao,
      horaExpiracao: model?.horaExpiracao,
    );
  }


}