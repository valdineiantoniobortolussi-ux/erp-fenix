import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';


class ViewControleAcessoModel extends ModelBase {
  int? id;
  int? idPessoa;
  String? pessoaNome;
  int? idColaborador;
  int? idUsuario;
  String? administrador;
  int? idPapel;
  String? papelNome;
  String? papelDescricao;
  int? idFuncao;
  String? funcaoNome;
  String? funcaoDescricao;
  int? idPapelFuncao;
  String? habilitado;
  String? podeInserir;
  String? podeAlterar;
  String? podeExcluir;

  ViewControleAcessoModel({
    this.id,
    this.idPessoa,
    this.pessoaNome,
    this.idColaborador,
    this.idUsuario,
    this.administrador,
    this.idPapel,
    this.papelNome,
    this.papelDescricao,
    this.idFuncao,
    this.funcaoNome,
    this.funcaoDescricao,
    this.idPapelFuncao,
    this.habilitado,
    this.podeInserir,
    this.podeAlterar,
    this.podeExcluir,
  });

  static List<String> dbColumns = <String>[
    'id',
    'id_pessoa',
    'pessoa_nome',
    'id_colaborador',
    'id_usuario',
    'administrador',
    'id_papel',
    'papel_nome',
    'papel_descricao',
    'id_funcao',
    'funcao_nome',
    'funcao_descricao',
    'id_papel_funcao',
    'habilitado',
    'pode_inserir',
    'pode_alterar',
    'pode_excluir',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Id Pessoa',
    'Pessoa Nome',
    'Id Colaborador',
    'Id Usuario',
    'Administrador',
    'Id Papel',
    'Papel Nome',
    'Papel Descricao',
    'Id Funcao',
    'Funcao Nome',
    'Funcao Descricao',
    'Id Papel Funcao',
    'Habilitado',
    'Pode Inserir',
    'Pode Alterar',
    'Pode Excluir',
  ];

  ViewControleAcessoModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    idPessoa = jsonData['idPessoa'];
    pessoaNome = jsonData['pessoaNome'];
    idColaborador = jsonData['idColaborador'];
    idUsuario = jsonData['idUsuario'];
    administrador = jsonData['administrador'];
    idPapel = jsonData['idPapel'];
    papelNome = jsonData['papelNome'];
    papelDescricao = jsonData['papelDescricao'];
    idFuncao = jsonData['idFuncao'];
    funcaoNome = jsonData['funcaoNome'];
    funcaoDescricao = jsonData['funcaoDescricao'];
    idPapelFuncao = jsonData['idPapelFuncao'];
    habilitado = jsonData['habilitado'];
    podeInserir = jsonData['podeInserir'];
    podeAlterar = jsonData['podeAlterar'];
    podeExcluir = jsonData['podeExcluir'];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['idPessoa'] = idPessoa;
    jsonData['pessoaNome'] = pessoaNome;
    jsonData['idColaborador'] = idColaborador;
    jsonData['idUsuario'] = idUsuario;
    jsonData['administrador'] = administrador;
    jsonData['idPapel'] = idPapel;
    jsonData['papelNome'] = papelNome;
    jsonData['papelDescricao'] = papelDescricao;
    jsonData['idFuncao'] = idFuncao;
    jsonData['funcaoNome'] = funcaoNome;
    jsonData['funcaoDescricao'] = funcaoDescricao;
    jsonData['idPapelFuncao'] = idPapelFuncao;
    jsonData['habilitado'] = habilitado;
    jsonData['podeInserir'] = podeInserir;
    jsonData['podeAlterar'] = podeAlterar;
    jsonData['podeExcluir'] = podeExcluir;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static ViewControleAcessoModel fromPlutoRow(PlutoRow row) {
    return ViewControleAcessoModel(
      id: row.cells['id']?.value,
      idPessoa: row.cells['idPessoa']?.value,
      pessoaNome: row.cells['pessoaNome']?.value,
      idColaborador: row.cells['idColaborador']?.value,
      idUsuario: row.cells['idUsuario']?.value,
      administrador: row.cells['administrador']?.value,
      idPapel: row.cells['idPapel']?.value,
      papelNome: row.cells['papelNome']?.value,
      papelDescricao: row.cells['papelDescricao']?.value,
      idFuncao: row.cells['idFuncao']?.value,
      funcaoNome: row.cells['funcaoNome']?.value,
      funcaoDescricao: row.cells['funcaoDescricao']?.value,
      idPapelFuncao: row.cells['idPapelFuncao']?.value,
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
        'idPessoa': PlutoCell(value: idPessoa ?? 0),
        'pessoaNome': PlutoCell(value: pessoaNome ?? ''),
        'idColaborador': PlutoCell(value: idColaborador ?? 0),
        'idUsuario': PlutoCell(value: idUsuario ?? 0),
        'administrador': PlutoCell(value: administrador ?? ''),
        'idPapel': PlutoCell(value: idPapel ?? 0),
        'papelNome': PlutoCell(value: papelNome ?? ''),
        'papelDescricao': PlutoCell(value: papelDescricao ?? ''),
        'idFuncao': PlutoCell(value: idFuncao ?? 0),
        'funcaoNome': PlutoCell(value: funcaoNome ?? ''),
        'funcaoDescricao': PlutoCell(value: funcaoDescricao ?? ''),
        'idPapelFuncao': PlutoCell(value: idPapelFuncao ?? 0),
        'habilitado': PlutoCell(value: habilitado ?? ''),
        'podeInserir': PlutoCell(value: podeInserir ?? ''),
        'podeAlterar': PlutoCell(value: podeAlterar ?? ''),
        'podeExcluir': PlutoCell(value: podeExcluir ?? ''),
      },
    );
  }

  ViewControleAcessoModel clone() {
    return ViewControleAcessoModel(
      id: id,
      idPessoa: idPessoa,
      pessoaNome: pessoaNome,
      idColaborador: idColaborador,
      idUsuario: idUsuario,
      administrador: administrador,
      idPapel: idPapel,
      papelNome: papelNome,
      papelDescricao: papelDescricao,
      idFuncao: idFuncao,
      funcaoNome: funcaoNome,
      funcaoDescricao: funcaoDescricao,
      idPapelFuncao: idPapelFuncao,
      habilitado: habilitado,
      podeInserir: podeInserir,
      podeAlterar: podeAlterar,
      podeExcluir: podeExcluir,
    );
  }

  static ViewControleAcessoModel cloneFrom(ViewControleAcessoModel? model) {
    return ViewControleAcessoModel(
      id: model?.id,
      idPessoa: model?.idPessoa,
      pessoaNome: model?.pessoaNome,
      idColaborador: model?.idColaborador,
      idUsuario: model?.idUsuario,
      administrador: model?.administrador,
      idPapel: model?.idPapel,
      papelNome: model?.papelNome,
      papelDescricao: model?.papelDescricao,
      idFuncao: model?.idFuncao,
      funcaoNome: model?.funcaoNome,
      funcaoDescricao: model?.funcaoDescricao,
      idPapelFuncao: model?.idPapelFuncao,
      habilitado: model?.habilitado,
      podeInserir: model?.podeInserir,
      podeAlterar: model?.podeAlterar,
      podeExcluir: model?.podeExcluir,
    );
  }


}