import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FrotaVeiculoSinistroModel {
	int? id;
	int? idFrotaVeiculo;
	DateTime? dataSinistro;
	String? observacao;

	FrotaVeiculoSinistroModel({
		this.id,
		this.idFrotaVeiculo,
		this.dataSinistro,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_sinistro',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Sinistro',
		'Observacao',
	];

	FrotaVeiculoSinistroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculo = jsonData['idFrotaVeiculo'];
		dataSinistro = jsonData['dataSinistro'] != null ? DateTime.tryParse(jsonData['dataSinistro']) : null;
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculo'] = idFrotaVeiculo != 0 ? idFrotaVeiculo : null;
		jsonData['dataSinistro'] = dataSinistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataSinistro!) : null;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFrotaVeiculo = plutoRow.cells['idFrotaVeiculo']?.value;
		dataSinistro = Util.stringToDate(plutoRow.cells['dataSinistro']?.value);
		observacao = plutoRow.cells['observacao']?.value;
	}	

	FrotaVeiculoSinistroModel clone() {
		return FrotaVeiculoSinistroModel(
			id: id,
			idFrotaVeiculo: idFrotaVeiculo,
			dataSinistro: dataSinistro,
			observacao: observacao,
		);			
	}

	
}