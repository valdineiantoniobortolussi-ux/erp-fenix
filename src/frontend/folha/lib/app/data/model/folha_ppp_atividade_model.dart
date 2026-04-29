import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FolhaPppAtividadeModel {
	int? id;
	int? idFolhaPpp;
	DateTime? dataInicio;
	DateTime? dataFim;
	String? descricao;

	FolhaPppAtividadeModel({
		this.id,
		this.idFolhaPpp,
		this.dataInicio,
		this.dataFim,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Descricao',
	];

	FolhaPppAtividadeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFolhaPpp = jsonData['idFolhaPpp'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFolhaPpp'] = idFolhaPpp != 0 ? idFolhaPpp : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFolhaPpp = plutoRow.cells['idFolhaPpp']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		descricao = plutoRow.cells['descricao']?.value;
	}	

	FolhaPppAtividadeModel clone() {
		return FolhaPppAtividadeModel(
			id: id,
			idFolhaPpp: idFolhaPpp,
			dataInicio: dataInicio,
			dataFim: dataFim,
			descricao: descricao,
		);			
	}

	
}