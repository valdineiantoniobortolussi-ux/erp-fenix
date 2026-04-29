import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:orcamentos/app/data/domain/domain_imports.dart';

class OrcamentoPeriodoModel {
	int? id;
	String? periodo;
	String? nome;

	OrcamentoPeriodoModel({
		this.id,
		this.periodo,
		this.nome,
	});

	static List<String> dbColumns = <String>[
		'id',
		'periodo',
		'nome',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Periodo',
		'Nome',
	];

	OrcamentoPeriodoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		periodo = OrcamentoPeriodoDomain.getPeriodo(jsonData['periodo']);
		nome = jsonData['nome'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['periodo'] = OrcamentoPeriodoDomain.setPeriodo(periodo);
		jsonData['nome'] = nome;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		periodo = plutoRow.cells['periodo']?.value != '' ? plutoRow.cells['periodo']?.value : '01=Diário';
		nome = plutoRow.cells['nome']?.value;
	}	

	OrcamentoPeriodoModel clone() {
		return OrcamentoPeriodoModel(
			id: id,
			periodo: periodo,
			nome: nome,
		);			
	}

	
}