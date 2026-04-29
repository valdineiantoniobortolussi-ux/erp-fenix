import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:projetos/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class ProjetoCronogramaModel {
	int? id;
	int? idProjetoPrincipal;
	String? tarefa;
	DateTime? dataTarefa;
	String? descricao;

	ProjetoCronogramaModel({
		this.id,
		this.idProjetoPrincipal,
		this.tarefa,
		this.dataTarefa,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tarefa',
		'data_tarefa',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tarefa',
		'Data Tarefa',
		'Descricao',
	];

	ProjetoCronogramaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProjetoPrincipal = jsonData['idProjetoPrincipal'];
		tarefa = jsonData['tarefa'];
		dataTarefa = jsonData['dataTarefa'] != null ? DateTime.tryParse(jsonData['dataTarefa']) : null;
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProjetoPrincipal'] = idProjetoPrincipal != 0 ? idProjetoPrincipal : null;
		jsonData['tarefa'] = tarefa;
		jsonData['dataTarefa'] = dataTarefa != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataTarefa!) : null;
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProjetoPrincipal = plutoRow.cells['idProjetoPrincipal']?.value;
		tarefa = plutoRow.cells['tarefa']?.value;
		dataTarefa = Util.stringToDate(plutoRow.cells['dataTarefa']?.value);
		descricao = plutoRow.cells['descricao']?.value;
	}	

	ProjetoCronogramaModel clone() {
		return ProjetoCronogramaModel(
			id: id,
			idProjetoPrincipal: idProjetoPrincipal,
			tarefa: tarefa,
			dataTarefa: dataTarefa,
			descricao: descricao,
		);			
	}

	
}