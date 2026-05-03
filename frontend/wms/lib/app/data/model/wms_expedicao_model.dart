import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:wms/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class WmsExpedicaoModel {
	int? id;
	int? idWmsOrdemSeparacaoDet;
	int? idWmsArmazenamento;
	int? quantidade;
	DateTime? dataSaida;
	WmsOrdemSeparacaoDetModel? wmsOrdemSeparacaoDetModel;
	WmsArmazenamentoModel? wmsArmazenamentoModel;

	WmsExpedicaoModel({
		this.id,
		this.idWmsOrdemSeparacaoDet,
		this.idWmsArmazenamento,
		this.quantidade,
		this.dataSaida,
		this.wmsOrdemSeparacaoDetModel,
		this.wmsArmazenamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade',
		'data_saida',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
		'Data Saida',
	];

	WmsExpedicaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idWmsOrdemSeparacaoDet = jsonData['idWmsOrdemSeparacaoDet'];
		idWmsArmazenamento = jsonData['idWmsArmazenamento'];
		quantidade = jsonData['quantidade'];
		dataSaida = jsonData['dataSaida'] != null ? DateTime.tryParse(jsonData['dataSaida']) : null;
		wmsOrdemSeparacaoDetModel = jsonData['wmsOrdemSeparacaoDetModel'] == null ? WmsOrdemSeparacaoDetModel() : WmsOrdemSeparacaoDetModel.fromJson(jsonData['wmsOrdemSeparacaoDetModel']);
		wmsArmazenamentoModel = jsonData['wmsArmazenamentoModel'] == null ? WmsArmazenamentoModel() : WmsArmazenamentoModel.fromJson(jsonData['wmsArmazenamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idWmsOrdemSeparacaoDet'] = idWmsOrdemSeparacaoDet != 0 ? idWmsOrdemSeparacaoDet : null;
		jsonData['idWmsArmazenamento'] = idWmsArmazenamento != 0 ? idWmsArmazenamento : null;
		jsonData['quantidade'] = quantidade;
		jsonData['dataSaida'] = dataSaida != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataSaida!) : null;
		jsonData['wmsOrdemSeparacaoDetModel'] = wmsOrdemSeparacaoDetModel?.toJson;
		jsonData['wmsArmazenamentoModel'] = wmsArmazenamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idWmsOrdemSeparacaoDet = plutoRow.cells['idWmsOrdemSeparacaoDet']?.value;
		idWmsArmazenamento = plutoRow.cells['idWmsArmazenamento']?.value;
		quantidade = plutoRow.cells['quantidade']?.value;
		dataSaida = Util.stringToDate(plutoRow.cells['dataSaida']?.value);
		wmsOrdemSeparacaoDetModel = WmsOrdemSeparacaoDetModel();
		wmsOrdemSeparacaoDetModel?.id = plutoRow.cells['wmsOrdemSeparacaoDetModel']?.value;
		wmsArmazenamentoModel = WmsArmazenamentoModel();
		wmsArmazenamentoModel?.id = plutoRow.cells['wmsArmazenamentoModel']?.value;
	}	

	WmsExpedicaoModel clone() {
		return WmsExpedicaoModel(
			id: id,
			idWmsOrdemSeparacaoDet: idWmsOrdemSeparacaoDet,
			idWmsArmazenamento: idWmsArmazenamento,
			quantidade: quantidade,
			dataSaida: dataSaida,
		);			
	}

	
}