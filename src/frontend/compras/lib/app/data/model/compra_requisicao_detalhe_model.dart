import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/data/model/model_imports.dart';

class CompraRequisicaoDetalheModel {
	int? id;
	int? idCompraRequisicao;
	int? idProduto;
	double? quantidade;
	ProdutoModel? produtoModel;

	CompraRequisicaoDetalheModel({
		this.id,
		this.idCompraRequisicao,
		this.idProduto,
		this.quantidade,
		this.produtoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
	];

	CompraRequisicaoDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCompraRequisicao = jsonData['idCompraRequisicao'];
		idProduto = jsonData['idProduto'];
		quantidade = jsonData['quantidade']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCompraRequisicao'] = idCompraRequisicao != 0 ? idCompraRequisicao : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['quantidade'] = quantidade;
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCompraRequisicao = plutoRow.cells['idCompraRequisicao']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	CompraRequisicaoDetalheModel clone() {
		return CompraRequisicaoDetalheModel(
			id: id,
			idCompraRequisicao: idCompraRequisicao,
			idProduto: idProduto,
			quantidade: quantidade,
		);			
	}

	
}