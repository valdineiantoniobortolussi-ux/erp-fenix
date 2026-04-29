import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:inventario/app/data/model/model_imports.dart';

class InventarioAjusteDetModel {
	int? id;
	int? idInventarioAjusteCab;
	int? idProduto;
	double? valorOriginal;
	double? valorReajuste;
	ProdutoModel? produtoModel;

	InventarioAjusteDetModel({
		this.id,
		this.idInventarioAjusteCab,
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

	InventarioAjusteDetModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idInventarioAjusteCab = jsonData['idInventarioAjusteCab'];
		idProduto = jsonData['idProduto'];
		valorOriginal = jsonData['valorOriginal']?.toDouble();
		valorReajuste = jsonData['valorReajuste']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idInventarioAjusteCab'] = idInventarioAjusteCab != 0 ? idInventarioAjusteCab : null;
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
		idInventarioAjusteCab = plutoRow.cells['idInventarioAjusteCab']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		valorOriginal = plutoRow.cells['valorOriginal']?.value?.toDouble();
		valorReajuste = plutoRow.cells['valorReajuste']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	InventarioAjusteDetModel clone() {
		return InventarioAjusteDetModel(
			id: id,
			idInventarioAjusteCab: idInventarioAjusteCab,
			idProduto: idProduto,
			valorOriginal: valorOriginal,
			valorReajuste: valorReajuste,
		);			
	}

	
}