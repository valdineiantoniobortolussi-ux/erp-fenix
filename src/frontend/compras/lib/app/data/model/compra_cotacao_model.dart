import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/infra/infra_imports.dart';
import 'package:compras/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class CompraCotacaoModel {
	int? id;
	int? idCompraRequisicao;
	DateTime? dataCotacao;
	String? descricao;
	List<CompraFornecedorCotacaoModel>? compraFornecedorCotacaoModelList;
	CompraRequisicaoModel? compraRequisicaoModel;
	List<CompraCotacaoDetalheModel>? compraCotacaoDetalheModelList;

	CompraCotacaoModel({
		this.id,
		this.idCompraRequisicao,
		this.dataCotacao,
		this.descricao,
		this.compraFornecedorCotacaoModelList,
		this.compraRequisicaoModel,
		this.compraCotacaoDetalheModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_cotacao',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Cotacao',
		'Descricao',
	];

	CompraCotacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCompraRequisicao = jsonData['idCompraRequisicao'];
		dataCotacao = jsonData['dataCotacao'] != null ? DateTime.tryParse(jsonData['dataCotacao']) : null;
		descricao = jsonData['descricao'];
		compraFornecedorCotacaoModelList = (jsonData['compraFornecedorCotacaoModelList'] as Iterable?)?.map((m) => CompraFornecedorCotacaoModel.fromJson(m)).toList() ?? [];
		compraRequisicaoModel = jsonData['compraRequisicaoModel'] == null ? CompraRequisicaoModel() : CompraRequisicaoModel.fromJson(jsonData['compraRequisicaoModel']);
		compraCotacaoDetalheModelList = (jsonData['compraCotacaoDetalheModelList'] as Iterable?)?.map((m) => CompraCotacaoDetalheModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCompraRequisicao'] = idCompraRequisicao != 0 ? idCompraRequisicao : null;
		jsonData['dataCotacao'] = dataCotacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCotacao!) : null;
		jsonData['descricao'] = descricao;
		
		var compraFornecedorCotacaoModelLocalList = []; 
		for (CompraFornecedorCotacaoModel object in compraFornecedorCotacaoModelList ?? []) { 
			compraFornecedorCotacaoModelLocalList.add(object.toJson); 
		}
		jsonData['compraFornecedorCotacaoModelList'] = compraFornecedorCotacaoModelLocalList;
		jsonData['compraRequisicaoModel'] = compraRequisicaoModel?.toJson;
		
		var compraCotacaoDetalheModelLocalList = []; 
		for (CompraCotacaoDetalheModel object in compraCotacaoDetalheModelList ?? []) { 
			compraCotacaoDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['compraCotacaoDetalheModelList'] = compraCotacaoDetalheModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCompraRequisicao = plutoRow.cells['idCompraRequisicao']?.value;
		dataCotacao = Util.stringToDate(plutoRow.cells['dataCotacao']?.value);
		descricao = plutoRow.cells['descricao']?.value;
		compraFornecedorCotacaoModelList = [];
		compraRequisicaoModel = CompraRequisicaoModel();
		compraRequisicaoModel?.descricao = plutoRow.cells['compraRequisicaoModel']?.value;
		compraCotacaoDetalheModelList = [];
	}	

	CompraCotacaoModel clone() {
		return CompraCotacaoModel(
			id: id,
			idCompraRequisicao: idCompraRequisicao,
			dataCotacao: dataCotacao,
			descricao: descricao,
			compraFornecedorCotacaoModelList: compraFornecedorCotacaoModelListClone(compraFornecedorCotacaoModelList!),
			compraCotacaoDetalheModelList: compraCotacaoDetalheModelListClone(compraCotacaoDetalheModelList!),
		);			
	}

	compraFornecedorCotacaoModelListClone(List<CompraFornecedorCotacaoModel> compraFornecedorCotacaoModelList) { 
		List<CompraFornecedorCotacaoModel> resultList = [];
		for (var compraFornecedorCotacaoModel in compraFornecedorCotacaoModelList) {
			resultList.add(
				CompraFornecedorCotacaoModel(
					id: compraFornecedorCotacaoModel.id,
					idCompraCotacao: compraFornecedorCotacaoModel.idCompraCotacao,
					idFornecedor: compraFornecedorCotacaoModel.idFornecedor,
					codigo: compraFornecedorCotacaoModel.codigo,
					prazoEntrega: compraFornecedorCotacaoModel.prazoEntrega,
					vendaCondicoesPagamento: compraFornecedorCotacaoModel.vendaCondicoesPagamento,
					valorSubtotal: compraFornecedorCotacaoModel.valorSubtotal,
					taxaDesconto: compraFornecedorCotacaoModel.taxaDesconto,
					valorDesconto: compraFornecedorCotacaoModel.valorDesconto,
					valorTotal: compraFornecedorCotacaoModel.valorTotal,
				)
			);
		}
		return resultList;
	}

	compraCotacaoDetalheModelListClone(List<CompraCotacaoDetalheModel> compraCotacaoDetalheModelList) { 
		List<CompraCotacaoDetalheModel> resultList = [];
		for (var compraCotacaoDetalheModel in compraCotacaoDetalheModelList) {
			resultList.add(
				CompraCotacaoDetalheModel(
					id: compraCotacaoDetalheModel.id,
					idProduto: compraCotacaoDetalheModel.idProduto,
					idCompraCotacao: compraCotacaoDetalheModel.idCompraCotacao,
					quantidade: compraCotacaoDetalheModel.quantidade,
					valorUnitario: compraCotacaoDetalheModel.valorUnitario,
					valorSubtotal: compraCotacaoDetalheModel.valorSubtotal,
					taxaDesconto: compraCotacaoDetalheModel.taxaDesconto,
					valorDesconto: compraCotacaoDetalheModel.valorDesconto,
					valorTotal: compraCotacaoDetalheModel.valorTotal,
				)
			);
		}
		return resultList;
	}

	
}