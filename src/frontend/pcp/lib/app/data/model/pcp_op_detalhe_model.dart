import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:pcp/app/data/model/model_imports.dart';

class PcpOpDetalheModel {
	int? id;
	int? idPcpOpCabecalho;
	int? idProduto;
	double? quantidadeProduzir;
	double? quantidadeProduzida;
	double? quantidadeEntregue;
	double? custoPrevisto;
	double? custoRealizado;
	ProdutoModel? produtoModel;

	PcpOpDetalheModel({
		this.id,
		this.idPcpOpCabecalho,
		this.idProduto,
		this.quantidadeProduzir,
		this.quantidadeProduzida,
		this.quantidadeEntregue,
		this.custoPrevisto,
		this.custoRealizado,
		this.produtoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade_produzir',
		'quantidade_produzida',
		'quantidade_entregue',
		'custo_previsto',
		'custo_realizado',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade Produzir',
		'Quantidade Produzida',
		'Quantidade Entregue',
		'Custo Previsto',
		'Custo Realizado',
	];

	PcpOpDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPcpOpCabecalho = jsonData['idPcpOpCabecalho'];
		idProduto = jsonData['idProduto'];
		quantidadeProduzir = jsonData['quantidadeProduzir']?.toDouble();
		quantidadeProduzida = jsonData['quantidadeProduzida']?.toDouble();
		quantidadeEntregue = jsonData['quantidadeEntregue']?.toDouble();
		custoPrevisto = jsonData['custoPrevisto']?.toDouble();
		custoRealizado = jsonData['custoRealizado']?.toDouble();
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPcpOpCabecalho'] = idPcpOpCabecalho != 0 ? idPcpOpCabecalho : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['quantidadeProduzir'] = quantidadeProduzir;
		jsonData['quantidadeProduzida'] = quantidadeProduzida;
		jsonData['quantidadeEntregue'] = quantidadeEntregue;
		jsonData['custoPrevisto'] = custoPrevisto;
		jsonData['custoRealizado'] = custoRealizado;
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPcpOpCabecalho = plutoRow.cells['idPcpOpCabecalho']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidadeProduzir = plutoRow.cells['quantidadeProduzir']?.value?.toDouble();
		quantidadeProduzida = plutoRow.cells['quantidadeProduzida']?.value?.toDouble();
		quantidadeEntregue = plutoRow.cells['quantidadeEntregue']?.value?.toDouble();
		custoPrevisto = plutoRow.cells['custoPrevisto']?.value?.toDouble();
		custoRealizado = plutoRow.cells['custoRealizado']?.value?.toDouble();
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	PcpOpDetalheModel clone() {
		return PcpOpDetalheModel(
			id: id,
			idPcpOpCabecalho: idPcpOpCabecalho,
			idProduto: idProduto,
			quantidadeProduzir: quantidadeProduzir,
			quantidadeProduzida: quantidadeProduzida,
			quantidadeEntregue: quantidadeEntregue,
			custoPrevisto: custoPrevisto,
			custoRealizado: custoRealizado,
		);			
	}

	
}