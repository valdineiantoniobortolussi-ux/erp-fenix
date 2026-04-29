import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/data/model/model_imports.dart';

class CompraFornecedorCotacaoModel {
	int? id;
	int? idCompraCotacao;
	int? idFornecedor;
	String? codigo;
	String? prazoEntrega;
	String? vendaCondicoesPagamento;
	double? valorSubtotal;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	ViewPessoaFornecedorModel? viewPessoaFornecedorModel;

	CompraFornecedorCotacaoModel({
		this.id,
		this.idCompraCotacao,
		this.idFornecedor,
		this.codigo,
		this.prazoEntrega,
		this.vendaCondicoesPagamento,
		this.valorSubtotal,
		this.taxaDesconto,
		this.valorDesconto,
		this.valorTotal,
		this.viewPessoaFornecedorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'prazo_entrega',
		'venda_condicoes_pagamento',
		'valor_subtotal',
		'taxa_desconto',
		'valor_desconto',
		'valor_total',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Prazo Entrega',
		'Venda Condicoes Pagamento',
		'Valor Subtotal',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
	];

	CompraFornecedorCotacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCompraCotacao = jsonData['idCompraCotacao'];
		idFornecedor = jsonData['idFornecedor'];
		codigo = jsonData['codigo'];
		prazoEntrega = jsonData['prazoEntrega'];
		vendaCondicoesPagamento = jsonData['vendaCondicoesPagamento'];
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		viewPessoaFornecedorModel = jsonData['viewPessoaFornecedorModel'] == null ? ViewPessoaFornecedorModel() : ViewPessoaFornecedorModel.fromJson(jsonData['viewPessoaFornecedorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCompraCotacao'] = idCompraCotacao != 0 ? idCompraCotacao : null;
		jsonData['idFornecedor'] = idFornecedor != 0 ? idFornecedor : null;
		jsonData['codigo'] = codigo;
		jsonData['prazoEntrega'] = prazoEntrega;
		jsonData['vendaCondicoesPagamento'] = vendaCondicoesPagamento;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorTotal'] = valorTotal;
		jsonData['viewPessoaFornecedorModel'] = viewPessoaFornecedorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCompraCotacao = plutoRow.cells['idCompraCotacao']?.value;
		idFornecedor = plutoRow.cells['idFornecedor']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		prazoEntrega = plutoRow.cells['prazoEntrega']?.value;
		vendaCondicoesPagamento = plutoRow.cells['vendaCondicoesPagamento']?.value;
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		viewPessoaFornecedorModel = ViewPessoaFornecedorModel();
		viewPessoaFornecedorModel?.nome = plutoRow.cells['viewPessoaFornecedorModel']?.value;
	}	

	CompraFornecedorCotacaoModel clone() {
		return CompraFornecedorCotacaoModel(
			id: id,
			idCompraCotacao: idCompraCotacao,
			idFornecedor: idFornecedor,
			codigo: codigo,
			prazoEntrega: prazoEntrega,
			vendaCondicoesPagamento: vendaCondicoesPagamento,
			valorSubtotal: valorSubtotal,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
		);			
	}

	
}