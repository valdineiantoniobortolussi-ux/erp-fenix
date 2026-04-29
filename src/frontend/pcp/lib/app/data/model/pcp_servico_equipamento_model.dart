import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:pcp/app/data/model/model_imports.dart';

class PcpServicoEquipamentoModel {
	int? id;
	int? idPcpServico;
	int? idPatrimBem;
	PatrimBemModel? patrimBemModel;

	PcpServicoEquipamentoModel({
		this.id,
		this.idPcpServico,
		this.idPatrimBem,
		this.patrimBemModel,
	});

	static List<String> dbColumns = <String>[
		'id',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
	];

	PcpServicoEquipamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPcpServico = jsonData['idPcpServico'];
		idPatrimBem = jsonData['idPatrimBem'];
		patrimBemModel = jsonData['patrimBemModel'] == null ? PatrimBemModel() : PatrimBemModel.fromJson(jsonData['patrimBemModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPcpServico'] = idPcpServico != 0 ? idPcpServico : null;
		jsonData['idPatrimBem'] = idPatrimBem != 0 ? idPatrimBem : null;
		jsonData['patrimBemModel'] = patrimBemModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPcpServico = plutoRow.cells['idPcpServico']?.value;
		idPatrimBem = plutoRow.cells['idPatrimBem']?.value;
		patrimBemModel = PatrimBemModel();
		patrimBemModel?.nome = plutoRow.cells['patrimBemModel']?.value;
	}	

	PcpServicoEquipamentoModel clone() {
		return PcpServicoEquipamentoModel(
			id: id,
			idPcpServico: idPcpServico,
			idPatrimBem: idPatrimBem,
		);			
	}

	
}