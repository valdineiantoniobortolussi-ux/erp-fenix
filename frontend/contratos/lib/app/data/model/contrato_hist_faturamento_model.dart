import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class ContratoHistFaturamentoModel {
	int? id;
	int? idContrato;
	DateTime? dataFatura;
	double? valor;

	ContratoHistFaturamentoModel({
		this.id,
		this.idContrato,
		this.dataFatura,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_fatura',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Fatura',
		'Valor',
	];

	ContratoHistFaturamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContrato = jsonData['idContrato'];
		dataFatura = jsonData['dataFatura'] != null ? DateTime.tryParse(jsonData['dataFatura']) : null;
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContrato'] = idContrato != 0 ? idContrato : null;
		jsonData['dataFatura'] = dataFatura != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFatura!) : null;
		jsonData['valor'] = valor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContrato = plutoRow.cells['idContrato']?.value;
		dataFatura = Util.stringToDate(plutoRow.cells['dataFatura']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	ContratoHistFaturamentoModel clone() {
		return ContratoHistFaturamentoModel(
			id: id,
			idContrato: idContrato,
			dataFatura: dataFatura,
			valor: valor,
		);			
	}

	
}