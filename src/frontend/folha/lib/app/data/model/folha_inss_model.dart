import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaInssModel {
	int? id;
	String? competencia;
	List<FolhaInssRetencaoModel>? folhaInssRetencaoModelList;

	FolhaInssModel({
		this.id,
		this.competencia,
		this.folhaInssRetencaoModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
	];

	FolhaInssModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		competencia = jsonData['competencia'];
		folhaInssRetencaoModelList = (jsonData['folhaInssRetencaoModelList'] as Iterable?)?.map((m) => FolhaInssRetencaoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		
		var folhaInssRetencaoModelLocalList = []; 
		for (FolhaInssRetencaoModel object in folhaInssRetencaoModelList ?? []) { 
			folhaInssRetencaoModelLocalList.add(object.toJson); 
		}
		jsonData['folhaInssRetencaoModelList'] = folhaInssRetencaoModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		folhaInssRetencaoModelList = [];
	}	

	FolhaInssModel clone() {
		return FolhaInssModel(
			id: id,
			competencia: competencia,
			folhaInssRetencaoModelList: folhaInssRetencaoModelListClone(folhaInssRetencaoModelList!),
		);			
	}

	folhaInssRetencaoModelListClone(List<FolhaInssRetencaoModel> folhaInssRetencaoModelList) { 
		List<FolhaInssRetencaoModel> resultList = [];
		for (var folhaInssRetencaoModel in folhaInssRetencaoModelList) {
			resultList.add(
				FolhaInssRetencaoModel(
					id: folhaInssRetencaoModel.id,
					idFolhaInss: folhaInssRetencaoModel.idFolhaInss,
					idFolhaInssServico: folhaInssRetencaoModel.idFolhaInssServico,
					valorMensal: folhaInssRetencaoModel.valorMensal,
					valor13: folhaInssRetencaoModel.valor13,
				)
			);
		}
		return resultList;
	}

	
}