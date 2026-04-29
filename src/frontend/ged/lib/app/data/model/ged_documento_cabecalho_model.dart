import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ged/app/infra/infra_imports.dart';
import 'package:ged/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class GedDocumentoCabecalhoModel {
	int? id;
	String? nome;
	DateTime? dataInclusao;
	String? descricao;
	List<GedDocumentoDetalheModel>? gedDocumentoDetalheModelList;

	GedDocumentoCabecalhoModel({
		this.id,
		this.nome,
		this.dataInclusao,
		this.descricao,
		this.gedDocumentoDetalheModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'data_inclusao',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Data Inclusao',
		'Descricao',
	];

	GedDocumentoCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
		descricao = jsonData['descricao'];
		gedDocumentoDetalheModelList = (jsonData['gedDocumentoDetalheModelList'] as Iterable?)?.map((m) => GedDocumentoDetalheModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
		jsonData['descricao'] = descricao;
		
		var gedDocumentoDetalheModelLocalList = []; 
		for (GedDocumentoDetalheModel object in gedDocumentoDetalheModelList ?? []) { 
			gedDocumentoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['gedDocumentoDetalheModelList'] = gedDocumentoDetalheModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
		descricao = plutoRow.cells['descricao']?.value;
		gedDocumentoDetalheModelList = [];
	}	

	GedDocumentoCabecalhoModel clone() {
		return GedDocumentoCabecalhoModel(
			id: id,
			nome: nome,
			dataInclusao: dataInclusao,
			descricao: descricao,
			gedDocumentoDetalheModelList: gedDocumentoDetalheModelListClone(gedDocumentoDetalheModelList!),
		);			
	}

	gedDocumentoDetalheModelListClone(List<GedDocumentoDetalheModel> gedDocumentoDetalheModelList) { 
		List<GedDocumentoDetalheModel> resultList = [];
		for (var gedDocumentoDetalheModel in gedDocumentoDetalheModelList) {
			resultList.add(
				GedDocumentoDetalheModel(
					id: gedDocumentoDetalheModel.id,
					idGedDocumentoCabecalho: gedDocumentoDetalheModel.idGedDocumentoCabecalho,
					idGedTipoDocumento: gedDocumentoDetalheModel.idGedTipoDocumento,
					nome: gedDocumentoDetalheModel.nome,
					descricao: gedDocumentoDetalheModel.descricao,
					palavrasChave: gedDocumentoDetalheModel.palavrasChave,
					podeExcluir: gedDocumentoDetalheModel.podeExcluir,
					podeAlterar: gedDocumentoDetalheModel.podeAlterar,
					assinado: gedDocumentoDetalheModel.assinado,
					dataFimVigencia: gedDocumentoDetalheModel.dataFimVigencia,
					dataExclusao: gedDocumentoDetalheModel.dataExclusao,
				)
			);
		}
		return resultList;
	}

	
}