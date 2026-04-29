import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/data/model/model_imports.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class EmpresaTransporteModel {
	int? id;
	String? nome;
	String? uf;
	String? classificacaoContabilConta;
	List<EmpresaTransporteItinerarioModel>? empresaTransporteItinerarioModelList;

	EmpresaTransporteModel({
		this.id,
		this.nome,
		this.uf,
		this.classificacaoContabilConta,
		this.empresaTransporteItinerarioModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'uf',
		'classificacao_contabil_conta',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Uf',
		'Classificacao Contabil Conta',
	];

	EmpresaTransporteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		uf = EmpresaTransporteDomain.getUf(jsonData['uf']);
		classificacaoContabilConta = jsonData['classificacaoContabilConta'];
		empresaTransporteItinerarioModelList = (jsonData['empresaTransporteItinerarioModelList'] as Iterable?)?.map((m) => EmpresaTransporteItinerarioModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['uf'] = EmpresaTransporteDomain.setUf(uf);
		jsonData['classificacaoContabilConta'] = classificacaoContabilConta;
		
		var empresaTransporteItinerarioModelLocalList = []; 
		for (EmpresaTransporteItinerarioModel object in empresaTransporteItinerarioModelList ?? []) { 
			empresaTransporteItinerarioModelLocalList.add(object.toJson); 
		}
		jsonData['empresaTransporteItinerarioModelList'] = empresaTransporteItinerarioModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		classificacaoContabilConta = plutoRow.cells['classificacaoContabilConta']?.value;
		empresaTransporteItinerarioModelList = [];
	}	

	EmpresaTransporteModel clone() {
		return EmpresaTransporteModel(
			id: id,
			nome: nome,
			uf: uf,
			classificacaoContabilConta: classificacaoContabilConta,
			empresaTransporteItinerarioModelList: empresaTransporteItinerarioModelListClone(empresaTransporteItinerarioModelList!),
		);			
	}

	empresaTransporteItinerarioModelListClone(List<EmpresaTransporteItinerarioModel> empresaTransporteItinerarioModelList) { 
		List<EmpresaTransporteItinerarioModel> resultList = [];
		for (var empresaTransporteItinerarioModel in empresaTransporteItinerarioModelList) {
			resultList.add(
				EmpresaTransporteItinerarioModel(
					id: empresaTransporteItinerarioModel.id,
					idEmpresaTransporte: empresaTransporteItinerarioModel.idEmpresaTransporte,
					nome: empresaTransporteItinerarioModel.nome,
					tarifa: empresaTransporteItinerarioModel.tarifa,
					trajeto: empresaTransporteItinerarioModel.trajeto,
				)
			);
		}
		return resultList;
	}

	
}