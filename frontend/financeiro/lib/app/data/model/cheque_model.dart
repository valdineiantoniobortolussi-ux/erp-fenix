import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class ChequeModel {
	int? id;
	int? idTalonarioCheque;
	int? numero;
	String? statusCheque;
	DateTime? dataStatus;

	ChequeModel({
		this.id,
		this.idTalonarioCheque,
		this.numero,
		this.statusCheque,
		this.dataStatus,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'status_cheque',
		'data_status',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Status Cheque',
		'Data Status',
	];

	ChequeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idTalonarioCheque = jsonData['idTalonarioCheque'];
		numero = jsonData['numero'];
		statusCheque = ChequeDomain.getStatusCheque(jsonData['statusCheque']);
		dataStatus = jsonData['dataStatus'] != null ? DateTime.tryParse(jsonData['dataStatus']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idTalonarioCheque'] = idTalonarioCheque != 0 ? idTalonarioCheque : null;
		jsonData['numero'] = numero;
		jsonData['statusCheque'] = ChequeDomain.setStatusCheque(statusCheque);
		jsonData['dataStatus'] = dataStatus != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataStatus!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idTalonarioCheque = plutoRow.cells['idTalonarioCheque']?.value;
		numero = plutoRow.cells['numero']?.value;
		statusCheque = plutoRow.cells['statusCheque']?.value != '' ? plutoRow.cells['statusCheque']?.value : 'Em Ser';
		dataStatus = Util.stringToDate(plutoRow.cells['dataStatus']?.value);
	}	

	ChequeModel clone() {
		return ChequeModel(
			id: id,
			idTalonarioCheque: idTalonarioCheque,
			numero: numero,
			statusCheque: statusCheque,
			dataStatus: dataStatus,
		);			
	}

	
}