import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:estoque/app/data/model/model_imports.dart';

class EstoqueGradeModel {
	int? id;
	int? idProduto;
	int? idEstoqueMarca;
	int? idEstoqueSabor;
	int? idEstoqueTamanho;
	int? idEstoqueCor;
	String? codigo;
	double? quantidade;
	ProdutoModel? produtoModel;
	EstoqueCorModel? estoqueCorModel;
	EstoqueTamanhoModel? estoqueTamanhoModel;
	EstoqueSaborModel? estoqueSaborModel;
	EstoqueMarcaModel? estoqueMarcaModel;

	EstoqueGradeModel({
		this.id,
		this.idProduto,
		this.idEstoqueMarca,
		this.idEstoqueSabor,
		this.idEstoqueTamanho,
		this.idEstoqueCor,
		this.codigo,
		this.quantidade,
		this.produtoModel,
		this.estoqueCorModel,
		this.estoqueTamanhoModel,
		this.estoqueSaborModel,
		this.estoqueMarcaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'quantidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Quantidade',
	];

	EstoqueGradeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProduto = jsonData['idProduto'];
		idEstoqueMarca = jsonData['idEstoqueMarca'];
		idEstoqueSabor = jsonData['idEstoqueSabor'];
		idEstoqueTamanho = jsonData['idEstoqueTamanho'];
		idEstoqueCor = jsonData['idEstoqueCor'];
		codigo = jsonData['codigo'];
		quantidade = jsonData['quantidade']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
		estoqueCorModel = jsonData['estoqueCorModel'] == null ? EstoqueCorModel() : EstoqueCorModel.fromJson(jsonData['estoqueCorModel']);
		estoqueTamanhoModel = jsonData['estoqueTamanhoModel'] == null ? EstoqueTamanhoModel() : EstoqueTamanhoModel.fromJson(jsonData['estoqueTamanhoModel']);
		estoqueSaborModel = jsonData['estoqueSaborModel'] == null ? EstoqueSaborModel() : EstoqueSaborModel.fromJson(jsonData['estoqueSaborModel']);
		estoqueMarcaModel = jsonData['estoqueMarcaModel'] == null ? EstoqueMarcaModel() : EstoqueMarcaModel.fromJson(jsonData['estoqueMarcaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['idEstoqueMarca'] = idEstoqueMarca != 0 ? idEstoqueMarca : null;
		jsonData['idEstoqueSabor'] = idEstoqueSabor != 0 ? idEstoqueSabor : null;
		jsonData['idEstoqueTamanho'] = idEstoqueTamanho != 0 ? idEstoqueTamanho : null;
		jsonData['idEstoqueCor'] = idEstoqueCor != 0 ? idEstoqueCor : null;
		jsonData['codigo'] = codigo;
		jsonData['quantidade'] = quantidade;
		jsonData['produtoModel'] = produtoModel?.toJson;
		jsonData['estoqueCorModel'] = estoqueCorModel?.toJson;
		jsonData['estoqueTamanhoModel'] = estoqueTamanhoModel?.toJson;
		jsonData['estoqueSaborModel'] = estoqueSaborModel?.toJson;
		jsonData['estoqueMarcaModel'] = estoqueMarcaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		idEstoqueMarca = plutoRow.cells['idEstoqueMarca']?.value;
		idEstoqueSabor = plutoRow.cells['idEstoqueSabor']?.value;
		idEstoqueTamanho = plutoRow.cells['idEstoqueTamanho']?.value;
		idEstoqueCor = plutoRow.cells['idEstoqueCor']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
		estoqueCorModel = EstoqueCorModel();
		estoqueCorModel?.nome = plutoRow.cells['estoqueCorModel']?.value;
		estoqueTamanhoModel = EstoqueTamanhoModel();
		estoqueTamanhoModel?.nome = plutoRow.cells['estoqueTamanhoModel']?.value;
		estoqueSaborModel = EstoqueSaborModel();
		estoqueSaborModel?.nome = plutoRow.cells['estoqueSaborModel']?.value;
		estoqueMarcaModel = EstoqueMarcaModel();
		estoqueMarcaModel?.nome = plutoRow.cells['estoqueMarcaModel']?.value;
	}	

	EstoqueGradeModel clone() {
		return EstoqueGradeModel(
			id: id,
			idProduto: idProduto,
			idEstoqueMarca: idEstoqueMarca,
			idEstoqueSabor: idEstoqueSabor,
			idEstoqueTamanho: idEstoqueTamanho,
			idEstoqueCor: idEstoqueCor,
			codigo: codigo,
			quantidade: quantidade,
		);			
	}

	
}