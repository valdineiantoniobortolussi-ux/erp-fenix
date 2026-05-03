import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class CteDutoviarioModel {
	int? id;
	int? idCteCabecalho;
	double? valorTarifa;
	DateTime? dataInicio;
	DateTime? dataFim;

	CteDutoviarioModel({
		this.id,
		this.idCteCabecalho,
		this.valorTarifa,
		this.dataInicio,
		this.dataFim,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_cte_cabecalho',
		'valor_tarifa',
		'data_inicio',
		'data_fim',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Cte Cabecalho',
		'Valor Tarifa',
		'Data Inicio',
		'Data Fim',
	];

	CteDutoviarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		valorTarifa = jsonData['valorTarifa']?.toDouble();
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['valorTarifa'] = valorTarifa;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		valorTarifa = plutoRow.cells['valorTarifa']?.value?.toDouble();
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
	}	

	CteDutoviarioModel clone() {
		return CteDutoviarioModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			valorTarifa: valorTarifa,
			dataInicio: dataInicio,
			dataFim: dataFim,
		);			
	}

	
}