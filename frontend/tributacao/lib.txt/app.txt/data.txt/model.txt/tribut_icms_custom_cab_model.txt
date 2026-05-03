import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:tributacao/app/data/model/model_imports.dart';
import 'package:tributacao/app/data/domain/domain_imports.dart';

class TributIcmsCustomCabModel {
	int? id;
	String? descricao;
	String? origemMercadoria;
	List<TributIcmsCustomDetModel>? tributIcmsCustomDetModelList;

	TributIcmsCustomCabModel({
		this.id,
		this.descricao,
		this.origemMercadoria,
		this.tributIcmsCustomDetModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'origem_mercadoria',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Origem Mercadoria',
	];

	TributIcmsCustomCabModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		origemMercadoria = TributIcmsCustomCabDomain.getOrigemMercadoria(jsonData['origemMercadoria']);
		tributIcmsCustomDetModelList = (jsonData['tributIcmsCustomDetModelList'] as Iterable?)?.map((m) => TributIcmsCustomDetModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['origemMercadoria'] = TributIcmsCustomCabDomain.setOrigemMercadoria(origemMercadoria);
		
		var tributIcmsCustomDetModelLocalList = []; 
		for (TributIcmsCustomDetModel object in tributIcmsCustomDetModelList ?? []) { 
			tributIcmsCustomDetModelLocalList.add(object.toJson); 
		}
		jsonData['tributIcmsCustomDetModelList'] = tributIcmsCustomDetModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		origemMercadoria = plutoRow.cells['origemMercadoria']?.value != '' ? plutoRow.cells['origemMercadoria']?.value : '0=Nacional';
		tributIcmsCustomDetModelList = [];
	}	

	TributIcmsCustomCabModel clone() {
		return TributIcmsCustomCabModel(
			id: id,
			descricao: descricao,
			origemMercadoria: origemMercadoria,
			tributIcmsCustomDetModelList: tributIcmsCustomDetModelListClone(tributIcmsCustomDetModelList!),
		);			
	}

	tributIcmsCustomDetModelListClone(List<TributIcmsCustomDetModel> tributIcmsCustomDetModelList) { 
		List<TributIcmsCustomDetModel> resultList = [];
		for (var tributIcmsCustomDetModel in tributIcmsCustomDetModelList) {
			resultList.add(
				TributIcmsCustomDetModel(
					id: tributIcmsCustomDetModel.id,
					idTributIcmsCustomCab: tributIcmsCustomDetModel.idTributIcmsCustomCab,
					ufDestino: tributIcmsCustomDetModel.ufDestino,
					cst: tributIcmsCustomDetModel.cst,
					csosn: tributIcmsCustomDetModel.csosn,
					modalidadeBc: tributIcmsCustomDetModel.modalidadeBc,
					cfop: tributIcmsCustomDetModel.cfop,
					aliquota: tributIcmsCustomDetModel.aliquota,
					valorPauta: tributIcmsCustomDetModel.valorPauta,
					valorPrecoMaximo: tributIcmsCustomDetModel.valorPrecoMaximo,
					mva: tributIcmsCustomDetModel.mva,
					porcentoBc: tributIcmsCustomDetModel.porcentoBc,
					modalidadeBcSt: tributIcmsCustomDetModel.modalidadeBcSt,
					aliquotaInternaSt: tributIcmsCustomDetModel.aliquotaInternaSt,
					aliquotaInterestadualSt: tributIcmsCustomDetModel.aliquotaInterestadualSt,
					porcentoBcSt: tributIcmsCustomDetModel.porcentoBcSt,
					aliquotaIcmsSt: tributIcmsCustomDetModel.aliquotaIcmsSt,
					valorPautaSt: tributIcmsCustomDetModel.valorPautaSt,
					valorPrecoMaximoSt: tributIcmsCustomDetModel.valorPrecoMaximoSt,
				)
			);
		}
		return resultList;
	}

	
}