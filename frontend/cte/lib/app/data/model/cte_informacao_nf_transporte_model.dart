import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteInformacaoNfTransporteModel {
	int? id;
	int? idCteInformacaoNf;
	String? tipoUnidadeTransporte;
	String? idUnidadeTransporte;
	CteInformacaoNfOutrosModel? cteInformacaoNfOutrosModel;

	CteInformacaoNfTransporteModel({
		this.id,
		this.idCteInformacaoNf,
		this.tipoUnidadeTransporte,
		this.idUnidadeTransporte,
		this.cteInformacaoNfOutrosModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo_unidade_transporte',
		'id_unidade_transporte',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo Unidade Transporte',
		'Id Unidade Transporte',
	];

	CteInformacaoNfTransporteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteInformacaoNf = jsonData['idCteInformacaoNf'];
		tipoUnidadeTransporte = CteInformacaoNfTransporteDomain.getTipoUnidadeTransporte(jsonData['tipoUnidadeTransporte']);
		idUnidadeTransporte = jsonData['idUnidadeTransporte'];
		cteInformacaoNfOutrosModel = jsonData['cteInformacaoNfOutrosModel'] == null ? CteInformacaoNfOutrosModel() : CteInformacaoNfOutrosModel.fromJson(jsonData['cteInformacaoNfOutrosModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteInformacaoNf'] = idCteInformacaoNf != 0 ? idCteInformacaoNf : null;
		jsonData['tipoUnidadeTransporte'] = CteInformacaoNfTransporteDomain.setTipoUnidadeTransporte(tipoUnidadeTransporte);
		jsonData['idUnidadeTransporte'] = idUnidadeTransporte;
		jsonData['cteInformacaoNfOutrosModel'] = cteInformacaoNfOutrosModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteInformacaoNf = plutoRow.cells['idCteInformacaoNf']?.value;
		tipoUnidadeTransporte = plutoRow.cells['tipoUnidadeTransporte']?.value != '' ? plutoRow.cells['tipoUnidadeTransporte']?.value : 'AAA';
		idUnidadeTransporte = plutoRow.cells['idUnidadeTransporte']?.value;
		cteInformacaoNfOutrosModel = CteInformacaoNfOutrosModel();
		cteInformacaoNfOutrosModel?.numero = plutoRow.cells['cteInformacaoNfOutrosModel']?.value;
	}	

	CteInformacaoNfTransporteModel clone() {
		return CteInformacaoNfTransporteModel(
			id: id,
			idCteInformacaoNf: idCteInformacaoNf,
			tipoUnidadeTransporte: tipoUnidadeTransporte,
			idUnidadeTransporte: idUnidadeTransporte,
		);			
	}

	
}