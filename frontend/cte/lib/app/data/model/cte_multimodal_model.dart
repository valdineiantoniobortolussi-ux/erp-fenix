import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/domain/domain_imports.dart';

class CteMultimodalModel {
	int? id;
	int? idCteCabecalho;
	String? cotm;
	String? indicadorNegociavel;

	CteMultimodalModel({
		this.id,
		this.idCteCabecalho,
		this.cotm,
		this.indicadorNegociavel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cotm',
		'indicador_negociavel',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cotm',
		'Indicador Negociavel',
	];

	CteMultimodalModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		cotm = jsonData['cotm'];
		indicadorNegociavel = CteMultimodalDomain.getIndicadorNegociavel(jsonData['indicadorNegociavel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['cotm'] = cotm;
		jsonData['indicadorNegociavel'] = CteMultimodalDomain.setIndicadorNegociavel(indicadorNegociavel);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		cotm = plutoRow.cells['cotm']?.value;
		indicadorNegociavel = plutoRow.cells['indicadorNegociavel']?.value != '' ? plutoRow.cells['indicadorNegociavel']?.value : 'AAA';
	}	

	CteMultimodalModel clone() {
		return CteMultimodalModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			cotm: cotm,
			indicadorNegociavel: indicadorNegociavel,
		);			
	}

	
}