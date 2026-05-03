import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';


class FuncaoModel extends ModelBase {
  int? id;
  String? nome;
  String? descricao;

  FuncaoModel({
    this.id,
    this.nome,
    this.descricao,
  });

  static List<String> dbColumns = <String>[
    'id',
    'nome',
    'descricao',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Nome',
    'Descricao',
  ];

  FuncaoModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    nome = jsonData['nome'];
    descricao = jsonData['descricao'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['nome'] = nome;
    jsonData['descricao'] = descricao;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static FuncaoModel fromPlutoRow(PlutoRow row) {
    return FuncaoModel(
      id: row.cells['id']?.value,
      nome: row.cells['nome']?.value,
      descricao: row.cells['descricao']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'nome': PlutoCell(value: nome ?? ''),
        'descricao': PlutoCell(value: descricao ?? ''),
      },
    );
  }

  FuncaoModel clone() {
    return FuncaoModel(
      id: id,
      nome: nome,
      descricao: descricao,
    );
  }

  static FuncaoModel cloneFrom(FuncaoModel? model) {
    return FuncaoModel(
      id: model?.id,
      nome: model?.nome,
      descricao: model?.descricao,
    );
  }


}