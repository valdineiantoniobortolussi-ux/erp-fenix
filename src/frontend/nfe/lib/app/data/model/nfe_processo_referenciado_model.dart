import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeProcessoReferenciadoModel {
	int? id;
	int? idNfeCabecalho;
	String? identificador;
	String? origem;

	NfeProcessoReferenciadoModel({
		this.id,
		this.idNfeCabecalho,
		this.identificador,
		this.origem,
	});

	static List<String> dbColumns = <String>[
		'id',
		'identificador',
		'origem',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Identificador',
		'Origem',
	];

	NfeProcessoReferenciadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		identificador = jsonData['identificador'];
		origem = NfeProcessoReferenciadoDomain.getOrigem(jsonData['origem']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['identificador'] = identificador;
		jsonData['origem'] = NfeProcessoReferenciadoDomain.setOrigem(origem);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		identificador = plutoRow.cells['identificador']?.value;
		origem = plutoRow.cells['origem']?.value != '' ? plutoRow.cells['origem']?.value : 'AAA';
	}	

	NfeProcessoReferenciadoModel clone() {
		return NfeProcessoReferenciadoModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			identificador: identificador,
			origem: origem,
		);			
	}

	
}