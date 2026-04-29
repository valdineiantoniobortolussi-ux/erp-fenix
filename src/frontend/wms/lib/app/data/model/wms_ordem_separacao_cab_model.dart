import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:wms/app/data/domain/domain_imports.dart';

class WmsOrdemSeparacaoCabModel {
	int? id;
	String? origem;
	DateTime? dataSolicitacao;
	DateTime? dataLimite;
	List<WmsOrdemSeparacaoDetModel>? wmsOrdemSeparacaoDetModelList;

	WmsOrdemSeparacaoCabModel({
		this.id,
		this.origem,
		this.dataSolicitacao,
		this.dataLimite,
		this.wmsOrdemSeparacaoDetModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'origem',
		'data_solicitacao',
		'data_limite',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Origem',
		'Data Solicitacao',
		'Data Limite',
	];

	WmsOrdemSeparacaoCabModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		origem = WmsOrdemSeparacaoCabDomain.getOrigem(jsonData['origem']);
		dataSolicitacao = jsonData['dataSolicitacao'] != null ? DateTime.tryParse(jsonData['dataSolicitacao']) : null;
		dataLimite = jsonData['dataLimite'] != null ? DateTime.tryParse(jsonData['dataLimite']) : null;
		wmsOrdemSeparacaoDetModelList = (jsonData['wmsOrdemSeparacaoDetModelList'] as Iterable?)?.map((m) => WmsOrdemSeparacaoDetModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['origem'] = WmsOrdemSeparacaoCabDomain.setOrigem(origem);
		jsonData['dataSolicitacao'] = dataSolicitacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataSolicitacao!) : null;
		jsonData['dataLimite'] = dataLimite != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataLimite!) : null;
		
		var wmsOrdemSeparacaoDetModelLocalList = []; 
		for (WmsOrdemSeparacaoDetModel object in wmsOrdemSeparacaoDetModelList ?? []) { 
			wmsOrdemSeparacaoDetModelLocalList.add(object.toJson); 
		}
		jsonData['wmsOrdemSeparacaoDetModelList'] = wmsOrdemSeparacaoDetModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		origem = plutoRow.cells['origem']?.value != '' ? plutoRow.cells['origem']?.value : 'Produção';
		dataSolicitacao = Util.stringToDate(plutoRow.cells['dataSolicitacao']?.value);
		dataLimite = Util.stringToDate(plutoRow.cells['dataLimite']?.value);
		wmsOrdemSeparacaoDetModelList = [];
	}	

	WmsOrdemSeparacaoCabModel clone() {
		return WmsOrdemSeparacaoCabModel(
			id: id,
			origem: origem,
			dataSolicitacao: dataSolicitacao,
			dataLimite: dataLimite,
			wmsOrdemSeparacaoDetModelList: wmsOrdemSeparacaoDetModelListClone(wmsOrdemSeparacaoDetModelList!),
		);			
	}

	wmsOrdemSeparacaoDetModelListClone(List<WmsOrdemSeparacaoDetModel> wmsOrdemSeparacaoDetModelList) { 
		List<WmsOrdemSeparacaoDetModel> resultList = [];
		for (var wmsOrdemSeparacaoDetModel in wmsOrdemSeparacaoDetModelList) {
			resultList.add(
				WmsOrdemSeparacaoDetModel(
					id: wmsOrdemSeparacaoDetModel.id,
					idWmsOrdemSeparacaoCab: wmsOrdemSeparacaoDetModel.idWmsOrdemSeparacaoCab,
					idProduto: wmsOrdemSeparacaoDetModel.idProduto,
					quantidade: wmsOrdemSeparacaoDetModel.quantidade,
				)
			);
		}
		return resultList;
	}

	
}