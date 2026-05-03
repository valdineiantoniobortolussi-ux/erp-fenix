import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';


class EmpresaContatoModel extends ModelBase {
  int? id;
  int? idEmpresa;
  String? nome;
  String? email;
  String? observacao;

  EmpresaContatoModel({
    this.id,
    this.idEmpresa,
    this.nome,
    this.email,
    this.observacao,
  });

  static List<String> dbColumns = <String>[
    'id',
    'nome',
    'email',
    'observacao',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Nome',
    'Email',
    'Observacao',
  ];

  EmpresaContatoModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    idEmpresa = jsonData['idEmpresa'];
    nome = jsonData['nome'];
    email = jsonData['email'];
    observacao = jsonData['observacao'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['idEmpresa'] = idEmpresa != 0 ? idEmpresa : null;
    jsonData['nome'] = nome;
    jsonData['email'] = email;
    jsonData['observacao'] = observacao;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static EmpresaContatoModel fromPlutoRow(PlutoRow row) {
    return EmpresaContatoModel(
      id: row.cells['id']?.value,
      idEmpresa: row.cells['idEmpresa']?.value,
      nome: row.cells['nome']?.value,
      email: row.cells['email']?.value,
      observacao: row.cells['observacao']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'idEmpresa': PlutoCell(value: idEmpresa ?? 0),
        'nome': PlutoCell(value: nome ?? ''),
        'email': PlutoCell(value: email ?? ''),
        'observacao': PlutoCell(value: observacao ?? ''),
      },
    );
  }

  EmpresaContatoModel clone() {
    return EmpresaContatoModel(
      id: id,
      idEmpresa: idEmpresa,
      nome: nome,
      email: email,
      observacao: observacao,
    );
  }

  static EmpresaContatoModel cloneFrom(EmpresaContatoModel? model) {
    return EmpresaContatoModel(
      id: model?.id,
      idEmpresa: model?.idEmpresa,
      nome: model?.nome,
      email: model?.email,
      observacao: model?.observacao,
    );
  }


}