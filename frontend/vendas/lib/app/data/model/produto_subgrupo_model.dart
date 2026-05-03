import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/data/model/model_imports.dart';

class ProdutoSubgrupoModel {
	int? id;
	int? idProdutoGrupo;
	String? nome;
	String? descricao;
	List<ProdutoModel>? produtoModelList;

	ProdutoSubgrupoModel({
		this.id,
		this.idProdutoGrupo,
		this.nome,
		this.descricao,
		this.produtoModelList,
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

	ProdutoSubgrupoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProdutoGrupo = jsonData['idProdutoGrupo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		produtoModelList = (jsonData['produtoModelList'] as Iterable?)?.map((m) => ProdutoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProdutoGrupo'] = idProdutoGrupo != 0 ? idProdutoGrupo : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		
		var produtoModelLocalList = []; 
		for (ProdutoModel object in produtoModelList ?? []) { 
			produtoModelLocalList.add(object.toJson); 
		}
		jsonData['produtoModelList'] = produtoModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProdutoGrupo = plutoRow.cells['idProdutoGrupo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		produtoModelList = [];
	}	

	ProdutoSubgrupoModel clone() {
		return ProdutoSubgrupoModel(
			id: id,
			idProdutoGrupo: idProdutoGrupo,
			nome: nome,
			descricao: descricao,
			produtoModelList: produtoModelListClone(produtoModelList!),
		);			
	}

	produtoModelListClone(List<ProdutoModel> produtoModelList) { 
		List<ProdutoModel> resultList = [];
		for (var produtoModel in produtoModelList) {
			resultList.add(
				ProdutoModel(
					id: produtoModel.id,
					idProdutoSubgrupo: produtoModel.idProdutoSubgrupo,
					idProdutoMarca: produtoModel.idProdutoMarca,
					idProdutoUnidade: produtoModel.idProdutoUnidade,
					idTributIcmsCustomCab: produtoModel.idTributIcmsCustomCab,
					idTributGrupoTributario: produtoModel.idTributGrupoTributario,
					nome: produtoModel.nome,
					descricao: produtoModel.descricao,
					gtin: produtoModel.gtin,
					codigoInterno: produtoModel.codigoInterno,
					valorCompra: produtoModel.valorCompra,
					valorVenda: produtoModel.valorVenda,
					codigoNcm: produtoModel.codigoNcm,
					estoqueMinimo: produtoModel.estoqueMinimo,
					estoqueMaximo: produtoModel.estoqueMaximo,
					quantidadeEstoque: produtoModel.quantidadeEstoque,
					dataCadastro: produtoModel.dataCadastro,
				)
			);
		}
		return resultList;
	}

	
}