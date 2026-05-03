import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class WmsAgendamentoModel {
	int? id;
	DateTime? dataOperacao;
	String? horaOperacao;
	String? localOperacao;
	int? quantidadeVolume;
	double? pesoTotalVolume;
	int? quantidadePessoa;
	int? quantidadeHora;

	WmsAgendamentoModel({
		this.id,
		this.dataOperacao,
		this.horaOperacao,
		this.localOperacao,
		this.quantidadeVolume,
		this.pesoTotalVolume,
		this.quantidadePessoa,
		this.quantidadeHora,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_operacao',
		'hora_operacao',
		'local_operacao',
		'quantidade_volume',
		'peso_total_volume',
		'quantidade_pessoa',
		'quantidade_hora',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Operacao',
		'Hora Operacao',
		'Local Operacao',
		'Quantidade Volume',
		'Peso Total Volume',
		'Quantidade Pessoa',
		'Quantidade Hora',
	];

	WmsAgendamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataOperacao = jsonData['dataOperacao'] != null ? DateTime.tryParse(jsonData['dataOperacao']) : null;
		horaOperacao = jsonData['horaOperacao'];
		localOperacao = jsonData['localOperacao'];
		quantidadeVolume = jsonData['quantidadeVolume'];
		pesoTotalVolume = jsonData['pesoTotalVolume']?.toDouble();
		quantidadePessoa = jsonData['quantidadePessoa'];
		quantidadeHora = jsonData['quantidadeHora'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataOperacao'] = dataOperacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataOperacao!) : null;
		jsonData['horaOperacao'] = Util.removeMask(horaOperacao);
		jsonData['localOperacao'] = localOperacao;
		jsonData['quantidadeVolume'] = quantidadeVolume;
		jsonData['pesoTotalVolume'] = pesoTotalVolume;
		jsonData['quantidadePessoa'] = quantidadePessoa;
		jsonData['quantidadeHora'] = quantidadeHora;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		dataOperacao = Util.stringToDate(plutoRow.cells['dataOperacao']?.value);
		horaOperacao = plutoRow.cells['horaOperacao']?.value;
		localOperacao = plutoRow.cells['localOperacao']?.value;
		quantidadeVolume = plutoRow.cells['quantidadeVolume']?.value;
		pesoTotalVolume = plutoRow.cells['pesoTotalVolume']?.value?.toDouble();
		quantidadePessoa = plutoRow.cells['quantidadePessoa']?.value;
		quantidadeHora = plutoRow.cells['quantidadeHora']?.value;
	}	

	WmsAgendamentoModel clone() {
		return WmsAgendamentoModel(
			id: id,
			dataOperacao: dataOperacao,
			horaOperacao: horaOperacao,
			localOperacao: localOperacao,
			quantidadeVolume: quantidadeVolume,
			pesoTotalVolume: pesoTotalVolume,
			quantidadePessoa: quantidadePessoa,
			quantidadeHora: quantidadeHora,
		);			
	}

	
}