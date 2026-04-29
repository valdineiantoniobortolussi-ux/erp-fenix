import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/model/model_imports.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteInformacaoNfCargaModel {
	int? id;
	int? idCteInformacaoNf;
	String? tipoUnidadeCarga;
	String? idUnidadeCarga;
	CteInformacaoNfOutrosModel? cteInformacaoNfOutrosModel;

	CteInformacaoNfCargaModel({
		this.id,
		this.idCteInformacaoNf,
		this.tipoUnidadeCarga,
		this.idUnidadeCarga,
		this.cteInformacaoNfOutrosModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo_unidade_carga',
		'id_unidade_carga',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo Unidade Carga',
		'Id Unidade Carga',
	];

	CteInformacaoNfCargaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteInformacaoNf = jsonData['idCteInformacaoNf'];
		tipoUnidadeCarga = CteInformacaoNfCargaDomain.getTipoUnidadeCarga(jsonData['tipoUnidadeCarga']);
		idUnidadeCarga = jsonData['idUnidadeCarga'];
		cteInformacaoNfOutrosModel = jsonData['cteInformacaoNfOutrosModel'] == null ? CteInformacaoNfOutrosModel() : CteInformacaoNfOutrosModel.fromJson(jsonData['cteInformacaoNfOutrosModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteInformacaoNf'] = idCteInformacaoNf != 0 ? idCteInformacaoNf : null;
		jsonData['tipoUnidadeCarga'] = CteInformacaoNfCargaDomain.setTipoUnidadeCarga(tipoUnidadeCarga);
		jsonData['idUnidadeCarga'] = idUnidadeCarga;
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
		tipoUnidadeCarga = plutoRow.cells['tipoUnidadeCarga']?.value != '' ? plutoRow.cells['tipoUnidadeCarga']?.value : 'AAA';
		idUnidadeCarga = plutoRow.cells['idUnidadeCarga']?.value;
		cteInformacaoNfOutrosModel = CteInformacaoNfOutrosModel();
		cteInformacaoNfOutrosModel?.numero = plutoRow.cells['cteInformacaoNfOutrosModel']?.value;
	}	

	CteInformacaoNfCargaModel clone() {
		return CteInformacaoNfCargaModel(
			id: id,
			idCteInformacaoNf: idCteInformacaoNf,
			tipoUnidadeCarga: tipoUnidadeCarga,
			idUnidadeCarga: idUnidadeCarga,
		);			
	}

	
}