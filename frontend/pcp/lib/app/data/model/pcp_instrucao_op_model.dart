import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:pcp/app/data/model/model_imports.dart';

class PcpInstrucaoOpModel {
	int? id;
	int? idPcpOpCabecalho;
	int? idPcpInstrucao;
	PcpInstrucaoModel? pcpInstrucaoModel;

	PcpInstrucaoOpModel({
		this.id,
		this.idPcpOpCabecalho,
		this.idPcpInstrucao,
		this.pcpInstrucaoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
	];

	PcpInstrucaoOpModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPcpOpCabecalho = jsonData['idPcpOpCabecalho'];
		idPcpInstrucao = jsonData['idPcpInstrucao'];
		pcpInstrucaoModel = jsonData['pcpInstrucaoModel'] == null ? PcpInstrucaoModel() : PcpInstrucaoModel.fromJson(jsonData['pcpInstrucaoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPcpOpCabecalho'] = idPcpOpCabecalho != 0 ? idPcpOpCabecalho : null;
		jsonData['idPcpInstrucao'] = idPcpInstrucao != 0 ? idPcpInstrucao : null;
		jsonData['pcpInstrucaoModel'] = pcpInstrucaoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPcpOpCabecalho = plutoRow.cells['idPcpOpCabecalho']?.value;
		idPcpInstrucao = plutoRow.cells['idPcpInstrucao']?.value;
		pcpInstrucaoModel = PcpInstrucaoModel();
		pcpInstrucaoModel?.descricao = plutoRow.cells['pcpInstrucaoModel']?.value;
	}	

	PcpInstrucaoOpModel clone() {
		return PcpInstrucaoOpModel(
			id: id,
			idPcpOpCabecalho: idPcpOpCabecalho,
			idPcpInstrucao: idPcpInstrucao,
		);			
	}

	
}