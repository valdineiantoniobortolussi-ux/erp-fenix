import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/domain/domain_imports.dart';

class TributIcmsCustomCabModel {
	int? id;
	String? descricao;
	String? origemMercadoria;

	TributIcmsCustomCabModel({
		this.id,
		this.descricao,
		this.origemMercadoria,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'origem_mercadoria',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Origem Mercadoria',
	];

	TributIcmsCustomCabModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		origemMercadoria = TributIcmsCustomCabDomain.getOrigemMercadoria(jsonData['origemMercadoria']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['origemMercadoria'] = TributIcmsCustomCabDomain.setOrigemMercadoria(origemMercadoria);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		origemMercadoria = plutoRow.cells['origemMercadoria']?.value != '' ? plutoRow.cells['origemMercadoria']?.value : 'AAA';
	}	

	TributIcmsCustomCabModel clone() {
		return TributIcmsCustomCabModel(
			id: id,
			descricao: descricao,
			origemMercadoria: origemMercadoria,
		);			
	}

	
}