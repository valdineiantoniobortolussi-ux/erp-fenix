import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/model/model_imports.dart';

class FuncaoModel {
	int? id;
	String? nome;
	String? descricao;
	List<PapelFuncaoModel>? papelFuncaoModelList;

	FuncaoModel({
		this.id,
		this.nome,
		this.descricao,
		this.papelFuncaoModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
	];

	FuncaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		papelFuncaoModelList = (jsonData['papelFuncaoModelList'] as Iterable?)?.map((m) => PapelFuncaoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		
		var papelFuncaoModelLocalList = []; 
		for (PapelFuncaoModel object in papelFuncaoModelList ?? []) { 
			papelFuncaoModelLocalList.add(object.toJson); 
		}
		jsonData['papelFuncaoModelList'] = papelFuncaoModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		papelFuncaoModelList = [];
	}	

	FuncaoModel clone() {
		return FuncaoModel(
			id: id,
			nome: nome,
			descricao: descricao,
			papelFuncaoModelList: papelFuncaoModelListClone(papelFuncaoModelList!),
		);			
	}

	papelFuncaoModelListClone(List<PapelFuncaoModel> papelFuncaoModelList) { 
		List<PapelFuncaoModel> resultList = [];
		for (var papelFuncaoModel in papelFuncaoModelList) {
			resultList.add(
				PapelFuncaoModel(
					id: papelFuncaoModel.id,
					idPapel: papelFuncaoModel.idPapel,
					idFuncao: papelFuncaoModel.idFuncao,
					habilitado: papelFuncaoModel.habilitado,
					podeInserir: papelFuncaoModel.podeInserir,
					podeAlterar: papelFuncaoModel.podeAlterar,
					podeExcluir: papelFuncaoModel.podeExcluir,
				)
			);
		}
		return resultList;
	}

	
}