import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/data/domain/domain_imports.dart';

class OsProdutoServicoModel {
	int? id;
	int? idOsAbertura;
	int? idProduto;
	String? tipo;
	String? complemento;
	double? quantidade;
	double? valorUnitario;
	double? valorSubtotal;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	ProdutoModel? produtoModel;

	OsProdutoServicoModel({
		this.id,
		this.idOsAbertura,
		this.idProduto,
		this.tipo,
		this.complemento,
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
		'tipo',
		'complemento',
		'quantidade',
		'valor_unitario',
		'valor_subtotal',
		'taxa_desconto',
		'valor_desconto',
		'valor_total',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo',
		'Complemento',
		'Quantidade',
		'Valor Unitario',
		'Valor Subtotal',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
	];

	OsProdutoServicoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOsAbertura = jsonData['idOsAbertura'];
		idProduto = jsonData['idProduto'];
		tipo = OsProdutoServicoDomain.getTipo(jsonData['tipo']);
		complemento = jsonData['complemento'];
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
		jsonData['idOsAbertura'] = idOsAbertura != 0 ? idOsAbertura : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['tipo'] = OsProdutoServicoDomain.setTipo(tipo);
		jsonData['complemento'] = complemento;
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
		idOsAbertura = plutoRow.cells['idOsAbertura']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Produto';
		complemento = plutoRow.cells['complemento']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
		valorUnitario = plutoRow.cells['valorUnitario']?.value?.toDouble();
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	OsProdutoServicoModel clone() {
		return OsProdutoServicoModel(
			id: id,
			idOsAbertura: idOsAbertura,
			idProduto: idProduto,
			tipo: tipo,
			complemento: complemento,
			quantidade: quantidade,
			valorUnitario: valorUnitario,
			valorSubtotal: valorSubtotal,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
		);			
	}

	
}