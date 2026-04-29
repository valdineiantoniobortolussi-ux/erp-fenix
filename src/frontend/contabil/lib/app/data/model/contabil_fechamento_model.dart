import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilFechamentoModel {
	int? id;
	DateTime? dataInicio;
	DateTime? dataFim;
	String? criterioLancamento;

	ContabilFechamentoModel({
		this.id,
		this.dataInicio,
		this.dataFim,
		this.criterioLancamento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'criterio_lancamento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Criterio Lancamento',
	];

	ContabilFechamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		criterioLancamento = ContabilFechamentoDomain.getCriterioLancamento(jsonData['criterioLancamento']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['criterioLancamento'] = ContabilFechamentoDomain.setCriterioLancamento(criterioLancamento);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		criterioLancamento = plutoRow.cells['criterioLancamento']?.value != '' ? plutoRow.cells['criterioLancamento']?.value : 'Livre';
	}	

	ContabilFechamentoModel clone() {
		return ContabilFechamentoModel(
			id: id,
			dataInicio: dataInicio,
			dataFim: dataFim,
			criterioLancamento: criterioLancamento,
		);			
	}

	
}