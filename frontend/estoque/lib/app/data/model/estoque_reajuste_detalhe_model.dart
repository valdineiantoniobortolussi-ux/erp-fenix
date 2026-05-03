import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueReajusteDetalheModel {
	int? id;
	int? idEstoqueReajusteCabecalho;
	int? idProduto;
	double? valorOriginal;
	double? valorReajuste;
	ProdutoModel? produtoModel;

	EstoqueReajusteDetalheModel({
		this.id,
		this.idEstoqueReajusteCabecalho,
		this.idProduto,
		this.valorOriginal,
		this.valorReajuste,
		this.produtoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor_original',
		'valor_reajuste',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor Original',
		'Valor Reajuste',
	];

	EstoqueReajusteDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idEstoqueReajusteCabecalho = jsonData['idEstoqueReajusteCabecalho'];
		idProduto = jsonData['idProduto'];
		valorOriginal = jsonData['valorOriginal']?.toDouble();
		valorReajuste = jsonData['valorReajuste']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idEstoqueReajusteCabecalho'] = idEstoqueReajusteCabecalho != 0 ? idEstoqueReajusteCabecalho : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['valorOriginal'] = valorOriginal;
		jsonData['valorReajuste'] = valorReajuste;
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idEstoqueReajusteCabecalho = plutoRow.cells['idEstoqueReajusteCabecalho']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		valorOriginal = plutoRow.cells['valorOriginal']?.value?.toDouble();
		valorReajuste = plutoRow.cells['valorReajuste']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	EstoqueReajusteDetalheModel clone() {
		return EstoqueReajusteDetalheModel(
			id: id,
			idEstoqueReajusteCabecalho: idEstoqueReajusteCabecalho,
			idProduto: idProduto,
			valorOriginal: valorOriginal,
			valorReajuste: valorReajuste,
		);			
	}

	
}