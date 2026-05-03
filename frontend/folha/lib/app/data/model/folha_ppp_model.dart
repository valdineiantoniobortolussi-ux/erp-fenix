import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/data/model/model_imports.dart';

class FolhaPppModel {
	int? id;
	int? idColaborador;
	String? observacao;
	List<FolhaPppCatModel>? folhaPppCatModelList;
	List<FolhaPppAtividadeModel>? folhaPppAtividadeModelList;
	List<FolhaPppFatorRiscoModel>? folhaPppFatorRiscoModelList;
	List<FolhaPppExameMedicoModel>? folhaPppExameMedicoModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	FolhaPppModel({
		this.id,
		this.idColaborador,
		this.observacao,
		this.folhaPppCatModelList,
		this.folhaPppAtividadeModelList,
		this.folhaPppFatorRiscoModelList,
		this.folhaPppExameMedicoModelList,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Observacao',
	];

	FolhaPppModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		observacao = jsonData['observacao'];
		folhaPppCatModelList = (jsonData['folhaPppCatModelList'] as Iterable?)?.map((m) => FolhaPppCatModel.fromJson(m)).toList() ?? [];
		folhaPppAtividadeModelList = (jsonData['folhaPppAtividadeModelList'] as Iterable?)?.map((m) => FolhaPppAtividadeModel.fromJson(m)).toList() ?? [];
		folhaPppFatorRiscoModelList = (jsonData['folhaPppFatorRiscoModelList'] as Iterable?)?.map((m) => FolhaPppFatorRiscoModel.fromJson(m)).toList() ?? [];
		folhaPppExameMedicoModelList = (jsonData['folhaPppExameMedicoModelList'] as Iterable?)?.map((m) => FolhaPppExameMedicoModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['observacao'] = observacao;
		
		var folhaPppCatModelLocalList = []; 
		for (FolhaPppCatModel object in folhaPppCatModelList ?? []) { 
			folhaPppCatModelLocalList.add(object.toJson); 
		}
		jsonData['folhaPppCatModelList'] = folhaPppCatModelLocalList;
		
		var folhaPppAtividadeModelLocalList = []; 
		for (FolhaPppAtividadeModel object in folhaPppAtividadeModelList ?? []) { 
			folhaPppAtividadeModelLocalList.add(object.toJson); 
		}
		jsonData['folhaPppAtividadeModelList'] = folhaPppAtividadeModelLocalList;
		
		var folhaPppFatorRiscoModelLocalList = []; 
		for (FolhaPppFatorRiscoModel object in folhaPppFatorRiscoModelList ?? []) { 
			folhaPppFatorRiscoModelLocalList.add(object.toJson); 
		}
		jsonData['folhaPppFatorRiscoModelList'] = folhaPppFatorRiscoModelLocalList;
		
		var folhaPppExameMedicoModelLocalList = []; 
		for (FolhaPppExameMedicoModel object in folhaPppExameMedicoModelList ?? []) { 
			folhaPppExameMedicoModelLocalList.add(object.toJson); 
		}
		jsonData['folhaPppExameMedicoModelList'] = folhaPppExameMedicoModelLocalList;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		observacao = plutoRow.cells['observacao']?.value;
		folhaPppCatModelList = [];
		folhaPppAtividadeModelList = [];
		folhaPppFatorRiscoModelList = [];
		folhaPppExameMedicoModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	FolhaPppModel clone() {
		return FolhaPppModel(
			id: id,
			idColaborador: idColaborador,
			observacao: observacao,
			folhaPppCatModelList: folhaPppCatModelListClone(folhaPppCatModelList!),
			folhaPppAtividadeModelList: folhaPppAtividadeModelListClone(folhaPppAtividadeModelList!),
			folhaPppFatorRiscoModelList: folhaPppFatorRiscoModelListClone(folhaPppFatorRiscoModelList!),
			folhaPppExameMedicoModelList: folhaPppExameMedicoModelListClone(folhaPppExameMedicoModelList!),
		);			
	}

	folhaPppCatModelListClone(List<FolhaPppCatModel> folhaPppCatModelList) { 
		List<FolhaPppCatModel> resultList = [];
		for (var folhaPppCatModel in folhaPppCatModelList) {
			resultList.add(
				FolhaPppCatModel(
					id: folhaPppCatModel.id,
					idFolhaPpp: folhaPppCatModel.idFolhaPpp,
					numeroCat: folhaPppCatModel.numeroCat,
					dataAfastamento: folhaPppCatModel.dataAfastamento,
					dataRegistro: folhaPppCatModel.dataRegistro,
				)
			);
		}
		return resultList;
	}

	folhaPppAtividadeModelListClone(List<FolhaPppAtividadeModel> folhaPppAtividadeModelList) { 
		List<FolhaPppAtividadeModel> resultList = [];
		for (var folhaPppAtividadeModel in folhaPppAtividadeModelList) {
			resultList.add(
				FolhaPppAtividadeModel(
					id: folhaPppAtividadeModel.id,
					idFolhaPpp: folhaPppAtividadeModel.idFolhaPpp,
					dataInicio: folhaPppAtividadeModel.dataInicio,
					dataFim: folhaPppAtividadeModel.dataFim,
					descricao: folhaPppAtividadeModel.descricao,
				)
			);
		}
		return resultList;
	}

	folhaPppFatorRiscoModelListClone(List<FolhaPppFatorRiscoModel> folhaPppFatorRiscoModelList) { 
		List<FolhaPppFatorRiscoModel> resultList = [];
		for (var folhaPppFatorRiscoModel in folhaPppFatorRiscoModelList) {
			resultList.add(
				FolhaPppFatorRiscoModel(
					id: folhaPppFatorRiscoModel.id,
					idFolhaPpp: folhaPppFatorRiscoModel.idFolhaPpp,
					dataInicio: folhaPppFatorRiscoModel.dataInicio,
					dataFim: folhaPppFatorRiscoModel.dataFim,
					tipo: folhaPppFatorRiscoModel.tipo,
					fatorRisco: folhaPppFatorRiscoModel.fatorRisco,
					intensidade: folhaPppFatorRiscoModel.intensidade,
					tecnicaUtilizada: folhaPppFatorRiscoModel.tecnicaUtilizada,
					epcEficaz: folhaPppFatorRiscoModel.epcEficaz,
					epiEficaz: folhaPppFatorRiscoModel.epiEficaz,
					caEpi: folhaPppFatorRiscoModel.caEpi,
					atendimentoNr061: folhaPppFatorRiscoModel.atendimentoNr061,
					atendimentoNr062: folhaPppFatorRiscoModel.atendimentoNr062,
					atendimentoNr063: folhaPppFatorRiscoModel.atendimentoNr063,
					atendimentoNr064: folhaPppFatorRiscoModel.atendimentoNr064,
					atendimentoNr065: folhaPppFatorRiscoModel.atendimentoNr065,
				)
			);
		}
		return resultList;
	}

	folhaPppExameMedicoModelListClone(List<FolhaPppExameMedicoModel> folhaPppExameMedicoModelList) { 
		List<FolhaPppExameMedicoModel> resultList = [];
		for (var folhaPppExameMedicoModel in folhaPppExameMedicoModelList) {
			resultList.add(
				FolhaPppExameMedicoModel(
					id: folhaPppExameMedicoModel.id,
					idFolhaPpp: folhaPppExameMedicoModel.idFolhaPpp,
					dataUltimo: folhaPppExameMedicoModel.dataUltimo,
					tipo: folhaPppExameMedicoModel.tipo,
					exame: folhaPppExameMedicoModel.exame,
					natureza: folhaPppExameMedicoModel.natureza,
					indicacaoResultados: folhaPppExameMedicoModel.indicacaoResultados,
				)
			);
		}
		return resultList;
	}

	
}