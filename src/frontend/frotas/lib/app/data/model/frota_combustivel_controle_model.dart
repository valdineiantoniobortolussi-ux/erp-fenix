import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FrotaCombustivelControleModel {
	int? id;
	int? idFrotaVeiculo;
	DateTime? dataAbastecimento;
	String? horaAbastecimento;
	double? valorAbastecimento;

	FrotaCombustivelControleModel({
		this.id,
		this.idFrotaVeiculo,
		this.dataAbastecimento,
		this.horaAbastecimento,
		this.valorAbastecimento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_abastecimento',
		'hora_abastecimento',
		'valor_abastecimento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Abastecimento',
		'Hora Abastecimento',
		'Valor Abastecimento',
	];

	FrotaCombustivelControleModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculo = jsonData['idFrotaVeiculo'];
		dataAbastecimento = jsonData['dataAbastecimento'] != null ? DateTime.tryParse(jsonData['dataAbastecimento']) : null;
		horaAbastecimento = jsonData['horaAbastecimento'];
		valorAbastecimento = jsonData['valorAbastecimento']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculo'] = idFrotaVeiculo != 0 ? idFrotaVeiculo : null;
		jsonData['dataAbastecimento'] = dataAbastecimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAbastecimento!) : null;
		jsonData['horaAbastecimento'] = Util.removeMask(horaAbastecimento);
		jsonData['valorAbastecimento'] = valorAbastecimento;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFrotaVeiculo = plutoRow.cells['idFrotaVeiculo']?.value;
		dataAbastecimento = Util.stringToDate(plutoRow.cells['dataAbastecimento']?.value);
		horaAbastecimento = plutoRow.cells['horaAbastecimento']?.value;
		valorAbastecimento = plutoRow.cells['valorAbastecimento']?.value?.toDouble();
	}	

	FrotaCombustivelControleModel clone() {
		return FrotaCombustivelControleModel(
			id: id,
			idFrotaVeiculo: idFrotaVeiculo,
			dataAbastecimento: dataAbastecimento,
			horaAbastecimento: horaAbastecimento,
			valorAbastecimento: valorAbastecimento,
		);			
	}

	
}