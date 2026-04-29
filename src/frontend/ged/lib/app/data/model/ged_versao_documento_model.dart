import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:ged/app/data/domain/domain_imports.dart';

class GedVersaoDocumentoModel {
	int? id;
	int? idGedDocumentoDetalhe;
	int? idColaborador;
	String? acao;
	int? versao;
	DateTime? dataVersao;
	String? horaVersao;
	String? hashArquivo;
	String? caminho;
	GedDocumentoDetalheModel? gedDocumentoDetalheModel;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	GedVersaoDocumentoModel({
		this.id,
		this.idGedDocumentoDetalhe,
		this.idColaborador,
		this.acao,
		this.versao,
		this.dataVersao,
		this.horaVersao,
		this.hashArquivo,
		this.caminho,
		this.gedDocumentoDetalheModel,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'acao',
		'versao',
		'data_versao',
		'hora_versao',
		'hash_arquivo',
		'caminho',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Acao',
		'Versao',
		'Data Versao',
		'Hora Versao',
		'Hash Arquivo',
		'Caminho',
	];

	GedVersaoDocumentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idGedDocumentoDetalhe = jsonData['idGedDocumentoDetalhe'];
		idColaborador = jsonData['idColaborador'];
		acao = GedVersaoDocumentoDomain.getAcao(jsonData['acao']);
		versao = jsonData['versao'];
		dataVersao = jsonData['dataVersao'] != null ? DateTime.tryParse(jsonData['dataVersao']) : null;
		horaVersao = jsonData['horaVersao'];
		hashArquivo = jsonData['hashArquivo'];
		caminho = jsonData['caminho'];
		gedDocumentoDetalheModel = jsonData['gedDocumentoDetalheModel'] == null ? GedDocumentoDetalheModel() : GedDocumentoDetalheModel.fromJson(jsonData['gedDocumentoDetalheModel']);
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idGedDocumentoDetalhe'] = idGedDocumentoDetalhe != 0 ? idGedDocumentoDetalhe : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['acao'] = GedVersaoDocumentoDomain.setAcao(acao);
		jsonData['versao'] = versao;
		jsonData['dataVersao'] = dataVersao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVersao!) : null;
		jsonData['horaVersao'] = Util.removeMask(horaVersao);
		jsonData['hashArquivo'] = hashArquivo;
		jsonData['caminho'] = caminho;
		jsonData['gedDocumentoDetalheModel'] = gedDocumentoDetalheModel?.toJson;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idGedDocumentoDetalhe = plutoRow.cells['idGedDocumentoDetalhe']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		acao = plutoRow.cells['acao']?.value != '' ? plutoRow.cells['acao']?.value : 'Incluído';
		versao = plutoRow.cells['versao']?.value;
		dataVersao = Util.stringToDate(plutoRow.cells['dataVersao']?.value);
		horaVersao = plutoRow.cells['horaVersao']?.value;
		hashArquivo = plutoRow.cells['hashArquivo']?.value;
		caminho = plutoRow.cells['caminho']?.value;
		gedDocumentoDetalheModel = GedDocumentoDetalheModel();
		gedDocumentoDetalheModel?.nome = plutoRow.cells['gedDocumentoDetalheModel']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	GedVersaoDocumentoModel clone() {
		return GedVersaoDocumentoModel(
			id: id,
			idGedDocumentoDetalhe: idGedDocumentoDetalhe,
			idColaborador: idColaborador,
			acao: acao,
			versao: versao,
			dataVersao: dataVersao,
			horaVersao: horaVersao,
			hashArquivo: hashArquivo,
			caminho: caminho,
		);			
	}

	
}