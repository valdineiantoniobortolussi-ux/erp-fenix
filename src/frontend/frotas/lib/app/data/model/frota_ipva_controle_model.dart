import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:frotas/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FrotaIpvaControleModel {
	int? id;
	int? idFrotaVeiculo;
	String? ano;
	String? parcela;
	DateTime? dataVencimento;
	DateTime? dataPagamento;
	double? valor;

	FrotaIpvaControleModel({
		this.id,
		this.idFrotaVeiculo,
		this.ano,
		this.parcela,
		this.dataVencimento,
		this.dataPagamento,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'ano',
		'parcela',
		'data_vencimento',
		'data_pagamento',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Ano',
		'Parcela',
		'Data Vencimento',
		'Data Pagamento',
		'Valor',
	];

	FrotaIpvaControleModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFrotaVeiculo = jsonData['idFrotaVeiculo'];
		ano = jsonData['ano'];
		parcela = jsonData['parcela'];
		dataVencimento = jsonData['dataVencimento'] != null ? DateTime.tryParse(jsonData['dataVencimento']) : null;
		dataPagamento = jsonData['dataPagamento'] != null ? DateTime.tryParse(jsonData['dataPagamento']) : null;
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFrotaVeiculo'] = idFrotaVeiculo != 0 ? idFrotaVeiculo : null;
		jsonData['ano'] = ano;
		jsonData['parcela'] = parcela;
		jsonData['dataVencimento'] = dataVencimento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataVencimento!) : null;
		jsonData['dataPagamento'] = dataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPagamento!) : null;
		jsonData['valor'] = valor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFrotaVeiculo = plutoRow.cells['idFrotaVeiculo']?.value;
		ano = plutoRow.cells['ano']?.value;
		parcela = plutoRow.cells['parcela']?.value;
		dataVencimento = Util.stringToDate(plutoRow.cells['dataVencimento']?.value);
		dataPagamento = Util.stringToDate(plutoRow.cells['dataPagamento']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	FrotaIpvaControleModel clone() {
		return FrotaIpvaControleModel(
			id: id,
			idFrotaVeiculo: idFrotaVeiculo,
			ano: ano,
			parcela: parcela,
			dataVencimento: dataVencimento,
			dataPagamento: dataPagamento,
			valor: valor,
		);			
	}

	
}