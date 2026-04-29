import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioLacreModel {
	int? id;
	int? idCteRodoviario;
	String? numero;
	CteRodoviarioModel? cteRodoviarioModel;

	CteRodoviarioLacreModel({
		this.id,
		this.idCteRodoviario,
		this.numero,
		this.cteRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
	];

	CteRodoviarioLacreModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteRodoviario = jsonData['idCteRodoviario'];
		numero = jsonData['numero'];
		cteRodoviarioModel = jsonData['cteRodoviarioModel'] == null ? CteRodoviarioModel() : CteRodoviarioModel.fromJson(jsonData['cteRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteRodoviario'] = idCteRodoviario != 0 ? idCteRodoviario : null;
		jsonData['numero'] = numero;
		jsonData['cteRodoviarioModel'] = cteRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteRodoviario = plutoRow.cells['idCteRodoviario']?.value;
		numero = plutoRow.cells['numero']?.value;
		cteRodoviarioModel = CteRodoviarioModel();
		cteRodoviarioModel?.rntrc = plutoRow.cells['cteRodoviarioModel']?.value;
	}	

	CteRodoviarioLacreModel clone() {
		return CteRodoviarioLacreModel(
			id: id,
			idCteRodoviario: idCteRodoviario,
			numero: numero,
		);			
	}

	
}