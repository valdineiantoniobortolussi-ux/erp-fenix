import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';

class CtResultadoNtFinanceiraModel {
	int? id;
	int? idCentroResultado;
	int? idFinNaturezaFinanceira;
	double? percentualRateio;
	FinNaturezaFinanceiraModel? finNaturezaFinanceiraModel;

	CtResultadoNtFinanceiraModel({
		this.id,
		this.idCentroResultado,
		this.idFinNaturezaFinanceira,
		this.percentualRateio,
		this.finNaturezaFinanceiraModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'percentual_rateio',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Percentual Rateio',
	];

	CtResultadoNtFinanceiraModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCentroResultado = jsonData['idCentroResultado'];
		idFinNaturezaFinanceira = jsonData['idFinNaturezaFinanceira'];
		percentualRateio = jsonData['percentualRateio']?.toDouble();
		finNaturezaFinanceiraModel = jsonData['finNaturezaFinanceiraModel'] == null ? FinNaturezaFinanceiraModel() : FinNaturezaFinanceiraModel.fromJson(jsonData['finNaturezaFinanceiraModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCentroResultado'] = idCentroResultado != 0 ? idCentroResultado : null;
		jsonData['idFinNaturezaFinanceira'] = idFinNaturezaFinanceira != 0 ? idFinNaturezaFinanceira : null;
		jsonData['percentualRateio'] = percentualRateio;
		jsonData['finNaturezaFinanceiraModel'] = finNaturezaFinanceiraModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCentroResultado = plutoRow.cells['idCentroResultado']?.value;
		idFinNaturezaFinanceira = plutoRow.cells['idFinNaturezaFinanceira']?.value;
		percentualRateio = plutoRow.cells['percentualRateio']?.value?.toDouble();
		finNaturezaFinanceiraModel = FinNaturezaFinanceiraModel();
		finNaturezaFinanceiraModel?.descricao = plutoRow.cells['finNaturezaFinanceiraModel']?.value;
	}	

	CtResultadoNtFinanceiraModel clone() {
		return CtResultadoNtFinanceiraModel(
			id: id,
			idCentroResultado: idCentroResultado,
			idFinNaturezaFinanceira: idFinNaturezaFinanceira,
			percentualRateio: percentualRateio,
		);			
	}

	
}