import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class ContabilIndiceValorModel {
	int? id;
	int? idContabilIndice;
	DateTime? dataIndice;
	double? valor;

	ContabilIndiceValorModel({
		this.id,
		this.idContabilIndice,
		this.dataIndice,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_indice',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Indice',
		'Valor',
	];

	ContabilIndiceValorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idContabilIndice = jsonData['idContabilIndice'];
		dataIndice = jsonData['dataIndice'] != null ? DateTime.tryParse(jsonData['dataIndice']) : null;
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idContabilIndice'] = idContabilIndice != 0 ? idContabilIndice : null;
		jsonData['dataIndice'] = dataIndice != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataIndice!) : null;
		jsonData['valor'] = valor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idContabilIndice = plutoRow.cells['idContabilIndice']?.value;
		dataIndice = Util.stringToDate(plutoRow.cells['dataIndice']?.value);
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	ContabilIndiceValorModel clone() {
		return ContabilIndiceValorModel(
			id: id,
			idContabilIndice: idContabilIndice,
			dataIndice: dataIndice,
			valor: valor,
		);			
	}

	
}