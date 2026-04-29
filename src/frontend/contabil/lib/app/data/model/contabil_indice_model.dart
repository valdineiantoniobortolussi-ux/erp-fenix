import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilIndiceModel {
	int? id;
	String? indice;
	String? periodicidade;
	DateTime? diarioAPartirDe;
	String? mensalMesAno;
	List<ContabilIndiceValorModel>? contabilIndiceValorModelList;

	ContabilIndiceModel({
		this.id,
		this.indice,
		this.periodicidade,
		this.diarioAPartirDe,
		this.mensalMesAno,
		this.contabilIndiceValorModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'indice',
		'periodicidade',
		'diario_a_partir_de',
		'mensal_mes_ano',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Indice',
		'Periodicidade',
		'Diario A Partir De',
		'Mensal Mes Ano',
	];

	ContabilIndiceModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		indice = jsonData['indice'];
		periodicidade = ContabilIndiceDomain.getPeriodicidade(jsonData['periodicidade']);
		diarioAPartirDe = jsonData['diarioAPartirDe'] != null ? DateTime.tryParse(jsonData['diarioAPartirDe']) : null;
		mensalMesAno = jsonData['mensalMesAno'];
		contabilIndiceValorModelList = (jsonData['contabilIndiceValorModelList'] as Iterable?)?.map((m) => ContabilIndiceValorModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['indice'] = indice;
		jsonData['periodicidade'] = ContabilIndiceDomain.setPeriodicidade(periodicidade);
		jsonData['diarioAPartirDe'] = diarioAPartirDe != null ? DateFormat('yyyy-MM-ddT00:00:00').format(diarioAPartirDe!) : null;
		jsonData['mensalMesAno'] = Util.removeMask(mensalMesAno);
		
		var contabilIndiceValorModelLocalList = []; 
		for (ContabilIndiceValorModel object in contabilIndiceValorModelList ?? []) { 
			contabilIndiceValorModelLocalList.add(object.toJson); 
		}
		jsonData['contabilIndiceValorModelList'] = contabilIndiceValorModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		indice = plutoRow.cells['indice']?.value;
		periodicidade = plutoRow.cells['periodicidade']?.value != '' ? plutoRow.cells['periodicidade']?.value : 'Diário';
		diarioAPartirDe = Util.stringToDate(plutoRow.cells['diarioAPartirDe']?.value);
		mensalMesAno = plutoRow.cells['mensalMesAno']?.value;
		contabilIndiceValorModelList = [];
	}	

	ContabilIndiceModel clone() {
		return ContabilIndiceModel(
			id: id,
			indice: indice,
			periodicidade: periodicidade,
			diarioAPartirDe: diarioAPartirDe,
			mensalMesAno: mensalMesAno,
			contabilIndiceValorModelList: contabilIndiceValorModelListClone(contabilIndiceValorModelList!),
		);			
	}

	contabilIndiceValorModelListClone(List<ContabilIndiceValorModel> contabilIndiceValorModelList) { 
		List<ContabilIndiceValorModel> resultList = [];
		for (var contabilIndiceValorModel in contabilIndiceValorModelList) {
			resultList.add(
				ContabilIndiceValorModel(
					id: contabilIndiceValorModel.id,
					idContabilIndice: contabilIndiceValorModel.idContabilIndice,
					dataIndice: contabilIndiceValorModel.dataIndice,
					valor: contabilIndiceValorModel.valor,
				)
			);
		}
		return resultList;
	}

	
}