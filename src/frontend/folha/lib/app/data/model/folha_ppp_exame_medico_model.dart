import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class FolhaPppExameMedicoModel {
	int? id;
	int? idFolhaPpp;
	DateTime? dataUltimo;
	String? tipo;
	String? exame;
	String? natureza;
	String? indicacaoResultados;

	FolhaPppExameMedicoModel({
		this.id,
		this.idFolhaPpp,
		this.dataUltimo,
		this.tipo,
		this.exame,
		this.natureza,
		this.indicacaoResultados,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_ultimo',
		'tipo',
		'exame',
		'natureza',
		'indicacao_resultados',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Ultimo',
		'Tipo',
		'Exame',
		'Natureza',
		'Indicacao Resultados',
	];

	FolhaPppExameMedicoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFolhaPpp = jsonData['idFolhaPpp'];
		dataUltimo = jsonData['dataUltimo'] != null ? DateTime.tryParse(jsonData['dataUltimo']) : null;
		tipo = FolhaPppExameMedicoDomain.getTipo(jsonData['tipo']);
		exame = FolhaPppExameMedicoDomain.getExame(jsonData['exame']);
		natureza = jsonData['natureza'];
		indicacaoResultados = jsonData['indicacaoResultados'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFolhaPpp'] = idFolhaPpp != 0 ? idFolhaPpp : null;
		jsonData['dataUltimo'] = dataUltimo != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataUltimo!) : null;
		jsonData['tipo'] = FolhaPppExameMedicoDomain.setTipo(tipo);
		jsonData['exame'] = FolhaPppExameMedicoDomain.setExame(exame);
		jsonData['natureza'] = natureza;
		jsonData['indicacaoResultados'] = indicacaoResultados;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFolhaPpp = plutoRow.cells['idFolhaPpp']?.value;
		dataUltimo = Util.stringToDate(plutoRow.cells['dataUltimo']?.value);
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Admissional';
		exame = plutoRow.cells['exame']?.value != '' ? plutoRow.cells['exame']?.value : 'Referencial';
		natureza = plutoRow.cells['natureza']?.value;
		indicacaoResultados = plutoRow.cells['indicacaoResultados']?.value;
	}	

	FolhaPppExameMedicoModel clone() {
		return FolhaPppExameMedicoModel(
			id: id,
			idFolhaPpp: idFolhaPpp,
			dataUltimo: dataUltimo,
			tipo: tipo,
			exame: exame,
			natureza: natureza,
			indicacaoResultados: indicacaoResultados,
		);			
	}

	
}