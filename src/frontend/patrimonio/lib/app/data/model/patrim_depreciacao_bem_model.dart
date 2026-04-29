import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class PatrimDepreciacaoBemModel {
	int? id;
	int? idPatrimBem;
	DateTime? dataDepreciacao;
	int? dias;
	double? taxa;
	double? indice;
	double? valor;
	double? depreciacaoAcumulada;

	PatrimDepreciacaoBemModel({
		this.id,
		this.idPatrimBem,
		this.dataDepreciacao,
		this.dias,
		this.taxa,
		this.indice,
		this.valor,
		this.depreciacaoAcumulada,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_depreciacao',
		'dias',
		'taxa',
		'indice',
		'valor',
		'depreciacao_acumulada',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Depreciacao',
		'Dias',
		'Taxa',
		'Indice',
		'Valor',
		'Depreciacao Acumulada',
	];

	PatrimDepreciacaoBemModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPatrimBem = jsonData['idPatrimBem'];
		dataDepreciacao = jsonData['dataDepreciacao'] != null ? DateTime.tryParse(jsonData['dataDepreciacao']) : null;
		dias = jsonData['dias'];
		taxa = jsonData['taxa']?.toDouble();
		indice = jsonData['indice']?.toDouble();
		valor = jsonData['valor']?.toDouble();
		depreciacaoAcumulada = jsonData['depreciacaoAcumulada']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPatrimBem'] = idPatrimBem != 0 ? idPatrimBem : null;
		jsonData['dataDepreciacao'] = dataDepreciacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataDepreciacao!) : null;
		jsonData['dias'] = dias;
		jsonData['taxa'] = taxa;
		jsonData['indice'] = indice;
		jsonData['valor'] = valor;
		jsonData['depreciacaoAcumulada'] = depreciacaoAcumulada;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPatrimBem = plutoRow.cells['idPatrimBem']?.value;
		dataDepreciacao = Util.stringToDate(plutoRow.cells['dataDepreciacao']?.value);
		dias = plutoRow.cells['dias']?.value;
		taxa = plutoRow.cells['taxa']?.value?.toDouble();
		indice = plutoRow.cells['indice']?.value?.toDouble();
		valor = plutoRow.cells['valor']?.value?.toDouble();
		depreciacaoAcumulada = plutoRow.cells['depreciacaoAcumulada']?.value?.toDouble();
	}	

	PatrimDepreciacaoBemModel clone() {
		return PatrimDepreciacaoBemModel(
			id: id,
			idPatrimBem: idPatrimBem,
			dataDepreciacao: dataDepreciacao,
			dias: dias,
			taxa: taxa,
			indice: indice,
			valor: valor,
			depreciacaoAcumulada: depreciacaoAcumulada,
		);			
	}

	
}