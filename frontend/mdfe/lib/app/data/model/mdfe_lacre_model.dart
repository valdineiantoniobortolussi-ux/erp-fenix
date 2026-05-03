import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class MdfeLacreModel {
	int? id;
	int? idMdfeCabecalho;
	String? numeroLacre;

	MdfeLacreModel({
		this.id,
		this.idMdfeCabecalho,
		this.numeroLacre,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_lacre',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Lacre',
	];

	MdfeLacreModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeCabecalho = jsonData['idMdfeCabecalho'];
		numeroLacre = jsonData['numeroLacre'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeCabecalho'] = idMdfeCabecalho != 0 ? idMdfeCabecalho : null;
		jsonData['numeroLacre'] = numeroLacre;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeCabecalho = plutoRow.cells['idMdfeCabecalho']?.value;
		numeroLacre = plutoRow.cells['numeroLacre']?.value;
	}	

	MdfeLacreModel clone() {
		return MdfeLacreModel(
			id: id,
			idMdfeCabecalho: idMdfeCabecalho,
			numeroLacre: numeroLacre,
		);			
	}

	
}