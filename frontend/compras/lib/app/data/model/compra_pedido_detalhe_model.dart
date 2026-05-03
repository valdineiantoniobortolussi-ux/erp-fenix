import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/data/model/model_imports.dart';

class CompraPedidoDetalheModel {
	int? id;
	int? idCompraPedido;
	int? idProduto;
	double? quantidade;
	double? valorUnitario;
	double? valorSubtotal;
	double? taxaDesconto;
	double? valorDesconto;
	double? valorTotal;
	String? cst;
	String? csosn;
	int? cfop;
	double? baseCalculoIcms;
	double? valorIcms;
	double? valorIpi;
	double? aliquotaIcms;
	double? aliquotaIpi;
	ProdutoModel? produtoModel;

	CompraPedidoDetalheModel({
		this.id,
		this.idCompraPedido,
		this.idProduto,
		this.quantidade,
		this.valorUnitario,
		this.valorSubtotal,
		this.taxaDesconto,
		this.valorDesconto,
		this.valorTotal,
		this.cst,
		this.csosn,
		this.cfop,
		this.baseCalculoIcms,
		this.valorIcms,
		this.valorIpi,
		this.aliquotaIcms,
		this.aliquotaIpi,
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
		'cst',
		'csosn',
		'cfop',
		'base_calculo_icms',
		'valor_icms',
		'valor_ipi',
		'aliquota_icms',
		'aliquota_ipi',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
		'Valor Unitario',
		'Valor Subtotal',
		'Taxa Desconto',
		'Valor Desconto',
		'Valor Total',
		'Cst',
		'Csosn',
		'Cfop',
		'Base Calculo Icms',
		'Valor Icms',
		'Valor Ipi',
		'Aliquota Icms',
		'Aliquota Ipi',
	];

	CompraPedidoDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCompraPedido = jsonData['idCompraPedido'];
		idProduto = jsonData['idProduto'];
		quantidade = jsonData['quantidade']?.toDouble();
		valorUnitario = jsonData['valorUnitario']?.toDouble();
		valorSubtotal = jsonData['valorSubtotal']?.toDouble();
		taxaDesconto = jsonData['taxaDesconto']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorTotal = jsonData['valorTotal']?.toDouble();
		cst = jsonData['cst'];
		csosn = jsonData['csosn'];
		cfop = jsonData['cfop'];
		baseCalculoIcms = jsonData['baseCalculoIcms']?.toDouble();
		valorIcms = jsonData['valorIcms']?.toDouble();
		valorIpi = jsonData['valorIpi']?.toDouble();
		aliquotaIcms = jsonData['aliquotaIcms']?.toDouble();
		aliquotaIpi = jsonData['aliquotaIpi']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCompraPedido'] = idCompraPedido != 0 ? idCompraPedido : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['quantidade'] = quantidade;
		jsonData['valorUnitario'] = valorUnitario;
		jsonData['valorSubtotal'] = valorSubtotal;
		jsonData['taxaDesconto'] = taxaDesconto;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorTotal'] = valorTotal;
		jsonData['cst'] = cst;
		jsonData['csosn'] = csosn;
		jsonData['cfop'] = cfop;
		jsonData['baseCalculoIcms'] = baseCalculoIcms;
		jsonData['valorIcms'] = valorIcms;
		jsonData['valorIpi'] = valorIpi;
		jsonData['aliquotaIcms'] = aliquotaIcms;
		jsonData['aliquotaIpi'] = aliquotaIpi;
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCompraPedido = plutoRow.cells['idCompraPedido']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
		valorUnitario = plutoRow.cells['valorUnitario']?.value?.toDouble();
		valorSubtotal = plutoRow.cells['valorSubtotal']?.value?.toDouble();
		taxaDesconto = plutoRow.cells['taxaDesconto']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		cst = plutoRow.cells['cst']?.value;
		csosn = plutoRow.cells['csosn']?.value;
		cfop = plutoRow.cells['cfop']?.value;
		baseCalculoIcms = plutoRow.cells['baseCalculoIcms']?.value?.toDouble();
		valorIcms = plutoRow.cells['valorIcms']?.value?.toDouble();
		valorIpi = plutoRow.cells['valorIpi']?.value?.toDouble();
		aliquotaIcms = plutoRow.cells['aliquotaIcms']?.value?.toDouble();
		aliquotaIpi = plutoRow.cells['aliquotaIpi']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	CompraPedidoDetalheModel clone() {
		return CompraPedidoDetalheModel(
			id: id,
			idCompraPedido: idCompraPedido,
			idProduto: idProduto,
			quantidade: quantidade,
			valorUnitario: valorUnitario,
			valorSubtotal: valorSubtotal,
			taxaDesconto: taxaDesconto,
			valorDesconto: valorDesconto,
			valorTotal: valorTotal,
			cst: cst,
			csosn: csosn,
			cfop: cfop,
			baseCalculoIcms: baseCalculoIcms,
			valorIcms: valorIcms,
			valorIpi: valorIpi,
			aliquotaIcms: aliquotaIcms,
			aliquotaIpi: aliquotaIpi,
		);			
	}

	
}