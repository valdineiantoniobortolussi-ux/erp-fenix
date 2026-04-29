import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class NfeNumeroInutilizadoModel {
	int? id;
	String? serie;
	int? numero;
	DateTime? dataInutilizacao;
	String? observacao;

	NfeNumeroInutilizadoModel({
		this.id,
		this.serie,
		this.numero,
		this.dataInutilizacao,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'serie',
		'numero',
		'data_inutilizacao',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Serie',
		'Numero',
		'Data Inutilizacao',
		'Observacao',
	];

	NfeNumeroInutilizadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		serie = jsonData['serie'];
		numero = jsonData['numero'];
		dataInutilizacao = jsonData['dataInutilizacao'] != null ? DateTime.tryParse(jsonData['dataInutilizacao']) : null;
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['serie'] = serie;
		jsonData['numero'] = numero;
		jsonData['dataInutilizacao'] = dataInutilizacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInutilizacao!) : null;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		serie = plutoRow.cells['serie']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataInutilizacao = Util.stringToDate(plutoRow.cells['dataInutilizacao']?.value);
		observacao = plutoRow.cells['observacao']?.value;
	}	

	NfeNumeroInutilizadoModel clone() {
		return NfeNumeroInutilizadoModel(
			id: id,
			serie: serie,
			numero: numero,
			dataInutilizacao: dataInutilizacao,
			observacao: observacao,
		);			
	}

	
}