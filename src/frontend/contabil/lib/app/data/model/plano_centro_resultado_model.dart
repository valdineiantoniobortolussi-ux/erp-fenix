import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class PlanoCentroResultadoModel {
	int? id;
	String? nome;
	String? mascara;
	int? niveis;
	DateTime? dataInclusao;

	PlanoCentroResultadoModel({
		this.id,
		this.nome,
		this.mascara,
		this.niveis,
		this.dataInclusao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'mascara',
		'niveis',
		'data_inclusao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Mascara',
		'Niveis',
		'Data Inclusao',
	];

	PlanoCentroResultadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		mascara = jsonData['mascara'];
		niveis = jsonData['niveis'];
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['mascara'] = mascara;
		jsonData['niveis'] = niveis;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		mascara = plutoRow.cells['mascara']?.value;
		niveis = plutoRow.cells['niveis']?.value;
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
	}	

	PlanoCentroResultadoModel clone() {
		return PlanoCentroResultadoModel(
			id: id,
			nome: nome,
			mascara: mascara,
			niveis: niveis,
			dataInclusao: dataInclusao,
		);			
	}

	
}