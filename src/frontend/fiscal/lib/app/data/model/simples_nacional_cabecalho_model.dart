import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class SimplesNacionalCabecalhoModel {
	int? id;
	DateTime? vigenciaInicial;
	DateTime? vigenciaFinal;
	String? anexo;
	String? tabela;
	List<SimplesNacionalDetalheModel>? simplesNacionalDetalheModelList;

	SimplesNacionalCabecalhoModel({
		this.id,
		this.vigenciaInicial,
		this.vigenciaFinal,
		this.anexo,
		this.tabela,
		this.simplesNacionalDetalheModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'vigencia_inicial',
		'vigencia_final',
		'anexo',
		'tabela',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Vigencia Inicial',
		'Vigencia Final',
		'Anexo',
		'Tabela',
	];

	SimplesNacionalCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		vigenciaInicial = jsonData['vigenciaInicial'] != null ? DateTime.tryParse(jsonData['vigenciaInicial']) : null;
		vigenciaFinal = jsonData['vigenciaFinal'] != null ? DateTime.tryParse(jsonData['vigenciaFinal']) : null;
		anexo = jsonData['anexo'];
		tabela = jsonData['tabela'];
		simplesNacionalDetalheModelList = (jsonData['simplesNacionalDetalheModelList'] as Iterable?)?.map((m) => SimplesNacionalDetalheModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['vigenciaInicial'] = vigenciaInicial != null ? DateFormat('yyyy-MM-ddT00:00:00').format(vigenciaInicial!) : null;
		jsonData['vigenciaFinal'] = vigenciaFinal != null ? DateFormat('yyyy-MM-ddT00:00:00').format(vigenciaFinal!) : null;
		jsonData['anexo'] = anexo;
		jsonData['tabela'] = tabela;
		
		var simplesNacionalDetalheModelLocalList = []; 
		for (SimplesNacionalDetalheModel object in simplesNacionalDetalheModelList ?? []) { 
			simplesNacionalDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['simplesNacionalDetalheModelList'] = simplesNacionalDetalheModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		vigenciaInicial = Util.stringToDate(plutoRow.cells['vigenciaInicial']?.value);
		vigenciaFinal = Util.stringToDate(plutoRow.cells['vigenciaFinal']?.value);
		anexo = plutoRow.cells['anexo']?.value;
		tabela = plutoRow.cells['tabela']?.value;
		simplesNacionalDetalheModelList = [];
	}	

	SimplesNacionalCabecalhoModel clone() {
		return SimplesNacionalCabecalhoModel(
			id: id,
			vigenciaInicial: vigenciaInicial,
			vigenciaFinal: vigenciaFinal,
			anexo: anexo,
			tabela: tabela,
			simplesNacionalDetalheModelList: simplesNacionalDetalheModelListClone(simplesNacionalDetalheModelList!),
		);			
	}

	simplesNacionalDetalheModelListClone(List<SimplesNacionalDetalheModel> simplesNacionalDetalheModelList) { 
		List<SimplesNacionalDetalheModel> resultList = [];
		for (var simplesNacionalDetalheModel in simplesNacionalDetalheModelList) {
			resultList.add(
				SimplesNacionalDetalheModel(
					id: simplesNacionalDetalheModel.id,
					idSimplesNacionalCabecalho: simplesNacionalDetalheModel.idSimplesNacionalCabecalho,
					faixa: simplesNacionalDetalheModel.faixa,
					valorInicial: simplesNacionalDetalheModel.valorInicial,
					valorFinal: simplesNacionalDetalheModel.valorFinal,
					aliquota: simplesNacionalDetalheModel.aliquota,
					irpj: simplesNacionalDetalheModel.irpj,
					csll: simplesNacionalDetalheModel.csll,
					cofins: simplesNacionalDetalheModel.cofins,
					pisPasep: simplesNacionalDetalheModel.pisPasep,
					cpp: simplesNacionalDetalheModel.cpp,
					icms: simplesNacionalDetalheModel.icms,
					ipi: simplesNacionalDetalheModel.ipi,
					iss: simplesNacionalDetalheModel.iss,
				)
			);
		}
		return resultList;
	}

	
}