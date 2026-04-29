import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/data/domain/domain_imports.dart';

class EmpresaCnaeModel extends ModelBase {
  int? id;
  int? idEmpresa;
  int? idCnae;
  String? principal;
  String? ramoAtividade;
  String? objetoSocial;
  CnaeModel? cnaeModel;

  EmpresaCnaeModel({
    this.id,
    this.idEmpresa,
    this.idCnae,
    this.principal = 'Sim',
    this.ramoAtividade,
    this.objetoSocial,
    CnaeModel? cnaeModel,
  }) {
    this.cnaeModel = cnaeModel ?? CnaeModel();
  }

  static List<String> dbColumns = <String>[
    'id',
    'principal',
    'ramo_atividade',
    'objeto_social',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Principal',
    'Ramo Atividade',
    'Objeto Social',
  ];

  EmpresaCnaeModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    idEmpresa = jsonData['idEmpresa'];
    idCnae = jsonData['idCnae'];
    principal = EmpresaCnaeDomain.getPrincipal(jsonData['principal']);
    ramoAtividade = jsonData['ramoAtividade'];
    objetoSocial = jsonData['objetoSocial'];
    cnaeModel = jsonData['cnaeModel'] == null ? CnaeModel() : CnaeModel.fromJson(jsonData['cnaeModel']);
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['idEmpresa'] = idEmpresa != 0 ? idEmpresa : null;
    jsonData['idCnae'] = idCnae != 0 ? idCnae : null;
    jsonData['principal'] = EmpresaCnaeDomain.setPrincipal(principal);
    jsonData['ramoAtividade'] = ramoAtividade;
    jsonData['objetoSocial'] = objetoSocial;
    jsonData['cnaeModel'] = cnaeModel?.toJson;
    jsonData['cnae'] = cnaeModel?.codigo ?? '';

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static EmpresaCnaeModel fromPlutoRow(PlutoRow row) {
    return EmpresaCnaeModel(
      id: row.cells['id']?.value,
      idEmpresa: row.cells['idEmpresa']?.value,
      idCnae: row.cells['idCnae']?.value,
      principal: row.cells['principal']?.value,
      ramoAtividade: row.cells['ramoAtividade']?.value,
      objetoSocial: row.cells['objetoSocial']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'idEmpresa': PlutoCell(value: idEmpresa ?? 0),
        'idCnae': PlutoCell(value: idCnae ?? 0),
        'principal': PlutoCell(value: principal ?? ''),
        'ramoAtividade': PlutoCell(value: ramoAtividade ?? ''),
        'objetoSocial': PlutoCell(value: objetoSocial ?? ''),
        'cnae': PlutoCell(value: cnaeModel?.codigo ?? ''),
      },
    );
  }

  EmpresaCnaeModel clone() {
    return EmpresaCnaeModel(
      id: id,
      idEmpresa: idEmpresa,
      idCnae: idCnae,
      principal: principal,
      ramoAtividade: ramoAtividade,
      objetoSocial: objetoSocial,
      cnaeModel: CnaeModel.cloneFrom(cnaeModel),
    );
  }

  static EmpresaCnaeModel cloneFrom(EmpresaCnaeModel? model) {
    return EmpresaCnaeModel(
      id: model?.id,
      idEmpresa: model?.idEmpresa,
      idCnae: model?.idCnae,
      principal: model?.principal,
      ramoAtividade: model?.ramoAtividade,
      objetoSocial: model?.objetoSocial,
      cnaeModel: CnaeModel.cloneFrom(model?.cnaeModel),
    );
  }


}