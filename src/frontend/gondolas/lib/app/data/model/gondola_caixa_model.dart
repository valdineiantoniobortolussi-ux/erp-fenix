import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:gondolas/app/data/model/model_imports.dart';

class GondolaCaixaModel {
	int? id;
	int? idGondolaEstante;
	String? codigo;
	int? altura;
	int? largura;
	int? profundidade;
	List<GondolaArmazenamentoModel>? gondolaArmazenamentoModelList;
	GondolaEstanteModel? gondolaEstanteModel;

	GondolaCaixaModel({
		this.id,
		this.idGondolaEstante,
		this.codigo,
		this.altura,
		this.largura,
		this.profundidade,
		this.gondolaArmazenamentoModelList,
		this.gondolaEstanteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'altura',
		'largura',
		'profundidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Altura',
		'Largura',
		'Profundidade',
	];

	GondolaCaixaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idGondolaEstante = jsonData['idGondolaEstante'];
		codigo = jsonData['codigo'];
		altura = jsonData['altura'];
		largura = jsonData['largura'];
		profundidade = jsonData['profundidade'];
		gondolaArmazenamentoModelList = (jsonData['gondolaArmazenamentoModelList'] as Iterable?)?.map((m) => GondolaArmazenamentoModel.fromJson(m)).toList() ?? [];
		gondolaEstanteModel = jsonData['gondolaEstanteModel'] == null ? GondolaEstanteModel() : GondolaEstanteModel.fromJson(jsonData['gondolaEstanteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idGondolaEstante'] = idGondolaEstante != 0 ? idGondolaEstante : null;
		jsonData['codigo'] = codigo;
		jsonData['altura'] = altura;
		jsonData['largura'] = largura;
		jsonData['profundidade'] = profundidade;
		
		var gondolaArmazenamentoModelLocalList = []; 
		for (GondolaArmazenamentoModel object in gondolaArmazenamentoModelList ?? []) { 
			gondolaArmazenamentoModelLocalList.add(object.toJson); 
		}
		jsonData['gondolaArmazenamentoModelList'] = gondolaArmazenamentoModelLocalList;
		jsonData['gondolaEstanteModel'] = gondolaEstanteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idGondolaEstante = plutoRow.cells['idGondolaEstante']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		altura = plutoRow.cells['altura']?.value;
		largura = plutoRow.cells['largura']?.value;
		profundidade = plutoRow.cells['profundidade']?.value;
		gondolaArmazenamentoModelList = [];
		gondolaEstanteModel = GondolaEstanteModel();
		gondolaEstanteModel?.codigo = plutoRow.cells['gondolaEstanteModel']?.value;
	}	

	GondolaCaixaModel clone() {
		return GondolaCaixaModel(
			id: id,
			idGondolaEstante: idGondolaEstante,
			codigo: codigo,
			altura: altura,
			largura: largura,
			profundidade: profundidade,
			gondolaArmazenamentoModelList: gondolaArmazenamentoModelListClone(gondolaArmazenamentoModelList!),
		);			
	}

	gondolaArmazenamentoModelListClone(List<GondolaArmazenamentoModel> gondolaArmazenamentoModelList) { 
		List<GondolaArmazenamentoModel> resultList = [];
		for (var gondolaArmazenamentoModel in gondolaArmazenamentoModelList) {
			resultList.add(
				GondolaArmazenamentoModel(
					id: gondolaArmazenamentoModel.id,
					idGondolaCaixa: gondolaArmazenamentoModel.idGondolaCaixa,
					idProduto: gondolaArmazenamentoModel.idProduto,
					quantidade: gondolaArmazenamentoModel.quantidade,
				)
			);
		}
		return resultList;
	}

	
}