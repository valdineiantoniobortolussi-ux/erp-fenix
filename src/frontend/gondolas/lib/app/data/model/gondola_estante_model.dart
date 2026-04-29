import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaEstanteModel {
	int? id;
	int? idGondolaRua;
	String? codigo;
	int? quantidadeCaixa;
	GondolaRuaModel? gondolaRuaModel;

	GondolaEstanteModel({
		this.id,
		this.idGondolaRua,
		this.codigo,
		this.quantidadeCaixa,
		this.gondolaRuaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'quantidade_caixa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Quantidade Caixa',
	];

	GondolaEstanteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idGondolaRua = jsonData['idGondolaRua'];
		codigo = jsonData['codigo'];
		quantidadeCaixa = jsonData['quantidadeCaixa'];
		gondolaRuaModel = jsonData['gondolaRuaModel'] == null ? GondolaRuaModel() : GondolaRuaModel.fromJson(jsonData['gondolaRuaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idGondolaRua'] = idGondolaRua != 0 ? idGondolaRua : null;
		jsonData['codigo'] = codigo;
		jsonData['quantidadeCaixa'] = quantidadeCaixa;
		jsonData['gondolaRuaModel'] = gondolaRuaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idGondolaRua = plutoRow.cells['idGondolaRua']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		quantidadeCaixa = plutoRow.cells['quantidadeCaixa']?.value;
		gondolaRuaModel = GondolaRuaModel();
		gondolaRuaModel?.nome = plutoRow.cells['gondolaRuaModel']?.value;
	}	

	GondolaEstanteModel clone() {
		return GondolaEstanteModel(
			id: id,
			idGondolaRua: idGondolaRua,
			codigo: codigo,
			quantidadeCaixa: quantidadeCaixa,
		);			
	}

	
}