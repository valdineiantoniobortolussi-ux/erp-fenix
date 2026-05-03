import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/data/model/model_imports.dart';

class RateioCentroResultadoCabModel {
	int? id;
	int? idCentroResultado;
	String? descricao;
	List<RateioCentroResultadoDetModel>? rateioCentroResultadoDetModelList;
	CentroResultadoModel? centroResultadoModel;

	RateioCentroResultadoCabModel({
		this.id,
		this.idCentroResultado,
		this.descricao,
		this.rateioCentroResultadoDetModelList,
		this.centroResultadoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
	];

	RateioCentroResultadoCabModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCentroResultado = jsonData['idCentroResultado'];
		descricao = jsonData['descricao'];
		rateioCentroResultadoDetModelList = (jsonData['rateioCentroResultadoDetModelList'] as Iterable?)?.map((m) => RateioCentroResultadoDetModel.fromJson(m)).toList() ?? [];
		centroResultadoModel = jsonData['centroResultadoModel'] == null ? CentroResultadoModel() : CentroResultadoModel.fromJson(jsonData['centroResultadoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCentroResultado'] = idCentroResultado != 0 ? idCentroResultado : null;
		jsonData['descricao'] = descricao;
		
		var rateioCentroResultadoDetModelLocalList = []; 
		for (RateioCentroResultadoDetModel object in rateioCentroResultadoDetModelList ?? []) { 
			rateioCentroResultadoDetModelLocalList.add(object.toJson); 
		}
		jsonData['rateioCentroResultadoDetModelList'] = rateioCentroResultadoDetModelLocalList;
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
		descricao = plutoRow.cells['descricao']?.value;
		rateioCentroResultadoDetModelList = [];
		centroResultadoModel = CentroResultadoModel();
		centroResultadoModel?.descricao = plutoRow.cells['centroResultadoModel']?.value;
	}	

	RateioCentroResultadoCabModel clone() {
		return RateioCentroResultadoCabModel(
			id: id,
			idCentroResultado: idCentroResultado,
			descricao: descricao,
			rateioCentroResultadoDetModelList: rateioCentroResultadoDetModelListClone(rateioCentroResultadoDetModelList!),
		);			
	}

	rateioCentroResultadoDetModelListClone(List<RateioCentroResultadoDetModel> rateioCentroResultadoDetModelList) { 
		List<RateioCentroResultadoDetModel> resultList = [];
		for (var rateioCentroResultadoDetModel in rateioCentroResultadoDetModelList) {
			resultList.add(
				RateioCentroResultadoDetModel(
					id: rateioCentroResultadoDetModel.id,
					idCentroResultadoDestino: rateioCentroResultadoDetModel.idCentroResultadoDestino,
					idRateioCentroResulCab: rateioCentroResultadoDetModel.idRateioCentroResulCab,
					porcentoRateio: rateioCentroResultadoDetModel.porcentoRateio,
				)
			);
		}
		return resultList;
	}

	
}