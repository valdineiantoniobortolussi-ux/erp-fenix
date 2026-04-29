import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:patrimonio/app/data/domain/domain_imports.dart';

class CentroResultadoModel {
	int? id;
	int? idPlanoCentroResultado;
	String? classificacao;
	String? descricao;
	String? sofreRateiro;

	CentroResultadoModel({
		this.id,
		this.idPlanoCentroResultado,
		this.classificacao,
		this.descricao,
		this.sofreRateiro,
	});

	static List<String> dbColumns = <String>[
		'id',
		'id_plano_centro_resultado',
		'classificacao',
		'descricao',
		'sofre_rateiro',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Id Plano Centro Resultado',
		'Classificacao',
		'Descricao',
		'Sofre Rateiro',
	];

	CentroResultadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPlanoCentroResultado = jsonData['idPlanoCentroResultado'];
		classificacao = jsonData['classificacao'];
		descricao = jsonData['descricao'];
		sofreRateiro = CentroResultadoDomain.getSofreRateiro(jsonData['sofreRateiro']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPlanoCentroResultado'] = idPlanoCentroResultado;
		jsonData['classificacao'] = classificacao;
		jsonData['descricao'] = descricao;
		jsonData['sofreRateiro'] = CentroResultadoDomain.setSofreRateiro(sofreRateiro);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPlanoCentroResultado = plutoRow.cells['idPlanoCentroResultado']?.value;
		classificacao = plutoRow.cells['classificacao']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		sofreRateiro = plutoRow.cells['sofreRateiro']?.value != '' ? plutoRow.cells['sofreRateiro']?.value : 'AAA';
	}	

	CentroResultadoModel clone() {
		return CentroResultadoModel(
			id: id,
			idPlanoCentroResultado: idPlanoCentroResultado,
			classificacao: classificacao,
			descricao: descricao,
			sofreRateiro: sofreRateiro,
		);			
	}

	
}