import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class CteDuplicataModel {
	int? id;
	int? idCteCabecalho;
	String? numero;
	DateTime? dataVencimento;
	double? valor;

	CteDuplicataModel({
		this.id,
		this.idCteCabecalho,
		this.numero,
		this.dataVencimento,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'data_vencimento',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Data Vencimento',
		'Valor',
	];

	CteDuplicataModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		numero = jsonData['numero'];
		dataVencimento = jsonData['dataVencimento'] != null ? DateTime.tryParse(jsonData['dataVencimento']) : null;
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['numero'] = numero;
		jsonData['dataVencimento'] = dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVencimento!) : null;
		jsonData['valor'] = valor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		numero = plutoRow.cells['numero']?.value;
		dataVencimento = Util.stringToDate(plutoRow.cells['dataVencimento']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	CteDuplicataModel clone() {
		return CteDuplicataModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			numero: numero,
			dataVencimento: dataVencimento,
			valor: valor,
		);			
	}

	
}