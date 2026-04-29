import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class EmpresaEnderecoModel extends ModelBase {
  int? id;
  int? idEmpresa;
  String? logradouro;
  String? numero;
  String? bairro;
  String? cidade;
  String? uf;
  String? cep;
  int? municipioIbge;
  String? complemento;
  String? principal;
  String? entrega;
  String? cobranca;
  String? correspondencia;

  EmpresaEnderecoModel({
    this.id,
    this.idEmpresa,
    this.logradouro,
    this.numero,
    this.bairro,
    this.cidade,
    this.uf = 'AC',
    this.cep,
    this.municipioIbge,
    this.complemento,
    this.principal = 'Sim',
    this.entrega = 'Sim',
    this.cobranca = 'Sim',
    this.correspondencia = 'Sim',
  });

  static List<String> dbColumns = <String>[
    'id',
    'logradouro',
    'numero',
    'bairro',
    'cidade',
    'uf',
    'cep',
    'municipio_ibge',
    'complemento',
    'principal',
    'entrega',
    'cobranca',
    'correspondencia',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Logradouro',
    'Numero',
    'Bairro',
    'Cidade',
    'Uf',
    'Cep',
    'Municipio Ibge',
    'Complemento',
    'Principal',
    'Entrega',
    'Cobranca',
    'Correspondencia',
  ];

  EmpresaEnderecoModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    idEmpresa = jsonData['idEmpresa'];
    logradouro = jsonData['logradouro'];
    numero = jsonData['numero'];
    bairro = jsonData['bairro'];
    cidade = jsonData['cidade'];
    uf = EmpresaEnderecoDomain.getUf(jsonData['uf']);
    cep = jsonData['cep'];
    municipioIbge = jsonData['municipioIbge'];
    complemento = jsonData['complemento'];
    principal = EmpresaEnderecoDomain.getPrincipal(jsonData['principal']);
    entrega = EmpresaEnderecoDomain.getEntrega(jsonData['entrega']);
    cobranca = EmpresaEnderecoDomain.getCobranca(jsonData['cobranca']);
    correspondencia = EmpresaEnderecoDomain.getCorrespondencia(jsonData['correspondencia']);
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['idEmpresa'] = idEmpresa != 0 ? idEmpresa : null;
    jsonData['logradouro'] = logradouro;
    jsonData['numero'] = numero;
    jsonData['bairro'] = bairro;
    jsonData['cidade'] = cidade;
    jsonData['uf'] = EmpresaEnderecoDomain.setUf(uf);
    jsonData['cep'] = Util.removeMask(cep);
    jsonData['municipioIbge'] = municipioIbge;
    jsonData['complemento'] = complemento;
    jsonData['principal'] = EmpresaEnderecoDomain.setPrincipal(principal);
    jsonData['entrega'] = EmpresaEnderecoDomain.setEntrega(entrega);
    jsonData['cobranca'] = EmpresaEnderecoDomain.setCobranca(cobranca);
    jsonData['correspondencia'] = EmpresaEnderecoDomain.setCorrespondencia(correspondencia);

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static EmpresaEnderecoModel fromPlutoRow(PlutoRow row) {
    return EmpresaEnderecoModel(
      id: row.cells['id']?.value,
      idEmpresa: row.cells['idEmpresa']?.value,
      logradouro: row.cells['logradouro']?.value,
      numero: row.cells['numero']?.value,
      bairro: row.cells['bairro']?.value,
      cidade: row.cells['cidade']?.value,
      uf: row.cells['uf']?.value,
      cep: row.cells['cep']?.value,
      municipioIbge: row.cells['municipioIbge']?.value,
      complemento: row.cells['complemento']?.value,
      principal: row.cells['principal']?.value,
      entrega: row.cells['entrega']?.value,
      cobranca: row.cells['cobranca']?.value,
      correspondencia: row.cells['correspondencia']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'idEmpresa': PlutoCell(value: idEmpresa ?? 0),
        'logradouro': PlutoCell(value: logradouro ?? ''),
        'numero': PlutoCell(value: numero ?? ''),
        'bairro': PlutoCell(value: bairro ?? ''),
        'cidade': PlutoCell(value: cidade ?? ''),
        'uf': PlutoCell(value: uf ?? ''),
        'cep': PlutoCell(value: cep ?? ''),
        'municipioIbge': PlutoCell(value: municipioIbge ?? 0),
        'complemento': PlutoCell(value: complemento ?? ''),
        'principal': PlutoCell(value: principal ?? ''),
        'entrega': PlutoCell(value: entrega ?? ''),
        'cobranca': PlutoCell(value: cobranca ?? ''),
        'correspondencia': PlutoCell(value: correspondencia ?? ''),
      },
    );
  }

  EmpresaEnderecoModel clone() {
    return EmpresaEnderecoModel(
      id: id,
      idEmpresa: idEmpresa,
      logradouro: logradouro,
      numero: numero,
      bairro: bairro,
      cidade: cidade,
      uf: uf,
      cep: cep,
      municipioIbge: municipioIbge,
      complemento: complemento,
      principal: principal,
      entrega: entrega,
      cobranca: cobranca,
      correspondencia: correspondencia,
    );
  }

  static EmpresaEnderecoModel cloneFrom(EmpresaEnderecoModel? model) {
    return EmpresaEnderecoModel(
      id: model?.id,
      idEmpresa: model?.idEmpresa,
      logradouro: model?.logradouro,
      numero: model?.numero,
      bairro: model?.bairro,
      cidade: model?.cidade,
      uf: model?.uf,
      cep: model?.cep,
      municipioIbge: model?.municipioIbge,
      complemento: model?.complemento,
      principal: model?.principal,
      entrega: model?.entrega,
      cobranca: model?.cobranca,
      correspondencia: model?.correspondencia,
    );
  }


}