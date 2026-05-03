import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';

class ContabilContaRateioModel {
	int? id;
	int? idCentroResultado;
	int? idContabilConta;
	double? porcentoRateio;
	ContabilContaModel? contabilContaModel;
	CentroResultadoModel? centroResultadoModel;

	ContabilContaRateioModel({
		this.id,
		this.idCentroResultado,
		this.idContabilConta,
		this.porcentoRateio,
		this.contabilContaModel,
		this.centroResultadoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'porcento_rateio',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Porcento Rateio',
	];

	ContabilContaRateioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCentroResultado = jsonData['idCentroResultado'];
		idContabilConta = jsonData['idContabilConta'];
		porcentoRateio = jsonData['porcentoRateio']?.toDouble();
		contabilContaModel = jsonData['contabilContaModel'] == null ? ContabilContaModel() : ContabilContaModel.fromJson(jsonData['contabilContaModel']);
		centroResultadoModel = jsonData['centroResultadoModel'] == null ? CentroResultadoModel() : CentroResultadoModel.fromJson(jsonData['centroResultadoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCentroResultado'] = idCentroResultado != 0 ? idCentroResultado : null;
		jsonData['idContabilConta'] = idContabilConta != 0 ? idContabilConta : null;
		jsonData['porcentoRateio'] = porcentoRateio;
		jsonData['contabilContaModel'] = contabilContaModel?.toJson;
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
		idContabilConta = plutoRow.cells['idContabilConta']?.value;
		porcentoRateio = plutoRow.cells['porcentoRateio']?.value?.toDouble();
		contabilContaModel = ContabilContaModel();
		contabilContaModel?.descricao = plutoRow.cells['contabilContaModel']?.value;
		centroResultadoModel = CentroResultadoModel();
		centroResultadoModel?.descricao = plutoRow.cells['centroResultadoModel']?.value;
	}	

	ContabilContaRateioModel clone() {
		return ContabilContaRateioModel(
			id: id,
			idCentroResultado: idCentroResultado,
			idContabilConta: idContabilConta,
			porcentoRateio: porcentoRateio,
		);			
	}

	
}