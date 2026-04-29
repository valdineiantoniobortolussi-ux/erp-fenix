import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:frotas/app/data/domain/domain_imports.dart';

class FrotaVeiculoManutencaoModel {
	int? id;
	int? idFrotaVeiculo;
	String? tipo;
	DateTime? dataManutencao;
	double? valorManutencao;
	String? observacao;

	FrotaVeiculoManutencaoModel({
		this.id,
		this.idFrotaVeiculo,
		this.tipo,
		this.dataManutencao,
		this.valorManutencao,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo',
		'data_manutencao',
		'valor_manutencao',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo',
		'Data Manutencao',
		'Valor Manutencao',
		'Observacao',
	];

	FrotaVeiculoManutencaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculo = jsonData['idFrotaVeiculo'];
		tipo = FrotaVeiculoManutencaoDomain.getTipo(jsonData['tipo']);
		dataManutencao = jsonData['dataManutencao'] != null ? DateTime.tryParse(jsonData['dataManutencao']) : null;
		valorManutencao = jsonData['valorManutencao']?.toDouble();
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculo'] = idFrotaVeiculo != 0 ? idFrotaVeiculo : null;
		jsonData['tipo'] = FrotaVeiculoManutencaoDomain.setTipo(tipo);
		jsonData['dataManutencao'] = dataManutencao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataManutencao!) : null;
		jsonData['valorManutencao'] = valorManutencao;
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
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Preventiva';
		dataManutencao = Util.stringToDate(plutoRow.cells['dataManutencao']?.value);
		valorManutencao = plutoRow.cells['valorManutencao']?.value?.toDouble();
		observacao = plutoRow.cells['observacao']?.value;
	}	

	FrotaVeiculoManutencaoModel clone() {
		return FrotaVeiculoManutencaoModel(
			id: id,
			idFrotaVeiculo: idFrotaVeiculo,
			tipo: tipo,
			dataManutencao: dataManutencao,
			valorManutencao: valorManutencao,
			observacao: observacao,
		);			
	}

	
}