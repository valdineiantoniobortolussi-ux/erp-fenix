import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/data/model/model_imports.dart';

class VendaDetalheModel {
	int? id;
	int? idVendaCabecalho;
	int? idProduto;
	double? quantidade;
	double? valorUnitario;
	double? valorSubtotal;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	ProdutoModel? produtoModel;

	VendaDetalheModel({
		this.id,
		this.idVendaCabecalho,
		this.idProduto,
		this.quantidade,
		this.valorUnitario,
		this.valorSubtotal,
		this.taxaDesconto,
		this.valorDesconto,
		this.valorTotal,
		this.produtoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade',
		'valor_unitario',
		'valor_subtotal',
		'taxa_desconto',
		'valor_desconto',
		'valor_total',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
		'Valor Unitario',
		'Valor Subtotal',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
	];

	VendaDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idVendaCabecalho = jsonData['idVendaCabecalho'];
		idProduto = jsonData['idProduto'];
		quantidade = jsonData['quantidade']?.toDouble();
		valorUnitario = jsonData['valorUnitario']?.toDouble();
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idVendaCabecalho'] = idVendaCabecalho != 0 ? idVendaCabecalho : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['quantidade'] = quantidade;
		jsonData['valorUnitario'] = valorUnitario;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorTotal'] = valorTotal;
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idVendaCabecalho = plutoRow.cells['idVendaCabecalho']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
		valorUnitario = plutoRow.cells['valorUnitario']?.value?.toDouble();
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	VendaDetalheModel clone() {
		return VendaDetalheModel(
			id: id,
			idVendaCabecalho: idVendaCabecalho,
			idProduto: idProduto,
			quantidade: quantidade,
			valorUnitario: valorUnitario,
			valorSubtotal: valorSubtotal,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
		);			
	}

	
}