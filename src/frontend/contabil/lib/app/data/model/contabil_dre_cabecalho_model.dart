import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilDreCabecalhoModel {
	int? id;
	String? descricao;
	String? padrao;
	String? periodoInicial;
	String? periodoFinal;
	List<ContabilDreDetalheModel>? contabilDreDetalheModelList;

	ContabilDreCabecalhoModel({
		this.id,
		this.descricao,
		this.padrao,
		this.periodoInicial,
		this.periodoFinal,
		this.contabilDreDetalheModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'padrao',
		'periodo_inicial',
		'periodo_final',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Padrao',
		'Periodo Inicial',
		'Periodo Final',
	];

	ContabilDreCabecalhoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		padrao = ContabilDreCabecalhoDomain.getPadrao(jsonData['padrao']);
		periodoInicial = jsonData['periodoInicial'];
		periodoFinal = jsonData['periodoFinal'];
		contabilDreDetalheModelList = (jsonData['contabilDreDetalheModelList'] as Iterable?)?.map((m) => ContabilDreDetalheModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['padrao'] = ContabilDreCabecalhoDomain.setPadrao(padrao);
		jsonData['periodoInicial'] = Util.removeMask(periodoInicial);
		jsonData['periodoFinal'] = Util.removeMask(periodoFinal);
		
		var contabilDreDetalheModelLocalList = []; 
		for (ContabilDreDetalheModel object in contabilDreDetalheModelList ?? []) { 
			contabilDreDetalheModelLocalList.add(object.toJson); 
		}
		jsonData['contabilDreDetalheModelList'] = contabilDreDetalheModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		padrao = plutoRow.cells['padrao']?.value != '' ? plutoRow.cells['padrao']?.value : 'Sim';
		periodoInicial = plutoRow.cells['periodoInicial']?.value;
		periodoFinal = plutoRow.cells['periodoFinal']?.value;
		contabilDreDetalheModelList = [];
	}	

	ContabilDreCabecalhoModel clone() {
		return ContabilDreCabecalhoModel(
			id: id,
			descricao: descricao,
			padrao: padrao,
			periodoInicial: periodoInicial,
			periodoFinal: periodoFinal,
			contabilDreDetalheModelList: contabilDreDetalheModelListClone(contabilDreDetalheModelList!),
		);			
	}

	contabilDreDetalheModelListClone(List<ContabilDreDetalheModel> contabilDreDetalheModelList) { 
		List<ContabilDreDetalheModel> resultList = [];
		for (var contabilDreDetalheModel in contabilDreDetalheModelList) {
			resultList.add(
				ContabilDreDetalheModel(
					id: contabilDreDetalheModel.id,
					idContabilDreCabecalho: contabilDreDetalheModel.idContabilDreCabecalho,
					classificacao: contabilDreDetalheModel.classificacao,
					descricao: contabilDreDetalheModel.descricao,
					formaCalculo: contabilDreDetalheModel.formaCalculo,
					sinal: contabilDreDetalheModel.sinal,
					natureza: contabilDreDetalheModel.natureza,
					valor: contabilDreDetalheModel.valor,
				)
			);
		}
		return resultList;
	}

	
}