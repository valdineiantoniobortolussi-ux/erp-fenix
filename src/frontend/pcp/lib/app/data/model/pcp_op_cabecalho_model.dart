import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:pcp/app/infra/infra_imports.dart';
import 'package:pcp/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class PcpOpCabecalhoModel {
	int? id;
	DateTime? dataInicio;
	DateTime? dataPrevisaoEntrega;
	DateTime? dataTermino;
	double? custoTotalPrevisto;
	double? custoTotalRealizado;
	double? porcentoVenda;
	double? porcentoEstoque;
	List<PcpOpDetalheModel>? pcpOpDetalheModelList;
	List<PcpInstrucaoOpModel>? pcpInstrucaoOpModelList;

	PcpOpCabecalhoModel({
		this.id,
		this.dataInicio,
		this.dataPrevisaoEntrega,
		this.dataTermino,
		this.custoTotalPrevisto,
		this.custoTotalRealizado,
		this.porcentoVenda,
		this.porcentoEstoque,
		this.pcpOpDetalheModelList,
		this.pcpInstrucaoOpModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_previsao_entrega',
		'data_termino',
		'custo_total_previsto',
		'custo_total_realizado',
		'porcento_venda',
		'porcento_estoque',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Previsao Entrega',
		'Data Termino',
		'Custo Total Previsto',
		'Custo Total Realizado',
		'Porcento Venda',
		'Porcento Estoque',
	];

	PcpOpCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataPrevisaoEntrega = jsonData['dataPrevisaoEntrega'] != null ? DateTime.tryParse(jsonData['dataPrevisaoEntrega']) : null;
		dataTermino = jsonData['dataTermino'] != null ? DateTime.tryParse(jsonData['dataTermino']) : null;
		custoTotalPrevisto = jsonData['custoTotalPrevisto']?.toDouble();
		custoTotalRealizado = jsonData['custoTotalRealizado']?.toDouble();
		porcentoVenda = jsonData['porcentoVenda']?.toDouble();
		porcentoEstoque = jsonData['porcentoEstoque']?.toDouble();
		pcpOpDetalheModelList = (jsonData['pcpOpDetalheModelList'] as Iterable?)?.map((m) => PcpOpDetalheModel.fromJson(m)).toList() ?? [];
		pcpInstrucaoOpModelList = (jsonData['pcpInstrucaoOpModelList'] as Iterable?)?.map((m) => PcpInstrucaoOpModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataPrevisaoEntrega'] = dataPrevisaoEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevisaoEntrega!) : null;
		jsonData['dataTermino'] = dataTermino != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataTermino!) : null;
		jsonData['custoTotalPrevisto'] = custoTotalPrevisto;
		jsonData['custoTotalRealizado'] = custoTotalRealizado;
		jsonData['porcentoVenda'] = porcentoVenda;
		jsonData['porcentoEstoque'] = porcentoEstoque;
		
		var pcpOpDetalheModelLocalList = []; 
		for (PcpOpDetalheModel object in pcpOpDetalheModelList ?? []) { 
			pcpOpDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['pcpOpDetalheModelList'] = pcpOpDetalheModelLocalList;
		
		var pcpInstrucaoOpModelLocalList = []; 
		for (PcpInstrucaoOpModel object in pcpInstrucaoOpModelList ?? []) { 
			pcpInstrucaoOpModelLocalList.add(object.toJson); 
		}
		jsonData['pcpInstrucaoOpModelList'] = pcpInstrucaoOpModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataPrevisaoEntrega = Util.stringToDate(plutoRow.cells['dataPrevisaoEntrega']?.value);
		dataTermino = Util.stringToDate(plutoRow.cells['dataTermino']?.value);
		custoTotalPrevisto = plutoRow.cells['custoTotalPrevisto']?.value?.toDouble();
		custoTotalRealizado = plutoRow.cells['custoTotalRealizado']?.value?.toDouble();
		porcentoVenda = plutoRow.cells['porcentoVenda']?.value?.toDouble();
		porcentoEstoque = plutoRow.cells['porcentoEstoque']?.value?.toDouble();
		pcpOpDetalheModelList = [];
		pcpInstrucaoOpModelList = [];
	}	

	PcpOpCabecalhoModel clone() {
		return PcpOpCabecalhoModel(
			id: id,
			dataInicio: dataInicio,
			dataPrevisaoEntrega: dataPrevisaoEntrega,
			dataTermino: dataTermino,
			custoTotalPrevisto: custoTotalPrevisto,
			custoTotalRealizado: custoTotalRealizado,
			porcentoVenda: porcentoVenda,
			porcentoEstoque: porcentoEstoque,
			pcpOpDetalheModelList: pcpOpDetalheModelListClone(pcpOpDetalheModelList!),
			pcpInstrucaoOpModelList: pcpInstrucaoOpModelListClone(pcpInstrucaoOpModelList!),
		);			
	}

	pcpOpDetalheModelListClone(List<PcpOpDetalheModel> pcpOpDetalheModelList) { 
		List<PcpOpDetalheModel> resultList = [];
		for (var pcpOpDetalheModel in pcpOpDetalheModelList) {
			resultList.add(
				PcpOpDetalheModel(
					id: pcpOpDetalheModel.id,
					idPcpOpCabecalho: pcpOpDetalheModel.idPcpOpCabecalho,
					idProduto: pcpOpDetalheModel.idProduto,
					quantidadeProduzir: pcpOpDetalheModel.quantidadeProduzir,
					quantidadeProduzida: pcpOpDetalheModel.quantidadeProduzida,
					quantidadeEntregue: pcpOpDetalheModel.quantidadeEntregue,
					custoPrevisto: pcpOpDetalheModel.custoPrevisto,
					custoRealizado: pcpOpDetalheModel.custoRealizado,
				)
			);
		}
		return resultList;
	}

	pcpInstrucaoOpModelListClone(List<PcpInstrucaoOpModel> pcpInstrucaoOpModelList) { 
		List<PcpInstrucaoOpModel> resultList = [];
		for (var pcpInstrucaoOpModel in pcpInstrucaoOpModelList) {
			resultList.add(
				PcpInstrucaoOpModel(
					id: pcpInstrucaoOpModel.id,
					idPcpInstrucao: pcpInstrucaoOpModel.idPcpInstrucao,
					idPcpOpCabecalho: pcpInstrucaoOpModel.idPcpOpCabecalho,
				)
			);
		}
		return resultList;
	}

	
}