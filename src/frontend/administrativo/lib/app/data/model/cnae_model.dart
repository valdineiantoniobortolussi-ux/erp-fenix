import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';


class CnaeModel extends ModelBase {
  int? id;
  String? codigo;
  String? denominacao;

  CnaeModel({
    this.id,
    this.codigo,
    this.denominacao,
  });

  static List<String> dbColumns = <String>[
    'id',
    'codigo',
    'denominacao',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Codigo',
    'Denominacao',
  ];

  CnaeModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    codigo = jsonData['codigo'];
    denominacao = jsonData['denominacao'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['codigo'] = codigo;
    jsonData['denominacao'] = denominacao;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static CnaeModel fromPlutoRow(PlutoRow row) {
    return CnaeModel(
      id: row.cells['id']?.value,
      codigo: row.cells['codigo']?.value,
      denominacao: row.cells['denominacao']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'codigo': PlutoCell(value: codigo ?? ''),
        'denominacao': PlutoCell(value: denominacao ?? ''),
      },
    );
  }

  CnaeModel clone() {
    return CnaeModel(
      id: id,
      codigo: codigo,
      denominacao: denominacao,
    );
  }

  static CnaeModel cloneFrom(CnaeModel? model) {
    return CnaeModel(
      id: model?.id,
      codigo: model?.codigo,
      denominacao: model?.denominacao,
    );
  }


}