import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/data/model/model_imports.dart';
import 'package:financeiro/app/data/domain/domain_imports.dart';

class TalonarioChequeModel {
	int? id;
	int? idBancoContaCaixa;
	String? talao;
	int? numero;
	String? statusTalao;
	List<ChequeModel>? chequeModelList;
	BancoContaCaixaModel? bancoContaCaixaModel;

	TalonarioChequeModel({
		this.id,
		this.idBancoContaCaixa,
		this.talao,
		this.numero,
		this.statusTalao,
		this.chequeModelList,
		this.bancoContaCaixaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'talao',
		'numero',
		'status_talao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Talao',
		'Numero',
		'Status Talao',
	];

	TalonarioChequeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBancoContaCaixa = jsonData['idBancoContaCaixa'];
		talao = jsonData['talao'];
		numero = jsonData['numero'];
		statusTalao = TalonarioChequeDomain.getStatusTalao(jsonData['statusTalao']);
		chequeModelList = (jsonData['chequeModelList'] as Iterable?)?.map((m) => ChequeModel.fromJson(m)).toList() ?? [];
		bancoContaCaixaModel = jsonData['bancoContaCaixaModel'] == null ? BancoContaCaixaModel() : BancoContaCaixaModel.fromJson(jsonData['bancoContaCaixaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idBancoContaCaixa'] = idBancoContaCaixa != 0 ? idBancoContaCaixa : null;
		jsonData['talao'] = talao;
		jsonData['numero'] = numero;
		jsonData['statusTalao'] = TalonarioChequeDomain.setStatusTalao(statusTalao);
		
		var chequeModelLocalList = []; 
		for (ChequeModel object in chequeModelList ?? []) { 
			chequeModelLocalList.add(object.toJson); 
		}
		jsonData['chequeModelList'] = chequeModelLocalList;
		jsonData['bancoContaCaixaModel'] = bancoContaCaixaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idBancoContaCaixa = plutoRow.cells['idBancoContaCaixa']?.value;
		talao = plutoRow.cells['talao']?.value;
		numero = plutoRow.cells['numero']?.value;
		statusTalao = plutoRow.cells['statusTalao']?.value != '' ? plutoRow.cells['statusTalao']?.value : 'Normal';
		chequeModelList = [];
		bancoContaCaixaModel = BancoContaCaixaModel();
		bancoContaCaixaModel?.nome = plutoRow.cells['bancoContaCaixaModel']?.value;
	}	

	TalonarioChequeModel clone() {
		return TalonarioChequeModel(
			id: id,
			idBancoContaCaixa: idBancoContaCaixa,
			talao: talao,
			numero: numero,
			statusTalao: statusTalao,
			chequeModelList: chequeModelListClone(chequeModelList!),
		);			
	}

	chequeModelListClone(List<ChequeModel> chequeModelList) { 
		List<ChequeModel> resultList = [];
		for (var chequeModel in chequeModelList) {
			resultList.add(
				ChequeModel(
					id: chequeModel.id,
					idTalonarioCheque: chequeModel.idTalonarioCheque,
					numero: chequeModel.numero,
					statusCheque: chequeModel.statusCheque,
					dataStatus: chequeModel.dataStatus,
				)
			);
		}
		return resultList;
	}

	
}