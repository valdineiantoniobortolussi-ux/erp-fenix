import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilHistoricoModel {
	int? id;
	String? descricao;
	String? pedeComplemento;
	String? historico;

	ContabilHistoricoModel({
		this.id,
		this.descricao,
		this.pedeComplemento,
		this.historico,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'pede_complemento',
		'historico',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Pede Complemento',
		'Historico',
	];

	ContabilHistoricoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		pedeComplemento = ContabilHistoricoDomain.getPedeComplemento(jsonData['pedeComplemento']);
		historico = jsonData['historico'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['pedeComplemento'] = ContabilHistoricoDomain.setPedeComplemento(pedeComplemento);
		jsonData['historico'] = historico;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		pedeComplemento = plutoRow.cells['pedeComplemento']?.value != '' ? plutoRow.cells['pedeComplemento']?.value : 'Sim';
		historico = plutoRow.cells['historico']?.value;
	}	

	ContabilHistoricoModel clone() {
		return ContabilHistoricoModel(
			id: id,
			descricao: descricao,
			pedeComplemento: pedeComplemento,
			historico: historico,
		);			
	}

	
}