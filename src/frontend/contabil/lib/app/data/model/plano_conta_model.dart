import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class PlanoContaModel {
	int? id;
	String? nome;
	DateTime? dataInclusao;
	String? mascara;
	int? niveis;

	PlanoContaModel({
		this.id,
		this.nome,
		this.dataInclusao,
		this.mascara,
		this.niveis,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'data_inclusao',
		'mascara',
		'niveis',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Data Inclusao',
		'Mascara',
		'Niveis',
	];

	PlanoContaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
		mascara = jsonData['mascara'];
		niveis = jsonData['niveis'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
		jsonData['mascara'] = mascara;
		jsonData['niveis'] = niveis;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
		mascara = plutoRow.cells['mascara']?.value;
		niveis = plutoRow.cells['niveis']?.value;
	}	

	PlanoContaModel clone() {
		return PlanoContaModel(
			id: id,
			nome: nome,
			dataInclusao: dataInclusao,
			mascara: mascara,
			niveis: niveis,
		);			
	}

	
}