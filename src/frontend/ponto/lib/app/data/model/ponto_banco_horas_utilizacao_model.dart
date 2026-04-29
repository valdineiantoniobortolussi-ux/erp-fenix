import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class PontoBancoHorasUtilizacaoModel {
	int? id;
	int? idPontoBancoHoras;
	DateTime? dataUtilizacao;
	String? quantidadeUtilizada;
	String? observacao;

	PontoBancoHorasUtilizacaoModel({
		this.id,
		this.idPontoBancoHoras,
		this.dataUtilizacao,
		this.quantidadeUtilizada,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_utilizacao',
		'quantidade_utilizada',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Utilizacao',
		'Quantidade Utilizada',
		'Observacao',
	];

	PontoBancoHorasUtilizacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPontoBancoHoras = jsonData['idPontoBancoHoras'];
		dataUtilizacao = jsonData['dataUtilizacao'] != null ? DateTime.tryParse(jsonData['dataUtilizacao']) : null;
		quantidadeUtilizada = jsonData['quantidadeUtilizada'];
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPontoBancoHoras'] = idPontoBancoHoras != 0 ? idPontoBancoHoras : null;
		jsonData['dataUtilizacao'] = dataUtilizacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataUtilizacao!) : null;
		jsonData['quantidadeUtilizada'] = Util.removeMask(quantidadeUtilizada);
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPontoBancoHoras = plutoRow.cells['idPontoBancoHoras']?.value;
		dataUtilizacao = Util.stringToDate(plutoRow.cells['dataUtilizacao']?.value);
		quantidadeUtilizada = plutoRow.cells['quantidadeUtilizada']?.value;
		observacao = plutoRow.cells['observacao']?.value;
	}	

	PontoBancoHorasUtilizacaoModel clone() {
		return PontoBancoHorasUtilizacaoModel(
			id: id,
			idPontoBancoHoras: idPontoBancoHoras,
			dataUtilizacao: dataUtilizacao,
			quantidadeUtilizada: quantidadeUtilizada,
			observacao: observacao,
		);			
	}

	
}