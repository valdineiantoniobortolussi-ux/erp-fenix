import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:contabil/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class ContabilEncerramentoExeCabModel {
	int? id;
	DateTime? dataInicio;
	DateTime? dataFim;
	DateTime? dataInclusao;
	String? motivo;
	List<ContabilEncerramentoExeDetModel>? contabilEncerramentoExeDetModelList;

	ContabilEncerramentoExeCabModel({
		this.id,
		this.dataInicio,
		this.dataFim,
		this.dataInclusao,
		this.motivo,
		this.contabilEncerramentoExeDetModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'data_inclusao',
		'motivo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Data Inclusao',
		'Motivo',
	];

	ContabilEncerramentoExeCabModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
		motivo = jsonData['motivo'];
		contabilEncerramentoExeDetModelList = (jsonData['contabilEncerramentoExeDetModelList'] as Iterable?)?.map((m) => ContabilEncerramentoExeDetModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
		jsonData['motivo'] = motivo;
		
		var contabilEncerramentoExeDetModelLocalList = []; 
		for (ContabilEncerramentoExeDetModel object in contabilEncerramentoExeDetModelList ?? []) { 
			contabilEncerramentoExeDetModelLocalList.add(object.toJson); 
		}
		jsonData['contabilEncerramentoExeDetModelList'] = contabilEncerramentoExeDetModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
		motivo = plutoRow.cells['motivo']?.value;
		contabilEncerramentoExeDetModelList = [];
	}	

	ContabilEncerramentoExeCabModel clone() {
		return ContabilEncerramentoExeCabModel(
			id: id,
			dataInicio: dataInicio,
			dataFim: dataFim,
			dataInclusao: dataInclusao,
			motivo: motivo,
			contabilEncerramentoExeDetModelList: contabilEncerramentoExeDetModelListClone(contabilEncerramentoExeDetModelList!),
		);			
	}

	contabilEncerramentoExeDetModelListClone(List<ContabilEncerramentoExeDetModel> contabilEncerramentoExeDetModelList) { 
		List<ContabilEncerramentoExeDetModel> resultList = [];
		for (var contabilEncerramentoExeDetModel in contabilEncerramentoExeDetModelList) {
			resultList.add(
				ContabilEncerramentoExeDetModel(
					id: contabilEncerramentoExeDetModel.id,
					idContabilEncerramentoExe: contabilEncerramentoExeDetModel.idContabilEncerramentoExe,
					idContabilConta: contabilEncerramentoExeDetModel.idContabilConta,
					saldoAnterior: contabilEncerramentoExeDetModel.saldoAnterior,
					valorDebito: contabilEncerramentoExeDetModel.valorDebito,
					valorCredito: contabilEncerramentoExeDetModel.valorCredito,
					saldo: contabilEncerramentoExeDetModel.saldo,
				)
			);
		}
		return resultList;
	}

	
}