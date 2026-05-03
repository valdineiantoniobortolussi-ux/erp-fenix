import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';

class RateioCentroResultadoDetModel {
	int? id;
	int? idRateioCentroResulCab;
	int? idCentroResultadoDestino;
	double? porcentoRateio;
	CentroResultadoModel? centroResultadoModel;

	RateioCentroResultadoDetModel({
		this.id,
		this.idRateioCentroResulCab,
		this.idCentroResultadoDestino,
		this.porcentoRateio,
		this.centroResultadoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'porcento_rateio',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Porcento Rateio',
	];

	RateioCentroResultadoDetModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idRateioCentroResulCab = jsonData['idRateioCentroResulCab'];
		idCentroResultadoDestino = jsonData['idCentroResultadoDestino'];
		porcentoRateio = jsonData['porcentoRateio']?.toDouble();
		centroResultadoModel = jsonData['centroResultadoModel'] == null ? CentroResultadoModel() : CentroResultadoModel.fromJson(jsonData['centroResultadoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idRateioCentroResulCab'] = idRateioCentroResulCab != 0 ? idRateioCentroResulCab : null;
		jsonData['idCentroResultadoDestino'] = idCentroResultadoDestino != 0 ? idCentroResultadoDestino : null;
		jsonData['porcentoRateio'] = porcentoRateio;
		jsonData['centroResultadoModel'] = centroResultadoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idRateioCentroResulCab = plutoRow.cells['idRateioCentroResulCab']?.value;
		idCentroResultadoDestino = plutoRow.cells['idCentroResultadoDestino']?.value;
		porcentoRateio = plutoRow.cells['porcentoRateio']?.value?.toDouble();
		centroResultadoModel = CentroResultadoModel();
		centroResultadoModel?.descricao = plutoRow.cells['centroResultadoModel']?.value;
	}	

	RateioCentroResultadoDetModel clone() {
		return RateioCentroResultadoDetModel(
			id: id,
			idRateioCentroResulCab: idRateioCentroResulCab,
			idCentroResultadoDestino: idCentroResultadoDestino,
			porcentoRateio: porcentoRateio,
		);			
	}

	
}