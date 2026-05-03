import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';

class EncerraCentroResultadoModel {
	int? id;
	int? idCentroResultado;
	String? competencia;
	double? valorTotal;
	double? valorSubRateio;
	CentroResultadoModel? centroResultadoModel;

	EncerraCentroResultadoModel({
		this.id,
		this.idCentroResultado,
		this.competencia,
		this.valorTotal,
		this.valorSubRateio,
		this.centroResultadoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'valor_total',
		'valor_sub_rateio',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Valor Total',
		'Valor Sub Rateio',
	];

	EncerraCentroResultadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCentroResultado = jsonData['idCentroResultado'];
		competencia = jsonData['competencia'];
		valorTotal = jsonData['valorTotal']?.toDouble();
		valorSubRateio = jsonData['valorSubRateio']?.toDouble();
		centroResultadoModel = jsonData['centroResultadoModel'] == null ? CentroResultadoModel() : CentroResultadoModel.fromJson(jsonData['centroResultadoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCentroResultado'] = idCentroResultado != 0 ? idCentroResultado : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['valorTotal'] = valorTotal;
		jsonData['valorSubRateio'] = valorSubRateio;
		jsonData['centroResultadoModel'] = centroResultadoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCentroResultado = plutoRow.cells['idCentroResultado']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		valorTotal = plutoRow.cells['valorTotal']?.value?.toDouble();
		valorSubRateio = plutoRow.cells['valorSubRateio']?.value?.toDouble();
		centroResultadoModel = CentroResultadoModel();
		centroResultadoModel?.descricao = plutoRow.cells['centroResultadoModel']?.value;
	}	

	EncerraCentroResultadoModel clone() {
		return EncerraCentroResultadoModel(
			id: id,
			idCentroResultado: idCentroResultado,
			competencia: competencia,
			valorTotal: valorTotal,
			valorSubRateio: valorSubRateio,
		);			
	}

	
}