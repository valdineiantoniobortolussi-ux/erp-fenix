import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalLivroModel {
	int? id;
	String? descricao;
	List<FiscalTermoModel>? fiscalTermoModelList;

	FiscalLivroModel({
		this.id,
		this.descricao,
		this.fiscalTermoModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
	];

	FiscalLivroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		fiscalTermoModelList = (jsonData['fiscalTermoModelList'] as Iterable?)?.map((m) => FiscalTermoModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		
		var fiscalTermoModelLocalList = []; 
		for (FiscalTermoModel object in fiscalTermoModelList ?? []) { 
			fiscalTermoModelLocalList.add(object.toJson); 
		}
		jsonData['fiscalTermoModelList'] = fiscalTermoModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		fiscalTermoModelList = [];
	}	

	FiscalLivroModel clone() {
		return FiscalLivroModel(
			id: id,
			descricao: descricao,
			fiscalTermoModelList: fiscalTermoModelListClone(fiscalTermoModelList!),
		);			
	}

	fiscalTermoModelListClone(List<FiscalTermoModel> fiscalTermoModelList) { 
		List<FiscalTermoModel> resultList = [];
		for (var fiscalTermoModel in fiscalTermoModelList) {
			resultList.add(
				FiscalTermoModel(
					id: fiscalTermoModel.id,
					idFiscalLivro: fiscalTermoModel.idFiscalLivro,
					aberturaEncerramento: fiscalTermoModel.aberturaEncerramento,
					numero: fiscalTermoModel.numero,
					paginaInicial: fiscalTermoModel.paginaInicial,
					paginaFinal: fiscalTermoModel.paginaFinal,
					numeroRegistro: fiscalTermoModel.numeroRegistro,
					registrado: fiscalTermoModel.registrado,
					dataDespacho: fiscalTermoModel.dataDespacho,
					dataAbertura: fiscalTermoModel.dataAbertura,
					dataEncerramento: fiscalTermoModel.dataEncerramento,
					escrituracaoInicio: fiscalTermoModel.escrituracaoInicio,
					escrituracaoFim: fiscalTermoModel.escrituracaoFim,
					texto: fiscalTermoModel.texto,
				)
			);
		}
		return resultList;
	}

	
}