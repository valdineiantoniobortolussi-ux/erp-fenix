import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CnaeModel {
	int? id;
	String? codigo;
	String? denominacao;

	CnaeModel({
		this.id,
		this.codigo,
		this.denominacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'denominacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Denominacao',
	];

	CnaeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		denominacao = jsonData['denominacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['denominacao'] = denominacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		denominacao = plutoRow.cells['denominacao']?.value;
	}	

	CnaeModel clone() {
		return CnaeModel(
			id: id,
			codigo: codigo,
			denominacao: denominacao,
		);			
	}

	
}