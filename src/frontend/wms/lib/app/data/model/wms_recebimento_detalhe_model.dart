import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/data/model/model_imports.dart';
import 'package:wms/app/data/domain/domain_imports.dart';

class WmsRecebimentoDetalheModel {
	int? id;
	int? idWmsRecebimentoCabecalho;
	int? idProduto;
	int? quantidadeVolume;
	int? quantidadeItemPorVolume;
	int? quantidadeRecebida;
	String? destino;
	ProdutoModel? produtoModel;

	WmsRecebimentoDetalheModel({
		this.id,
		this.idWmsRecebimentoCabecalho,
		this.idProduto,
		this.quantidadeVolume,
		this.quantidadeItemPorVolume,
		this.quantidadeRecebida,
		this.destino,
		this.produtoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade_volume',
		'quantidade_item_por_volume',
		'quantidade_recebida',
		'destino',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade Volume',
		'Quantidade Item Por Volume',
		'Quantidade Recebida',
		'Destino',
	];

	WmsRecebimentoDetalheModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idWmsRecebimentoCabecalho = jsonData['idWmsRecebimentoCabecalho'];
		idProduto = jsonData['idProduto'];
		quantidadeVolume = jsonData['quantidadeVolume'];
		quantidadeItemPorVolume = jsonData['quantidadeItemPorVolume'];
		quantidadeRecebida = jsonData['quantidadeRecebida'];
		destino = WmsRecebimentoDetalheDomain.getDestino(jsonData['destino']);
		produtoModel = jsonData['produtoModel'] == null ? ProdutoModel() : ProdutoModel.fromJson(jsonData['produtoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idWmsRecebimentoCabecalho'] = idWmsRecebimentoCabecalho != 0 ? idWmsRecebimentoCabecalho : null;
		jsonData['idProduto'] = idProduto != 0 ? idProduto : null;
		jsonData['quantidadeVolume'] = quantidadeVolume;
		jsonData['quantidadeItemPorVolume'] = quantidadeItemPorVolume;
		jsonData['quantidadeRecebida'] = quantidadeRecebida;
		jsonData['destino'] = WmsRecebimentoDetalheDomain.setDestino(destino);
		jsonData['produtoModel'] = produtoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idWmsRecebimentoCabecalho = plutoRow.cells['idWmsRecebimentoCabecalho']?.value;
		idProduto = plutoRow.cells['idProduto']?.value;
		quantidadeVolume = plutoRow.cells['quantidadeVolume']?.value;
		quantidadeItemPorVolume = plutoRow.cells['quantidadeItemPorVolume']?.value;
		quantidadeRecebida = plutoRow.cells['quantidadeRecebida']?.value;
		destino = plutoRow.cells['destino']?.value != '' ? plutoRow.cells['destino']?.value : 'Armazenamento';
		produtoModel = ProdutoModel();
		produtoModel?.nome = plutoRow.cells['produtoModel']?.value;
	}	

	WmsRecebimentoDetalheModel clone() {
		return WmsRecebimentoDetalheModel(
			id: id,
			idWmsRecebimentoCabecalho: idWmsRecebimentoCabecalho,
			idProduto: idProduto,
			quantidadeVolume: quantidadeVolume,
			quantidadeItemPorVolume: quantidadeItemPorVolume,
			quantidadeRecebida: quantidadeRecebida,
			destino: destino,
		);			
	}

	
}