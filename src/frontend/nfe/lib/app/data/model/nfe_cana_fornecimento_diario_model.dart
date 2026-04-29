import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeCanaFornecimentoDiarioModel {
	int? id;
	int? idNfeCana;
	String? dia;
	double? quantidade;
	double? quantidadeTotalMes;
	double? quantidadeTotalAnterior;
	double? quantidadeTotalGeral;
	NfeCanaModel? nfeCanaModel;

	NfeCanaFornecimentoDiarioModel({
		this.id,
		this.idNfeCana,
		this.dia,
		this.quantidade,
		this.quantidadeTotalMes,
		this.quantidadeTotalAnterior,
		this.quantidadeTotalGeral,
		this.nfeCanaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'dia',
		'quantidade',
		'quantidade_total_mes',
		'quantidade_total_anterior',
		'quantidade_total_geral',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Dia',
		'Quantidade',
		'Quantidade Total Mes',
		'Quantidade Total Anterior',
		'Quantidade Total Geral',
	];

	NfeCanaFornecimentoDiarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCana = jsonData['idNfeCana'];
		dia = NfeCanaFornecimentoDiarioDomain.getDia(jsonData['dia']);
		quantidade = jsonData['quantidade']?.toDouble();
		quantidadeTotalMes = jsonData['quantidadeTotalMes']?.toDouble();
		quantidadeTotalAnterior = jsonData['quantidadeTotalAnterior']?.toDouble();
		quantidadeTotalGeral = jsonData['quantidadeTotalGeral']?.toDouble();
		nfeCanaModel = jsonData['nfeCanaModel'] == null ? NfeCanaModel() : NfeCanaModel.fromJson(jsonData['nfeCanaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCana'] = idNfeCana != 0 ? idNfeCana : null;
		jsonData['dia'] = NfeCanaFornecimentoDiarioDomain.setDia(dia);
		jsonData['quantidade'] = quantidade;
		jsonData['quantidadeTotalMes'] = quantidadeTotalMes;
		jsonData['quantidadeTotalAnterior'] = quantidadeTotalAnterior;
		jsonData['quantidadeTotalGeral'] = quantidadeTotalGeral;
		jsonData['nfeCanaModel'] = nfeCanaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCana = plutoRow.cells['idNfeCana']?.value;
		dia = plutoRow.cells['dia']?.value != '' ? plutoRow.cells['dia']?.value : 'AAA';
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
		quantidadeTotalMes = plutoRow.cells['quantidadeTotalMes']?.value?.toDouble();
		quantidadeTotalAnterior = plutoRow.cells['quantidadeTotalAnterior']?.value?.toDouble();
		quantidadeTotalGeral = plutoRow.cells['quantidadeTotalGeral']?.value?.toDouble();
		nfeCanaModel = NfeCanaModel();
		nfeCanaModel?.safra = plutoRow.cells['nfeCanaModel']?.value;
	}	

	NfeCanaFornecimentoDiarioModel clone() {
		return NfeCanaFornecimentoDiarioModel(
			id: id,
			idNfeCana: idNfeCana,
			dia: dia,
			quantidade: quantidade,
			quantidadeTotalMes: quantidadeTotalMes,
			quantidadeTotalAnterior: quantidadeTotalAnterior,
			quantidadeTotalGeral: quantidadeTotalGeral,
		);			
	}

	
}