import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ordem_servico/app/data/model/model_imports.dart';

class ProdutoMarcaModel {
	int? id;
	String? nome;
	String? descricao;
	List<ProdutoModel>? produtoModelList;

	ProdutoMarcaModel({
		this.id,
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

	ProdutoMarcaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		produtoModelList = (jsonData['produtoModelList'] as Iterable?)?.map((m) => ProdutoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
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
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		produtoModelList = [];
	}	

	ProdutoMarcaModel clone() {
		return ProdutoMarcaModel(
			id: id,
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