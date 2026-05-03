import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CtePassagemModel {
	int? id;
	int? idCteCabecalho;
	String? siglaPassagem;
	String? siglaDestino;
	String? rota;

	CtePassagemModel({
		this.id,
		this.idCteCabecalho,
		this.siglaPassagem,
		this.siglaDestino,
		this.rota,
	});

	static List<String> dbColumns = <String>[
		'id',
		'sigla_passagem',
		'sigla_destino',
		'rota',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Sigla Passagem',
		'Sigla Destino',
		'Rota',
	];

	CtePassagemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		siglaPassagem = jsonData['siglaPassagem'];
		siglaDestino = jsonData['siglaDestino'];
		rota = jsonData['rota'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['siglaPassagem'] = siglaPassagem;
		jsonData['siglaDestino'] = siglaDestino;
		jsonData['rota'] = rota;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		siglaPassagem = plutoRow.cells['siglaPassagem']?.value;
		siglaDestino = plutoRow.cells['siglaDestino']?.value;
		rota = plutoRow.cells['rota']?.value;
	}	

	CtePassagemModel clone() {
		return CtePassagemModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			siglaPassagem: siglaPassagem,
			siglaDestino: siglaDestino,
			rota: rota,
		);			
	}

	
}