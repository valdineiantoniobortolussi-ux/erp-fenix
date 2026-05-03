import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FrotaMultaControleModel {
	int? id;
	int? idFrotaVeiculo;
	DateTime? dataMulta;
	int? pontos;
	double? valor;
	String? observacao;

	FrotaMultaControleModel({
		this.id,
		this.idFrotaVeiculo,
		this.dataMulta,
		this.pontos,
		this.valor,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_multa',
		'pontos',
		'valor',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Multa',
		'Pontos',
		'Valor',
		'Observacao',
	];

	FrotaMultaControleModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculo = jsonData['idFrotaVeiculo'];
		dataMulta = jsonData['dataMulta'] != null ? DateTime.tryParse(jsonData['dataMulta']) : null;
		pontos = jsonData['pontos'];
		valor = jsonData['valor']?.toDouble();
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculo'] = idFrotaVeiculo != 0 ? idFrotaVeiculo : null;
		jsonData['dataMulta'] = dataMulta != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataMulta!) : null;
		jsonData['pontos'] = pontos;
		jsonData['valor'] = valor;
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
		dataMulta = Util.stringToDate(plutoRow.cells['dataMulta']?.value);
		pontos = plutoRow.cells['pontos']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
		observacao = plutoRow.cells['observacao']?.value;
	}	

	FrotaMultaControleModel clone() {
		return FrotaMultaControleModel(
			id: id,
			idFrotaVeiculo: idFrotaVeiculo,
			dataMulta: dataMulta,
			pontos: pontos,
			valor: valor,
			observacao: observacao,
		);			
	}

	
}