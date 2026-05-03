import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class EmpresaTelefoneModel extends ModelBase {
  int? id;
  int? idEmpresa;
  String? tipo;
  String? numero;

  EmpresaTelefoneModel({
    this.id,
    this.idEmpresa,
    this.tipo = 'Fixo',
    this.numero,
  });

  static List<String> dbColumns = <String>[
    'id',
    'tipo',
    'numero',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Tipo',
    'Numero',
  ];

  EmpresaTelefoneModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    idEmpresa = jsonData['idEmpresa'];
    tipo = EmpresaTelefoneDomain.getTipo(jsonData['tipo']);
    numero = jsonData['numero'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['idEmpresa'] = idEmpresa != 0 ? idEmpresa : null;
    jsonData['tipo'] = EmpresaTelefoneDomain.setTipo(tipo);
    jsonData['numero'] = Util.removeMask(numero);

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static EmpresaTelefoneModel fromPlutoRow(PlutoRow row) {
    return EmpresaTelefoneModel(
      id: row.cells['id']?.value,
      idEmpresa: row.cells['idEmpresa']?.value,
      tipo: row.cells['tipo']?.value,
      numero: row.cells['numero']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'idEmpresa': PlutoCell(value: idEmpresa ?? 0),
        'tipo': PlutoCell(value: tipo ?? ''),
        'numero': PlutoCell(value: numero ?? ''),
      },
    );
  }

  EmpresaTelefoneModel clone() {
    return EmpresaTelefoneModel(
      id: id,
      idEmpresa: idEmpresa,
      tipo: tipo,
      numero: numero,
    );
  }

  static EmpresaTelefoneModel cloneFrom(EmpresaTelefoneModel? model) {
    return EmpresaTelefoneModel(
      id: model?.id,
      idEmpresa: model?.idEmpresa,
      tipo: model?.tipo,
      numero: model?.numero,
    );
  }


}