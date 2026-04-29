import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class PessoaJuridicaModel {
	int? id;
	int? idPessoa;
	String? cnpj;
	String? nomeFantasia;
	String? inscricaoEstadual;
	String? inscricaoMunicipal;
	DateTime? dataConstituicao;
	String? tipoRegime;
	String? crt;

	PessoaJuridicaModel({
		this.id,
		this.idPessoa,
		this.cnpj,
		this.nomeFantasia,
		this.inscricaoEstadual,
		this.inscricaoMunicipal,
		this.dataConstituicao,
		this.tipoRegime,
		this.crt,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'nome_fantasia',
		'inscricao_estadual',
		'inscricao_municipal',
		'data_constituicao',
		'tipo_regime',
		'crt',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Nome Fantasia',
		'Inscricao Estadual',
		'Inscricao Municipal',
		'Data Constituicao',
		'Tipo Regime',
		'Crt',
	];

	PessoaJuridicaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		cnpj = jsonData['cnpj'];
		nomeFantasia = jsonData['nomeFantasia'];
		inscricaoEstadual = jsonData['inscricaoEstadual'];
		inscricaoMunicipal = jsonData['inscricaoMunicipal'];
		dataConstituicao = jsonData['dataConstituicao'] != null ? DateTime.tryParse(jsonData['dataConstituicao']) : null;
		tipoRegime = PessoaJuridicaDomain.getTipoRegime(jsonData['tipoRegime']);
		crt = PessoaJuridicaDomain.getCrt(jsonData['crt']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['nomeFantasia'] = nomeFantasia;
		jsonData['inscricaoEstadual'] = inscricaoEstadual;
		jsonData['inscricaoMunicipal'] = inscricaoMunicipal;
		jsonData['dataConstituicao'] = dataConstituicao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataConstituicao!) : null;
		jsonData['tipoRegime'] = PessoaJuridicaDomain.setTipoRegime(tipoRegime);
		jsonData['crt'] = PessoaJuridicaDomain.setCrt(crt);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		nomeFantasia = plutoRow.cells['nomeFantasia']?.value;
		inscricaoEstadual = plutoRow.cells['inscricaoEstadual']?.value;
		inscricaoMunicipal = plutoRow.cells['inscricaoMunicipal']?.value;
		dataConstituicao = Util.stringToDate(plutoRow.cells['dataConstituicao']?.value);
		tipoRegime = plutoRow.cells['tipoRegime']?.value != '' ? plutoRow.cells['tipoRegime']?.value : '1-Lucro Real';
		crt = plutoRow.cells['crt']?.value != '' ? plutoRow.cells['crt']?.value : '1-Simples Nacional';
	}	

	PessoaJuridicaModel clone() {
		return PessoaJuridicaModel(
			id: id,
			idPessoa: idPessoa,
			cnpj: cnpj,
			nomeFantasia: nomeFantasia,
			inscricaoEstadual: inscricaoEstadual,
			inscricaoMunicipal: inscricaoMunicipal,
			dataConstituicao: dataConstituicao,
			tipoRegime: tipoRegime,
			crt: crt,
		);			
	}

	
}