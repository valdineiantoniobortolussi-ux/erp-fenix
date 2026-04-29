import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:estoque/app/data/model/model_imports.dart';

class RequisicaoInternaDetalheModel {
	int? id;
	int? idRequisicaoInternaCabecalho;
	int? idProduto;
	double? quantidade;
	ProdutoModel? produtoModel;

	RequisicaoInternaDetalheModel({
		this.id,
		this.idRequisicaoInternaCabecalho,
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

	RequisicaoInternaDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idRequisicaoInternaCabecalho = jsonData['idRequisicaoInternaCabecalho'];
		idProduto = jsonData['idProduto'];
		quantidade = jsonData['quantidade']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idRequisicaoInternaCabecalho'] = idRequisicaoInternaCabecalho != 0 ? idRequisicaoInternaCabecalho : null;
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
		idRequisicaoInternaCabecalho = plutoRow.cells['idRequisicaoInternaCabecalho']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	RequisicaoInternaDetalheModel clone() {
		return RequisicaoInternaDetalheModel(
			id: id,
			idRequisicaoInternaCabecalho: idRequisicaoInternaCabecalho,
			idProduto: idProduto,
			quantidade: quantidade,
		);			
	}

	
}