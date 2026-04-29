import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/data/model/model_imports.dart';

class WmsOrdemSeparacaoDetModel {
	int? id;
	int? idWmsOrdemSeparacaoCab;
	int? idProduto;
	int? quantidade;
	ProdutoModel? produtoModel;

	WmsOrdemSeparacaoDetModel({
		this.id,
		this.idWmsOrdemSeparacaoCab,
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

	WmsOrdemSeparacaoDetModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idWmsOrdemSeparacaoCab = jsonData['idWmsOrdemSeparacaoCab'];
		idProduto = jsonData['idProduto'];
		quantidade = jsonData['quantidade'];
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idWmsOrdemSeparacaoCab'] = idWmsOrdemSeparacaoCab != 0 ? idWmsOrdemSeparacaoCab : null;
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
		idWmsOrdemSeparacaoCab = plutoRow.cells['idWmsOrdemSeparacaoCab']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidade = plutoRow.cells['quantidade']?.value;
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	WmsOrdemSeparacaoDetModel clone() {
		return WmsOrdemSeparacaoDetModel(
			id: id,
			idWmsOrdemSeparacaoCab: idWmsOrdemSeparacaoCab,
			idProduto: idProduto,
			quantidade: quantidade,
		);			
	}

	
}