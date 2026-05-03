import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class ViewPessoaColaboradorModel extends ModelBase {
  int? id;
  String? nome;
  String? tipo;
  String? email;
  String? site;
  String? cpfCnpj;
  String? rgIe;
  String? matricula;
  DateTime? dataCadastro;
  DateTime? dataAdmissao;
  DateTime? dataDemissao;
  String? ctpsNumero;
  String? ctpsSerie;
  DateTime? ctpsDataExpedicao;
  String? ctpsUf;
  String? observacao;
  String? logradouro;
  String? numero;
  String? complemento;
  String? bairro;
  String? cidade;
  String? cep;
  String? municipioIbge;
  String? uf;
  int? idPessoa;
  int? idCargo;
  int? idSetor;

  ViewPessoaColaboradorModel({
    this.id,
    this.nome,
    this.tipo = 'AAA',
    this.email,
    this.site,
    this.cpfCnpj,
    this.rgIe,
    this.matricula,
    this.dataCadastro,
    this.dataAdmissao,
    this.dataDemissao,
    this.ctpsNumero,
    this.ctpsSerie,
    this.ctpsDataExpedicao,
    this.ctpsUf = 'AC',
    this.observacao,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.cep,
    this.municipioIbge,
    this.uf = 'AC',
    this.idPessoa,
    this.idCargo,
    this.idSetor,
  });

  static List<String> dbColumns = <String>[
    'id',
    'nome',
    'tipo',
    'email',
    'site',
    'cpf_cnpj',
    'rg_ie',
    'matricula',
    'data_cadastro',
    'data_admissao',
    'data_demissao',
    'ctps_numero',
    'ctps_serie',
    'ctps_data_expedicao',
    'ctps_uf',
    'observacao',
    'logradouro',
    'numero',
    'complemento',
    'bairro',
    'cidade',
    'cep',
    'municipio_ibge',
    'uf',
    'id_pessoa',
    'id_cargo',
    'id_setor',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Nome',
    'Tipo',
    'Email',
    'Site',
    'Cpf Cnpj',
    'Rg Ie',
    'Matricula',
    'Data Cadastro',
    'Data Admissao',
    'Data Demissao',
    'Ctps Numero',
    'Ctps Serie',
    'Ctps Data Expedicao',
    'Ctps Uf',
    'Observacao',
    'Logradouro',
    'Numero',
    'Complemento',
    'Bairro',
    'Cidade',
    'Cep',
    'Municipio Ibge',
    'Uf',
    'Id Pessoa',
    'Id Cargo',
    'Id Setor',
  ];

  ViewPessoaColaboradorModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    nome = jsonData['nome'];
    tipo = ViewPessoaColaboradorDomain.getTipo(jsonData['tipo']);
    email = jsonData['email'];
    site = jsonData['site'];
    cpfCnpj = jsonData['cpfCnpj'];
    rgIe = jsonData['rgIe'];
    matricula = jsonData['matricula'];
    dataCadastro = jsonData['dataCadastro'] != null ? DateTime.tryParse(jsonData['dataCadastro']) : null;
    dataAdmissao = jsonData['dataAdmissao'] != null ? DateTime.tryParse(jsonData['dataAdmissao']) : null;
    dataDemissao = jsonData['dataDemissao'] != null ? DateTime.tryParse(jsonData['dataDemissao']) : null;
    ctpsNumero = jsonData['ctpsNumero'];
    ctpsSerie = jsonData['ctpsSerie'];
    ctpsDataExpedicao = jsonData['ctpsDataExpedicao'] != null ? DateTime.tryParse(jsonData['ctpsDataExpedicao']) : null;
    ctpsUf = ViewPessoaColaboradorDomain.getCtpsUf(jsonData['ctpsUf']);
    observacao = jsonData['observacao'];
    logradouro = jsonData['logradouro'];
    numero = jsonData['numero'];
    complemento = jsonData['complemento'];
    bairro = jsonData['bairro'];
    cidade = jsonData['cidade'];
    cep = jsonData['cep'];
    municipioIbge = jsonData['municipioIbge']?.toString();
    uf = ViewPessoaColaboradorDomain.getUf(jsonData['uf']);
    idPessoa = jsonData['idPessoa'];
    idCargo = jsonData['idCargo'];
    idSetor = jsonData['idSetor'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['nome'] = nome;
    jsonData['tipo'] = ViewPessoaColaboradorDomain.setTipo(tipo);
    jsonData['email'] = email;
    jsonData['site'] = site;
    jsonData['cpfCnpj'] = Util.removeMask(cpfCnpj);
    jsonData['rgIe'] = rgIe;
    jsonData['matricula'] = matricula;
    jsonData['dataCadastro'] = dataCadastro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCadastro!) : null;
    jsonData['dataAdmissao'] = dataAdmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAdmissao!) : null;
    jsonData['dataDemissao'] = dataDemissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDemissao!) : null;
    jsonData['ctpsNumero'] = ctpsNumero;
    jsonData['ctpsSerie'] = ctpsSerie;
    jsonData['ctpsDataExpedicao'] = ctpsDataExpedicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(ctpsDataExpedicao!) : null;
    jsonData['ctpsUf'] = ViewPessoaColaboradorDomain.setCtpsUf(ctpsUf);
    jsonData['observacao'] = observacao;
    jsonData['logradouro'] = logradouro;
    jsonData['numero'] = numero;
    jsonData['complemento'] = complemento;
    jsonData['bairro'] = bairro;
    jsonData['cidade'] = cidade;
    jsonData['cep'] = Util.removeMask(cep);
    jsonData['municipioIbge'] = municipioIbge;
    jsonData['uf'] = ViewPessoaColaboradorDomain.setUf(uf);
    jsonData['idPessoa'] = idPessoa;
    jsonData['idCargo'] = idCargo;
    jsonData['idSetor'] = idSetor;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static ViewPessoaColaboradorModel fromPlutoRow(PlutoRow row) {
    return ViewPessoaColaboradorModel(
      id: row.cells['id']?.value,
      nome: row.cells['nome']?.value,
      tipo: row.cells['tipo']?.value,
      email: row.cells['email']?.value,
      site: row.cells['site']?.value,
      cpfCnpj: row.cells['cpfCnpj']?.value,
      rgIe: row.cells['rgIe']?.value,
      matricula: row.cells['matricula']?.value,
      dataCadastro: Util.stringToDate(row.cells['dataCadastro']?.value),
      dataAdmissao: Util.stringToDate(row.cells['dataAdmissao']?.value),
      dataDemissao: Util.stringToDate(row.cells['dataDemissao']?.value),
      ctpsNumero: row.cells['ctpsNumero']?.value,
      ctpsSerie: row.cells['ctpsSerie']?.value,
      ctpsDataExpedicao: Util.stringToDate(row.cells['ctpsDataExpedicao']?.value),
      ctpsUf: row.cells['ctpsUf']?.value,
      observacao: row.cells['observacao']?.value,
      logradouro: row.cells['logradouro']?.value,
      numero: row.cells['numero']?.value,
      complemento: row.cells['complemento']?.value,
      bairro: row.cells['bairro']?.value,
      cidade: row.cells['cidade']?.value,
      cep: row.cells['cep']?.value,
      municipioIbge: row.cells['municipioIbge']?.value,
      uf: row.cells['uf']?.value,
      idPessoa: row.cells['idPessoa']?.value,
      idCargo: row.cells['idCargo']?.value,
      idSetor: row.cells['idSetor']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'nome': PlutoCell(value: nome ?? ''),
        'tipo': PlutoCell(value: tipo ?? ''),
        'email': PlutoCell(value: email ?? ''),
        'site': PlutoCell(value: site ?? ''),
        'cpfCnpj': PlutoCell(value: cpfCnpj ?? ''),
        'rgIe': PlutoCell(value: rgIe ?? ''),
        'matricula': PlutoCell(value: matricula ?? ''),
        'dataCadastro': PlutoCell(value: dataCadastro),
        'dataAdmissao': PlutoCell(value: dataAdmissao),
        'dataDemissao': PlutoCell(value: dataDemissao),
        'ctpsNumero': PlutoCell(value: ctpsNumero ?? ''),
        'ctpsSerie': PlutoCell(value: ctpsSerie ?? ''),
        'ctpsDataExpedicao': PlutoCell(value: ctpsDataExpedicao),
        'ctpsUf': PlutoCell(value: ctpsUf ?? ''),
        'observacao': PlutoCell(value: observacao ?? ''),
        'logradouro': PlutoCell(value: logradouro ?? ''),
        'numero': PlutoCell(value: numero ?? ''),
        'complemento': PlutoCell(value: complemento ?? ''),
        'bairro': PlutoCell(value: bairro ?? ''),
        'cidade': PlutoCell(value: cidade ?? ''),
        'cep': PlutoCell(value: cep ?? ''),
        'municipioIbge': PlutoCell(value: municipioIbge ?? ''),
        'uf': PlutoCell(value: uf ?? ''),
        'idPessoa': PlutoCell(value: idPessoa ?? 0),
        'idCargo': PlutoCell(value: idCargo ?? 0),
        'idSetor': PlutoCell(value: idSetor ?? 0),
      },
    );
  }

  ViewPessoaColaboradorModel clone() {
    return ViewPessoaColaboradorModel(
      id: id,
      nome: nome,
      tipo: tipo,
      email: email,
      site: site,
      cpfCnpj: cpfCnpj,
      rgIe: rgIe,
      matricula: matricula,
      dataCadastro: dataCadastro,
      dataAdmissao: dataAdmissao,
      dataDemissao: dataDemissao,
      ctpsNumero: ctpsNumero,
      ctpsSerie: ctpsSerie,
      ctpsDataExpedicao: ctpsDataExpedicao,
      ctpsUf: ctpsUf,
      observacao: observacao,
      logradouro: logradouro,
      numero: numero,
      complemento: complemento,
      bairro: bairro,
      cidade: cidade,
      cep: cep,
      municipioIbge: municipioIbge,
      uf: uf,
      idPessoa: idPessoa,
      idCargo: idCargo,
      idSetor: idSetor,
    );
  }

  static ViewPessoaColaboradorModel cloneFrom(ViewPessoaColaboradorModel? model) {
    return ViewPessoaColaboradorModel(
      id: model?.id,
      nome: model?.nome,
      tipo: model?.tipo,
      email: model?.email,
      site: model?.site,
      cpfCnpj: model?.cpfCnpj,
      rgIe: model?.rgIe,
      matricula: model?.matricula,
      dataCadastro: model?.dataCadastro,
      dataAdmissao: model?.dataAdmissao,
      dataDemissao: model?.dataDemissao,
      ctpsNumero: model?.ctpsNumero,
      ctpsSerie: model?.ctpsSerie,
      ctpsDataExpedicao: model?.ctpsDataExpedicao,
      ctpsUf: model?.ctpsUf,
      observacao: model?.observacao,
      logradouro: model?.logradouro,
      numero: model?.numero,
      complemento: model?.complemento,
      bairro: model?.bairro,
      cidade: model?.cidade,
      cep: model?.cep,
      municipioIbge: model?.municipioIbge,
      uf: model?.uf,
      idPessoa: model?.idPessoa,
      idCargo: model?.idCargo,
      idSetor: model?.idSetor,
    );
  }


}