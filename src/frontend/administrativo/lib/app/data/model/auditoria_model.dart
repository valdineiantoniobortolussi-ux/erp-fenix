import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class AuditoriaModel extends ModelBase {
  int? id;
  DateTime? dataRegistro;
  String? horaRegistro;
  String? janelaController;
  String? acao;
  String? conteudo;
  String? tokenJwt;
	UsuarioTokenModel? usuarioTokenModel;

  AuditoriaModel({
    this.id,
    this.dataRegistro,
    this.horaRegistro,
    this.janelaController,
    this.acao,
    this.conteudo,
    this.tokenJwt,
    this.usuarioTokenModel,
  });

  static List<String> dbColumns = <String>[
    'id',
    'data_registro',
    'hora_registro',
    'janela_controller',
    'acao',
    'conteudo',
    'token_jwt',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Data Registro',
    'Hora Registro',
    'Janela Controller',
    'Acao',
    'Conteudo',
    'Token Jwt',
  ];

  AuditoriaModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    dataRegistro = jsonData['dataRegistro'] != null ? DateTime.tryParse(jsonData['dataRegistro']) : null;
    horaRegistro = jsonData['horaRegistro'];
    janelaController = jsonData['janelaController'];
    acao = jsonData['acao'];
    conteudo = jsonData['conteudo'];
    tokenJwt = jsonData['tokenJwt'];
    usuarioTokenModel = jsonData['usuarioTokenModel'] == null ? UsuarioTokenModel() : UsuarioTokenModel.fromJson(jsonData['usuarioTokenModel']);
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['dataRegistro'] = dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRegistro!) : null;
    jsonData['horaRegistro'] = horaRegistro;
    jsonData['janelaController'] = janelaController;
    jsonData['acao'] = acao;
    jsonData['conteudo'] = conteudo;
    jsonData['tokenJwt'] = tokenJwt;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static AuditoriaModel fromPlutoRow(PlutoRow row) {
    return AuditoriaModel(
      id: row.cells['id']?.value,
      dataRegistro: Util.stringToDate(row.cells['dataRegistro']?.value),
      horaRegistro: row.cells['horaRegistro']?.value,
      janelaController: row.cells['janelaController']?.value,
      acao: row.cells['acao']?.value,
      conteudo: row.cells['conteudo']?.value,
      tokenJwt: row.cells['tokenJwt']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'dataRegistro': PlutoCell(value: dataRegistro),
        'horaRegistro': PlutoCell(value: horaRegistro ?? ''),
        'janelaController': PlutoCell(value: janelaController ?? ''),
        'acao': PlutoCell(value: acao ?? ''),
        'conteudo': PlutoCell(value: conteudo ?? ''),
        'tokenJwt': PlutoCell(value: tokenJwt ?? ''),
      },
    );
  }

  AuditoriaModel clone() {
    return AuditoriaModel(
      id: id,
      dataRegistro: dataRegistro,
      horaRegistro: horaRegistro,
      janelaController: janelaController,
      acao: acao,
      conteudo: conteudo,
      tokenJwt: tokenJwt,
    );
  }

  static AuditoriaModel cloneFrom(AuditoriaModel? model) {
    return AuditoriaModel(
      id: model?.id,
      dataRegistro: model?.dataRegistro,
      horaRegistro: model?.horaRegistro,
      janelaController: model?.janelaController,
      acao: model?.acao,
      conteudo: model?.conteudo,
      tokenJwt: model?.tokenJwt,
    );
  }


}