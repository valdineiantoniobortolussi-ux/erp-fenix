import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/data/domain/domain_imports.dart';

class ProdutoUnidadeModel {
	int? id;
	String? sigla;
	String? descricao;
	String? podeFracionar;
	List<ProdutoModel>? produtoModelList;

	ProdutoUnidadeModel({
		this.id,
		this.sigla,
		this.descricao,
		this.podeFracionar,
		this.produtoModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'sigla',
		'descricao',
		'pode_fracionar',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Sigla',
		'Descricao',
		'Pode Fracionar',
	];

	ProdutoUnidadeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		sigla = jsonData['sigla'];
		descricao = jsonData['descricao'];
		podeFracionar = ProdutoUnidadeDomain.getPodeFracionar(jsonData['podeFracionar']);
		produtoModelList = (jsonData['produtoModelList'] as Iterable?)?.map((m) => ProdutoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['sigla'] = sigla;
		jsonData['descricao'] = descricao;
		jsonData['podeFracionar'] = ProdutoUnidadeDomain.setPodeFracionar(podeFracionar);
		
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
		sigla = plutoRow.cells['sigla']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		podeFracionar = plutoRow.cells['podeFracionar']?.value != '' ? plutoRow.cells['podeFracionar']?.value : 'AAA';
		produtoModelList = [];
	}	

	ProdutoUnidadeModel clone() {
		return ProdutoUnidadeModel(
			id: id,
			sigla: sigla,
			descricao: descricao,
			podeFracionar: podeFracionar,
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