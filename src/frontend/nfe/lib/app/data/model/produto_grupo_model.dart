import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/model/model_imports.dart';

class ProdutoGrupoModel {
	int? id;
	String? nome;
	String? descricao;
	List<ProdutoSubgrupoModel>? produtoSubgrupoModelList;

	ProdutoGrupoModel({
		this.id,
		this.nome,
		this.descricao,
		this.produtoSubgrupoModelList,
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

	ProdutoGrupoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		produtoSubgrupoModelList = (jsonData['produtoSubgrupoModelList'] as Iterable?)?.map((m) => ProdutoSubgrupoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		
		var produtoSubgrupoModelLocalList = []; 
		for (ProdutoSubgrupoModel object in produtoSubgrupoModelList ?? []) { 
			produtoSubgrupoModelLocalList.add(object.toJson); 
		}
		jsonData['produtoSubgrupoModelList'] = produtoSubgrupoModelLocalList;
	
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
		produtoSubgrupoModelList = [];
	}	

	ProdutoGrupoModel clone() {
		return ProdutoGrupoModel(
			id: id,
			nome: nome,
			descricao: descricao,
			produtoSubgrupoModelList: produtoSubgrupoModelListClone(produtoSubgrupoModelList!),
		);			
	}

	produtoSubgrupoModelListClone(List<ProdutoSubgrupoModel> produtoSubgrupoModelList) { 
		List<ProdutoSubgrupoModel> resultList = [];
		for (var produtoSubgrupoModel in produtoSubgrupoModelList) {
			resultList.add(
				ProdutoSubgrupoModel(
					id: produtoSubgrupoModel.id,
					idProdutoGrupo: produtoSubgrupoModel.idProdutoGrupo,
					nome: produtoSubgrupoModel.nome,
					descricao: produtoSubgrupoModel.descricao,
				)
			);
		}
		return resultList;
	}

	
}