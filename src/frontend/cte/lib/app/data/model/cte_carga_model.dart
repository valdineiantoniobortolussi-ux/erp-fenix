import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/domain/domain_imports.dart';

class CteCargaModel {
	int? id;
	int? idCteCabecalho;
	String? codigoUnidadeMedida;
	String? tipoMedida;
	double? quantidade;

	CteCargaModel({
		this.id,
		this.idCteCabecalho,
		this.codigoUnidadeMedida,
		this.tipoMedida,
		this.quantidade,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_unidade_medida',
		'tipo_medida',
		'quantidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Unidade Medida',
		'Tipo Medida',
		'Quantidade',
	];

	CteCargaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		codigoUnidadeMedida = CteCargaDomain.getCodigoUnidadeMedida(jsonData['codigoUnidadeMedida']);
		tipoMedida = jsonData['tipoMedida'];
		quantidade = jsonData['quantidade']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['codigoUnidadeMedida'] = CteCargaDomain.setCodigoUnidadeMedida(codigoUnidadeMedida);
		jsonData['tipoMedida'] = tipoMedida;
		jsonData['quantidade'] = quantidade;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		codigoUnidadeMedida = plutoRow.cells['codigoUnidadeMedida']?.value != '' ? plutoRow.cells['codigoUnidadeMedida']?.value : 'AAA';
		tipoMedida = plutoRow.cells['tipoMedida']?.value;
		quantidade = plutoRow.cells['quantidade']?.value?.toDouble();
	}	

	CteCargaModel clone() {
		return CteCargaModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			codigoUnidadeMedida: codigoUnidadeMedida,
			tipoMedida: tipoMedida,
			quantidade: quantidade,
		);			
	}

	
}