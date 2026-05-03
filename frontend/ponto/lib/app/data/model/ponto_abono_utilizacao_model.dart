import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class PontoAbonoUtilizacaoModel {
	int? id;
	int? idPontoAbono;
	DateTime? dataUtilizacao;
	String? observacao;

	PontoAbonoUtilizacaoModel({
		this.id,
		this.idPontoAbono,
		this.dataUtilizacao,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_utilizacao',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Utilizacao',
		'Observacao',
	];

	PontoAbonoUtilizacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPontoAbono = jsonData['idPontoAbono'];
		dataUtilizacao = jsonData['dataUtilizacao'] != null ? DateTime.tryParse(jsonData['dataUtilizacao']) : null;
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPontoAbono'] = idPontoAbono != 0 ? idPontoAbono : null;
		jsonData['dataUtilizacao'] = dataUtilizacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataUtilizacao!) : null;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPontoAbono = plutoRow.cells['idPontoAbono']?.value;
		dataUtilizacao = Util.stringToDate(plutoRow.cells['dataUtilizacao']?.value);
		observacao = plutoRow.cells['observacao']?.value;
	}	

	PontoAbonoUtilizacaoModel clone() {
		return PontoAbonoUtilizacaoModel(
			id: id,
			idPontoAbono: idPontoAbono,
			dataUtilizacao: dataUtilizacao,
			observacao: observacao,
		);			
	}

	
}