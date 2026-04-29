import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';

class FolhaFechamentoModel {
	int? id;
	String? fechamentoAtual;
	String? proximoFechamento;

	FolhaFechamentoModel({
		this.id,
		this.fechamentoAtual,
		this.proximoFechamento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'fechamento_atual',
		'proximo_fechamento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Fechamento Atual',
		'Proximo Fechamento',
	];

	FolhaFechamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		fechamentoAtual = jsonData['fechamentoAtual'];
		proximoFechamento = jsonData['proximoFechamento'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['fechamentoAtual'] = Util.removeMask(fechamentoAtual);
		jsonData['proximoFechamento'] = Util.removeMask(proximoFechamento);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		fechamentoAtual = plutoRow.cells['fechamentoAtual']?.value;
		proximoFechamento = plutoRow.cells['proximoFechamento']?.value;
	}	

	FolhaFechamentoModel clone() {
		return FolhaFechamentoModel(
			id: id,
			fechamentoAtual: fechamentoAtual,
			proximoFechamento: proximoFechamento,
		);			
	}

	
}