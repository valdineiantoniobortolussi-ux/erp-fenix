import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/data/domain/domain_imports.dart';

class PapelFuncaoModel extends ModelBase {
  int? id;
  int? idPapel;
  int? idFuncao;
  String? habilitado;
  String? podeInserir;
  String? podeAlterar;
  String? podeExcluir;
  FuncaoModel? funcaoModel;

  PapelFuncaoModel({
    this.id,
    this.idPapel,
    this.idFuncao,
    this.habilitado = 'Sim',
    this.podeInserir = 'Sim',
    this.podeAlterar = 'Sim',
    this.podeExcluir = 'Sim',
    FuncaoModel? funcaoModel,
  }) {
    this.funcaoModel = funcaoModel ?? FuncaoModel();
  }

  static List<String> dbColumns = <String>[
    'id',
    'habilitado',
    'pode_inserir',
    'pode_alterar',
    'pode_excluir',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Habilitado',
    'Pode Inserir',
    'Pode Alterar',
    'Pode Excluir',
  ];

  PapelFuncaoModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    idPapel = jsonData['idPapel'];
    idFuncao = jsonData['funcaoModel']['id'];
    habilitado = PapelFuncaoDomain.getHabilitado(jsonData['habilitado']);
    podeInserir = PapelFuncaoDomain.getPodeInserir(jsonData['podeInserir']);
    podeAlterar = PapelFuncaoDomain.getPodeAlterar(jsonData['podeAlterar']);
    podeExcluir = PapelFuncaoDomain.getPodeExcluir(jsonData['podeExcluir']);
    funcaoModel = jsonData['funcaoModel'] == null ? FuncaoModel() : FuncaoModel.fromJson(jsonData['funcaoModel']);
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['idPapel'] = idPapel != 0 ? idPapel : null;
    jsonData['idFuncao'] = idFuncao != 0 ? idFuncao : null;
    jsonData['habilitado'] = PapelFuncaoDomain.setHabilitado(habilitado);
    jsonData['podeInserir'] = PapelFuncaoDomain.setPodeInserir(podeInserir);
    jsonData['podeAlterar'] = PapelFuncaoDomain.setPodeAlterar(podeAlterar);
    jsonData['podeExcluir'] = PapelFuncaoDomain.setPodeExcluir(podeExcluir);
    jsonData['funcaoModel'] = funcaoModel?.toJson;
    jsonData['funcao'] = funcaoModel?.nome ?? '';

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static PapelFuncaoModel fromPlutoRow(PlutoRow row) {
    return PapelFuncaoModel(
      id: row.cells['id']?.value,
      idPapel: row.cells['idPapel']?.value,
      idFuncao: row.cells['idFuncao']?.value,
      habilitado: row.cells['habilitado']?.value,
      podeInserir: row.cells['podeInserir']?.value,
      podeAlterar: row.cells['podeAlterar']?.value,
      podeExcluir: row.cells['podeExcluir']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'idPapel': PlutoCell(value: idPapel ?? 0),
        'idFuncao': PlutoCell(value: idFuncao ?? 0),
        'habilitado': PlutoCell(value: habilitado ?? ''),
        'podeInserir': PlutoCell(value: podeInserir ?? ''),
        'podeAlterar': PlutoCell(value: podeAlterar ?? ''),
        'podeExcluir': PlutoCell(value: podeExcluir ?? ''),
        'funcao': PlutoCell(value: funcaoModel?.nome ?? ''),
      },
    );
  }

  PapelFuncaoModel clone() {
    return PapelFuncaoModel(
      id: id,
      idPapel: idPapel,
      idFuncao: idFuncao,
      habilitado: habilitado,
      podeInserir: podeInserir,
      podeAlterar: podeAlterar,
      podeExcluir: podeExcluir,
      funcaoModel: FuncaoModel.cloneFrom(funcaoModel),
    );
  }

  static PapelFuncaoModel cloneFrom(PapelFuncaoModel? model) {
    return PapelFuncaoModel(
      id: model?.id,
      idPapel: model?.idPapel,
      idFuncao: model?.idFuncao,
      habilitado: model?.habilitado,
      podeInserir: model?.podeInserir,
      podeAlterar: model?.podeAlterar,
      podeExcluir: model?.podeExcluir,
      funcaoModel: FuncaoModel.cloneFrom(model?.funcaoModel),
    );
  }


}