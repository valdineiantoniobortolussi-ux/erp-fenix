import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FrotaVeiculoPneuModel {
	int? id;
	int? idFrotaVeiculo;
	DateTime? dataTroca;
	double? valorTroca;
	String? posicaoPneu;
	String? marcaPneu;

	FrotaVeiculoPneuModel({
		this.id,
		this.idFrotaVeiculo,
		this.dataTroca,
		this.valorTroca,
		this.posicaoPneu,
		this.marcaPneu,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_troca',
		'valor_troca',
		'posicao_pneu',
		'marca_pneu',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Troca',
		'Valor Troca',
		'Posicao Pneu',
		'Marca Pneu',
	];

	FrotaVeiculoPneuModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculo = jsonData['idFrotaVeiculo'];
		dataTroca = jsonData['dataTroca'] != null ? DateTime.tryParse(jsonData['dataTroca']) : null;
		valorTroca = jsonData['valorTroca']?.toDouble();
		posicaoPneu = jsonData['posicaoPneu'];
		marcaPneu = jsonData['marcaPneu'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculo'] = idFrotaVeiculo != 0 ? idFrotaVeiculo : null;
		jsonData['dataTroca'] = dataTroca != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataTroca!) : null;
		jsonData['valorTroca'] = valorTroca;
		jsonData['posicaoPneu'] = posicaoPneu;
		jsonData['marcaPneu'] = marcaPneu;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFrotaVeiculo = plutoRow.cells['idFrotaVeiculo']?.value;
		dataTroca = Util.stringToDate(plutoRow.cells['dataTroca']?.value);
		valorTroca = plutoRow.cells['valorTroca']?.value?.toDouble();
		posicaoPneu = plutoRow.cells['posicaoPneu']?.value;
		marcaPneu = plutoRow.cells['marcaPneu']?.value;
	}	

	FrotaVeiculoPneuModel clone() {
		return FrotaVeiculoPneuModel(
			id: id,
			idFrotaVeiculo: idFrotaVeiculo,
			dataTroca: dataTroca,
			valorTroca: valorTroca,
			posicaoPneu: posicaoPneu,
			marcaPneu: marcaPneu,
		);			
	}

	
}