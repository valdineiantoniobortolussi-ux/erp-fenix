import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:ged/app/data/domain/domain_imports.dart';

class GedDocumentoDetalheModel {
	int? id;
	int? idGedDocumentoCabecalho;
	int? idGedTipoDocumento;
	String? nome;
	String? descricao;
	String? palavrasChave;
	String? podeExcluir;
	String? podeAlterar;
	String? assinado;
	DateTime? dataFimVigencia;
	DateTime? dataExclusao;
	GedTipoDocumentoModel? gedTipoDocumentoModel;

	GedDocumentoDetalheModel({
		this.id,
		this.idGedDocumentoCabecalho,
		this.idGedTipoDocumento,
		this.nome,
		this.descricao,
		this.palavrasChave,
		this.podeExcluir,
		this.podeAlterar,
		this.assinado,
		this.dataFimVigencia,
		this.dataExclusao,
		this.gedTipoDocumentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
		'palavras_chave',
		'pode_excluir',
		'pode_alterar',
		'assinado',
		'data_fim_vigencia',
		'data_exclusao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
		'Palavras Chave',
		'Pode Excluir',
		'Pode Alterar',
		'Assinado',
		'Data Fim Vigencia',
		'Data Exclusao',
	];

	GedDocumentoDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idGedDocumentoCabecalho = jsonData['idGedDocumentoCabecalho'];
		idGedTipoDocumento = jsonData['idGedTipoDocumento'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		palavrasChave = jsonData['palavrasChave'];
		podeExcluir = GedDocumentoDetalheDomain.getPodeExcluir(jsonData['podeExcluir']);
		podeAlterar = GedDocumentoDetalheDomain.getPodeAlterar(jsonData['podeAlterar']);
		assinado = GedDocumentoDetalheDomain.getAssinado(jsonData['assinado']);
		dataFimVigencia = jsonData['dataFimVigencia'] != null ? DateTime.tryParse(jsonData['dataFimVigencia']) : null;
		dataExclusao = jsonData['dataExclusao'] != null ? DateTime.tryParse(jsonData['dataExclusao']) : null;
		gedTipoDocumentoModel = jsonData['gedTipoDocumentoModel'] == null ? GedTipoDocumentoModel() : GedTipoDocumentoModel.fromJson(jsonData['gedTipoDocumentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idGedDocumentoCabecalho'] = idGedDocumentoCabecalho != 0 ? idGedDocumentoCabecalho : null;
		jsonData['idGedTipoDocumento'] = idGedTipoDocumento != 0 ? idGedTipoDocumento : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['palavrasChave'] = palavrasChave;
		jsonData['podeExcluir'] = GedDocumentoDetalheDomain.setPodeExcluir(podeExcluir);
		jsonData['podeAlterar'] = GedDocumentoDetalheDomain.setPodeAlterar(podeAlterar);
		jsonData['assinado'] = GedDocumentoDetalheDomain.setAssinado(assinado);
		jsonData['dataFimVigencia'] = dataFimVigencia != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFimVigencia!) : null;
		jsonData['dataExclusao'] = dataExclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataExclusao!) : null;
		jsonData['gedTipoDocumentoModel'] = gedTipoDocumentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idGedDocumentoCabecalho = plutoRow.cells['idGedDocumentoCabecalho']?.value;
		idGedTipoDocumento = plutoRow.cells['idGedTipoDocumento']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		palavrasChave = plutoRow.cells['palavrasChave']?.value;
		podeExcluir = plutoRow.cells['podeExcluir']?.value != '' ? plutoRow.cells['podeExcluir']?.value : 'S';
		podeAlterar = plutoRow.cells['podeAlterar']?.value != '' ? plutoRow.cells['podeAlterar']?.value : 'S';
		assinado = plutoRow.cells['assinado']?.value != '' ? plutoRow.cells['assinado']?.value : 'S';
		dataFimVigencia = Util.stringToDate(plutoRow.cells['dataFimVigencia']?.value);
		dataExclusao = Util.stringToDate(plutoRow.cells['dataExclusao']?.value);
		gedTipoDocumentoModel = GedTipoDocumentoModel();
		gedTipoDocumentoModel?.nome = plutoRow.cells['gedTipoDocumentoModel']?.value;
	}	

	GedDocumentoDetalheModel clone() {
		return GedDocumentoDetalheModel(
			id: id,
			idGedDocumentoCabecalho: idGedDocumentoCabecalho,
			idGedTipoDocumento: idGedTipoDocumento,
			nome: nome,
			descricao: descricao,
			palavrasChave: palavrasChave,
			podeExcluir: podeExcluir,
			podeAlterar: podeAlterar,
			assinado: assinado,
			dataFimVigencia: dataFimVigencia,
			dataExclusao: dataExclusao,
		);			
	}

	
}