import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class CentroResultadoModel {
	int? id;
	int? idPlanoCentroResultado;
	String? descricao;
	String? classificacao;
	String? sofreRateiro;
	PlanoCentroResultadoModel? planoCentroResultadoModel;
	List<CtResultadoNtFinanceiraModel>? ctResultadoNtFinanceiraModelList;

	CentroResultadoModel({
		this.id,
		this.idPlanoCentroResultado,
		this.descricao,
		this.classificacao,
		this.sofreRateiro,
		this.planoCentroResultadoModel,
		this.ctResultadoNtFinanceiraModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'classificacao',
		'sofre_rateiro',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Classificacao',
		'Sofre Rateiro',
	];

	CentroResultadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPlanoCentroResultado = jsonData['idPlanoCentroResultado'];
		descricao = jsonData['descricao'];
		classificacao = jsonData['classificacao'];
		sofreRateiro = CentroResultadoDomain.getSofreRateiro(jsonData['sofreRateiro']);
		planoCentroResultadoModel = jsonData['planoCentroResultadoModel'] == null ? PlanoCentroResultadoModel() : PlanoCentroResultadoModel.fromJson(jsonData['planoCentroResultadoModel']);
		ctResultadoNtFinanceiraModelList = (jsonData['ctResultadoNtFinanceiraModelList'] as Iterable?)?.map((m) => CtResultadoNtFinanceiraModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPlanoCentroResultado'] = idPlanoCentroResultado != 0 ? idPlanoCentroResultado : null;
		jsonData['descricao'] = descricao;
		jsonData['classificacao'] = classificacao;
		jsonData['sofreRateiro'] = CentroResultadoDomain.setSofreRateiro(sofreRateiro);
		jsonData['planoCentroResultadoModel'] = planoCentroResultadoModel?.toJson;
		
		var ctResultadoNtFinanceiraModelLocalList = []; 
		for (CtResultadoNtFinanceiraModel object in ctResultadoNtFinanceiraModelList ?? []) { 
			ctResultadoNtFinanceiraModelLocalList.add(object.toJson); 
		}
		jsonData['ctResultadoNtFinanceiraModelList'] = ctResultadoNtFinanceiraModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPlanoCentroResultado = plutoRow.cells['idPlanoCentroResultado']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		classificacao = plutoRow.cells['classificacao']?.value;
		sofreRateiro = plutoRow.cells['sofreRateiro']?.value != '' ? plutoRow.cells['sofreRateiro']?.value : 'Sim';
		planoCentroResultadoModel = PlanoCentroResultadoModel();
		planoCentroResultadoModel?.nome = plutoRow.cells['planoCentroResultadoModel']?.value;
		ctResultadoNtFinanceiraModelList = [];
	}	

	CentroResultadoModel clone() {
		return CentroResultadoModel(
			id: id,
			idPlanoCentroResultado: idPlanoCentroResultado,
			descricao: descricao,
			classificacao: classificacao,
			sofreRateiro: sofreRateiro,
			ctResultadoNtFinanceiraModelList: ctResultadoNtFinanceiraModelListClone(ctResultadoNtFinanceiraModelList!),
		);			
	}

	ctResultadoNtFinanceiraModelListClone(List<CtResultadoNtFinanceiraModel> ctResultadoNtFinanceiraModelList) { 
		List<CtResultadoNtFinanceiraModel> resultList = [];
		for (var ctResultadoNtFinanceiraModel in ctResultadoNtFinanceiraModelList) {
			resultList.add(
				CtResultadoNtFinanceiraModel(
					id: ctResultadoNtFinanceiraModel.id,
					idCentroResultado: ctResultadoNtFinanceiraModel.idCentroResultado,
					idFinNaturezaFinanceira: ctResultadoNtFinanceiraModel.idFinNaturezaFinanceira,
					percentualRateio: ctResultadoNtFinanceiraModel.percentualRateio,
				)
			);
		}
		return resultList;
	}

	
}