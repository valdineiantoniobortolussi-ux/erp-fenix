import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfTransporteLacreModel {
	int? id;
	int? idCteInformacaoNfTransporte;
	String? numero;
	CteInformacaoNfTransporteModel? cteInformacaoNfTransporteModel;

	CteInfNfTransporteLacreModel({
		this.id,
		this.idCteInformacaoNfTransporte,
		this.numero,
		this.cteInformacaoNfTransporteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
	];

	CteInfNfTransporteLacreModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteInformacaoNfTransporte = jsonData['idCteInformacaoNfTransporte'];
		numero = jsonData['numero'];
		cteInformacaoNfTransporteModel = jsonData['cteInformacaoNfTransporteModel'] == null ? CteInformacaoNfTransporteModel() : CteInformacaoNfTransporteModel.fromJson(jsonData['cteInformacaoNfTransporteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteInformacaoNfTransporte'] = idCteInformacaoNfTransporte != 0 ? idCteInformacaoNfTransporte : null;
		jsonData['numero'] = numero;
		jsonData['cteInformacaoNfTransporteModel'] = cteInformacaoNfTransporteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteInformacaoNfTransporte = plutoRow.cells['idCteInformacaoNfTransporte']?.value;
		numero = plutoRow.cells['numero']?.value;
		cteInformacaoNfTransporteModel = CteInformacaoNfTransporteModel();
		cteInformacaoNfTransporteModel?.tipoUnidadeTransporte = plutoRow.cells['cteInformacaoNfTransporteModel']?.value;
	}	

	CteInfNfTransporteLacreModel clone() {
		return CteInfNfTransporteLacreModel(
			id: id,
			idCteInformacaoNfTransporte: idCteInformacaoNfTransporte,
			numero: numero,
		);			
	}

	
}