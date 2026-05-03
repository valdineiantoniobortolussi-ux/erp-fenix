import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contratos/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class ContratoPrevFaturamentoModel {
	int? id;
	int? idContrato;
	DateTime? dataPrevista;
	double? valor;

	ContratoPrevFaturamentoModel({
		this.id,
		this.idContrato,
		this.dataPrevista,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_prevista',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Prevista',
		'Valor',
	];

	ContratoPrevFaturamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContrato = jsonData['idContrato'];
		dataPrevista = jsonData['dataPrevista'] != null ? DateTime.tryParse(jsonData['dataPrevista']) : null;
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContrato'] = idContrato != 0 ? idContrato : null;
		jsonData['dataPrevista'] = dataPrevista != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevista!) : null;
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
		dataPrevista = Util.stringToDate(plutoRow.cells['dataPrevista']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	ContratoPrevFaturamentoModel clone() {
		return ContratoPrevFaturamentoModel(
			id: id,
			idContrato: idContrato,
			dataPrevista: dataPrevista,
			valor: valor,
		);			
	}

	
}