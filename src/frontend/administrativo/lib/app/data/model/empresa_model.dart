import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';

import 'package:administrativo/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:administrativo/app/data/domain/domain_imports.dart';

class EmpresaModel extends ModelBase {
  int? id;
  String? razaoSocial;
  String? nomeFantasia;
  String? cnpj;
  String? inscricaoEstadual;
  String? inscricaoMunicipal;
  String? tipoRegime;
  String? crt;
  String? email;
  String? site;
  String? contato;
  DateTime? dataConstituicao;
  String? tipo;
  String? inscricaoJuntaComercial;
  DateTime? dataInscJuntaComercial;
  int? codigoIbgeCidade;
  int? codigoIbgeUf;
  String? cei;
  String? codigoCnaePrincipal;
  String? imagemLogotipo;
  List<EmpresaContatoModel>? empresaContatoModelList;
  List<EmpresaTelefoneModel>? empresaTelefoneModelList;
  List<EmpresaCnaeModel>? empresaCnaeModelList;
  List<EmpresaEnderecoModel>? empresaEnderecoModelList;

  EmpresaModel({
    this.id,
    this.razaoSocial,
    this.nomeFantasia,
    this.cnpj,
    this.inscricaoEstadual,
    this.inscricaoMunicipal,
    this.tipoRegime = '1-Lucro Real',
    this.crt = '1-Simples Nacional',
    this.email,
    this.site,
    this.contato,
    this.dataConstituicao,
    this.tipo = 'Matriz',
    this.inscricaoJuntaComercial,
    this.dataInscJuntaComercial,
    this.codigoIbgeCidade,
    this.codigoIbgeUf,
    this.cei,
    this.codigoCnaePrincipal,
    this.imagemLogotipo,
    List<EmpresaContatoModel>? empresaContatoModelList,
    List<EmpresaTelefoneModel>? empresaTelefoneModelList,
    List<EmpresaCnaeModel>? empresaCnaeModelList,
    List<EmpresaEnderecoModel>? empresaEnderecoModelList,
  }) {
    this.empresaContatoModelList = empresaContatoModelList?.toList(growable: true) ?? [];
    this.empresaTelefoneModelList = empresaTelefoneModelList?.toList(growable: true) ?? [];
    this.empresaCnaeModelList = empresaCnaeModelList?.toList(growable: true) ?? [];
    this.empresaEnderecoModelList = empresaEnderecoModelList?.toList(growable: true) ?? [];
  }

  static List<String> dbColumns = <String>[
    'id',
    'razao_social',
    'nome_fantasia',
    'cnpj',
    'inscricao_estadual',
    'inscricao_municipal',
    'tipo_regime',
    'crt',
    'email',
    'site',
    'contato',
    'data_constituicao',
    'tipo',
    'inscricao_junta_comercial',
    'data_insc_junta_comercial',
    'codigo_ibge_cidade',
    'codigo_ibge_uf',
    'cei',
    'codigo_cnae_principal',
    'imagem_logotipo',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Razao Social',
    'Nome Fantasia',
    'Cnpj',
    'Inscricao Estadual',
    'Inscricao Municipal',
    'Tipo Regime',
    'Crt',
    'Email',
    'Site',
    'Contato',
    'Data Constituicao',
    'Tipo',
    'Inscricao Junta Comercial',
    'Data Insc Junta Comercial',
    'Codigo Ibge Cidade',
    'Codigo Ibge Uf',
    'Cei',
    'Codigo Cnae Principal',
    'Imagem Logotipo',
  ];

  EmpresaModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    razaoSocial = jsonData['razaoSocial'];
    nomeFantasia = jsonData['nomeFantasia'];
    cnpj = jsonData['cnpj'];
    inscricaoEstadual = jsonData['inscricaoEstadual'];
    inscricaoMunicipal = jsonData['inscricaoMunicipal'];
    tipoRegime = EmpresaDomain.getTipoRegime(jsonData['tipoRegime']);
    crt = EmpresaDomain.getCrt(jsonData['crt']);
    email = jsonData['email'];
    site = jsonData['site'];
    contato = jsonData['contato'];
    dataConstituicao = jsonData['dataConstituicao'] != null ? DateTime.tryParse(jsonData['dataConstituicao']) : null;
    tipo = EmpresaDomain.getTipo(jsonData['tipo']);
    inscricaoJuntaComercial = jsonData['inscricaoJuntaComercial'];
    dataInscJuntaComercial = jsonData['dataInscJuntaComercial'] != null ? DateTime.tryParse(jsonData['dataInscJuntaComercial']) : null;
    codigoIbgeCidade = jsonData['codigoIbgeCidade'];
    codigoIbgeUf = jsonData['codigoIbgeUf'];
    cei = jsonData['cei'];
    codigoCnaePrincipal = jsonData['codigoCnaePrincipal'];
    imagemLogotipo = jsonData['imagemLogotipo'];
    empresaContatoModelList = (jsonData['empresaContatoModelList'] as Iterable?)?.map((m) => EmpresaContatoModel.fromJson(m)).toList() ?? [];
    empresaTelefoneModelList = (jsonData['empresaTelefoneModelList'] as Iterable?)?.map((m) => EmpresaTelefoneModel.fromJson(m)).toList() ?? [];
    empresaCnaeModelList = (jsonData['empresaCnaeModelList'] as Iterable?)?.map((m) => EmpresaCnaeModel.fromJson(m)).toList() ?? [];
    empresaEnderecoModelList = (jsonData['empresaEnderecoModelList'] as Iterable?)?.map((m) => EmpresaEnderecoModel.fromJson(m)).toList() ?? [];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['razaoSocial'] = razaoSocial;
    jsonData['nomeFantasia'] = nomeFantasia;
    jsonData['cnpj'] = Util.removeMask(cnpj);
    jsonData['inscricaoEstadual'] = inscricaoEstadual;
    jsonData['inscricaoMunicipal'] = inscricaoMunicipal;
    jsonData['tipoRegime'] = EmpresaDomain.setTipoRegime(tipoRegime);
    jsonData['crt'] = EmpresaDomain.setCrt(crt);
    jsonData['email'] = email;
    jsonData['site'] = site;
    jsonData['contato'] = contato;
    jsonData['dataConstituicao'] = dataConstituicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataConstituicao!) : null;
    jsonData['tipo'] = EmpresaDomain.setTipo(tipo);
    jsonData['inscricaoJuntaComercial'] = inscricaoJuntaComercial;
    jsonData['dataInscJuntaComercial'] = dataInscJuntaComercial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInscJuntaComercial!) : null;
    jsonData['codigoIbgeCidade'] = codigoIbgeCidade;
    jsonData['codigoIbgeUf'] = codigoIbgeUf;
    jsonData['cei'] = cei;
    jsonData['codigoCnaePrincipal'] = codigoCnaePrincipal;
    jsonData['imagemLogotipo'] = imagemLogotipo;
    
		var empresaContatoModelLocalList = []; 
		for (EmpresaContatoModel object in empresaContatoModelList ?? []) { 
			empresaContatoModelLocalList.add(object.toJson); 
		}
		jsonData['empresaContatoModelList'] = empresaContatoModelLocalList;
    
		var empresaTelefoneModelLocalList = []; 
		for (EmpresaTelefoneModel object in empresaTelefoneModelList ?? []) { 
			empresaTelefoneModelLocalList.add(object.toJson); 
		}
		jsonData['empresaTelefoneModelList'] = empresaTelefoneModelLocalList;
    
		var empresaCnaeModelLocalList = []; 
		for (EmpresaCnaeModel object in empresaCnaeModelList ?? []) { 
			empresaCnaeModelLocalList.add(object.toJson); 
		}
		jsonData['empresaCnaeModelList'] = empresaCnaeModelLocalList;
    
		var empresaEnderecoModelLocalList = []; 
		for (EmpresaEnderecoModel object in empresaEnderecoModelList ?? []) { 
			empresaEnderecoModelLocalList.add(object.toJson); 
		}
		jsonData['empresaEnderecoModelList'] = empresaEnderecoModelLocalList;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static EmpresaModel fromPlutoRow(PlutoRow row) {
    return EmpresaModel(
      id: row.cells['id']?.value,
      razaoSocial: row.cells['razaoSocial']?.value,
      nomeFantasia: row.cells['nomeFantasia']?.value,
      cnpj: row.cells['cnpj']?.value,
      inscricaoEstadual: row.cells['inscricaoEstadual']?.value,
      inscricaoMunicipal: row.cells['inscricaoMunicipal']?.value,
      tipoRegime: row.cells['tipoRegime']?.value,
      crt: row.cells['crt']?.value,
      email: row.cells['email']?.value,
      site: row.cells['site']?.value,
      contato: row.cells['contato']?.value,
      dataConstituicao: Util.stringToDate(row.cells['dataConstituicao']?.value),
      tipo: row.cells['tipo']?.value,
      inscricaoJuntaComercial: row.cells['inscricaoJuntaComercial']?.value,
      dataInscJuntaComercial: Util.stringToDate(row.cells['dataInscJuntaComercial']?.value),
      codigoIbgeCidade: row.cells['codigoIbgeCidade']?.value,
      codigoIbgeUf: row.cells['codigoIbgeUf']?.value,
      cei: row.cells['cei']?.value,
      codigoCnaePrincipal: row.cells['codigoCnaePrincipal']?.value,
      imagemLogotipo: row.cells['imagemLogotipo']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'razaoSocial': PlutoCell(value: razaoSocial ?? ''),
        'nomeFantasia': PlutoCell(value: nomeFantasia ?? ''),
        'cnpj': PlutoCell(value: cnpj ?? ''),
        'inscricaoEstadual': PlutoCell(value: inscricaoEstadual ?? ''),
        'inscricaoMunicipal': PlutoCell(value: inscricaoMunicipal ?? ''),
        'tipoRegime': PlutoCell(value: tipoRegime ?? ''),
        'crt': PlutoCell(value: crt ?? ''),
        'email': PlutoCell(value: email ?? ''),
        'site': PlutoCell(value: site ?? ''),
        'contato': PlutoCell(value: contato ?? ''),
        'dataConstituicao': PlutoCell(value: dataConstituicao),
        'tipo': PlutoCell(value: tipo ?? ''),
        'inscricaoJuntaComercial': PlutoCell(value: inscricaoJuntaComercial ?? ''),
        'dataInscJuntaComercial': PlutoCell(value: dataInscJuntaComercial),
        'codigoIbgeCidade': PlutoCell(value: codigoIbgeCidade ?? 0),
        'codigoIbgeUf': PlutoCell(value: codigoIbgeUf ?? 0),
        'cei': PlutoCell(value: cei ?? ''),
        'codigoCnaePrincipal': PlutoCell(value: codigoCnaePrincipal ?? ''),
        'imagemLogotipo': PlutoCell(value: imagemLogotipo ?? ''),
      },
    );
  }

  EmpresaModel clone() {
    return EmpresaModel(
      id: id,
      razaoSocial: razaoSocial,
      nomeFantasia: nomeFantasia,
      cnpj: cnpj,
      inscricaoEstadual: inscricaoEstadual,
      inscricaoMunicipal: inscricaoMunicipal,
      tipoRegime: tipoRegime,
      crt: crt,
      email: email,
      site: site,
      contato: contato,
      dataConstituicao: dataConstituicao,
      tipo: tipo,
      inscricaoJuntaComercial: inscricaoJuntaComercial,
      dataInscJuntaComercial: dataInscJuntaComercial,
      codigoIbgeCidade: codigoIbgeCidade,
      codigoIbgeUf: codigoIbgeUf,
      cei: cei,
      codigoCnaePrincipal: codigoCnaePrincipal,
      imagemLogotipo: imagemLogotipo,
      empresaContatoModelList: empresaContatoModelListClone(empresaContatoModelList!),
      empresaTelefoneModelList: empresaTelefoneModelListClone(empresaTelefoneModelList!),
      empresaCnaeModelList: empresaCnaeModelListClone(empresaCnaeModelList!),
      empresaEnderecoModelList: empresaEnderecoModelListClone(empresaEnderecoModelList!),
    );
  }

  static EmpresaModel cloneFrom(EmpresaModel? model) {
    return EmpresaModel(
      id: model?.id,
      razaoSocial: model?.razaoSocial,
      nomeFantasia: model?.nomeFantasia,
      cnpj: model?.cnpj,
      inscricaoEstadual: model?.inscricaoEstadual,
      inscricaoMunicipal: model?.inscricaoMunicipal,
      tipoRegime: model?.tipoRegime,
      crt: model?.crt,
      email: model?.email,
      site: model?.site,
      contato: model?.contato,
      dataConstituicao: model?.dataConstituicao,
      tipo: model?.tipo,
      inscricaoJuntaComercial: model?.inscricaoJuntaComercial,
      dataInscJuntaComercial: model?.dataInscJuntaComercial,
      codigoIbgeCidade: model?.codigoIbgeCidade,
      codigoIbgeUf: model?.codigoIbgeUf,
      cei: model?.cei,
      codigoCnaePrincipal: model?.codigoCnaePrincipal,
      imagemLogotipo: model?.imagemLogotipo,
    );
  }

  empresaContatoModelListClone(List<EmpresaContatoModel> empresaContatoModelList) { 
		List<EmpresaContatoModel> resultList = [];
		for (var empresaContatoModel in empresaContatoModelList) {
			resultList.add(EmpresaContatoModel.cloneFrom(empresaContatoModel));
		}
		return resultList;
	}

  empresaTelefoneModelListClone(List<EmpresaTelefoneModel> empresaTelefoneModelList) { 
		List<EmpresaTelefoneModel> resultList = [];
		for (var empresaTelefoneModel in empresaTelefoneModelList) {
			resultList.add(EmpresaTelefoneModel.cloneFrom(empresaTelefoneModel));
		}
		return resultList;
	}

  empresaCnaeModelListClone(List<EmpresaCnaeModel> empresaCnaeModelList) { 
		List<EmpresaCnaeModel> resultList = [];
		for (var empresaCnaeModel in empresaCnaeModelList) {
			resultList.add(EmpresaCnaeModel.cloneFrom(empresaCnaeModel));
		}
		return resultList;
	}

  empresaEnderecoModelListClone(List<EmpresaEnderecoModel> empresaEnderecoModelList) { 
		List<EmpresaEnderecoModel> resultList = [];
		for (var empresaEnderecoModel in empresaEnderecoModelList) {
			resultList.add(EmpresaEnderecoModel.cloneFrom(empresaEnderecoModel));
		}
		return resultList;
	}


}