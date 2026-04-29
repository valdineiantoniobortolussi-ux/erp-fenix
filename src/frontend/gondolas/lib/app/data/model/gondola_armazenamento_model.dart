import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaArmazenamentoModel {
	int? id;
	int? idGondolaCaixa;
	int? idProduto;
	int? quantidade;
	ProdutoModel? produtoModel;

	GondolaArmazenamentoModel({
		this.id,
		this.idGondolaCaixa,
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

	GondolaArmazenamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idGondolaCaixa = jsonData['idGondolaCaixa'];
		idProduto = jsonData['idProduto'];
		quantidade = jsonData['quantidade'];
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idGondolaCaixa'] = idGondolaCaixa != 0 ? idGondolaCaixa : null;
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
		idGondolaCaixa = plutoRow.cells['idGondolaCaixa']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidade = plutoRow.cells['quantidade']?.value;
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	GondolaArmazenamentoModel clone() {
		return GondolaArmazenamentoModel(
			id: id,
			idGondolaCaixa: idGondolaCaixa,
			idProduto: idProduto,
			quantidade: quantidade,
		);			
	}

	
}