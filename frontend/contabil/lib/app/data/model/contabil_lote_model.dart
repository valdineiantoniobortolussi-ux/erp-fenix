import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class ContabilLoteModel {
	int? id;
	String? descricao;
	DateTime? dataInclusao;
	DateTime? dataLiberacao;
	String? liberado;
	String? programado;
	double? valor;

	ContabilLoteModel({
		this.id,
		this.descricao,
		this.dataInclusao,
		this.dataLiberacao,
		this.liberado,
		this.programado,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'data_inclusao',
		'data_liberacao',
		'liberado',
		'programado',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Data Inclusao',
		'Data Liberacao',
		'Liberado',
		'Programado',
		'Valor',
	];

	ContabilLoteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		dataInclusao = jsonData['dataInclusao'] != null ? DateTime.tryParse(jsonData['dataInclusao']) : null;
		dataLiberacao = jsonData['dataLiberacao'] != null ? DateTime.tryParse(jsonData['dataLiberacao']) : null;
		liberado = ContabilLoteDomain.getLiberado(jsonData['liberado']);
		programado = ContabilLoteDomain.getProgramado(jsonData['programado']);
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['dataInclusao'] = dataInclusao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInclusao!) : null;
		jsonData['dataLiberacao'] = dataLiberacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataLiberacao!) : null;
		jsonData['liberado'] = ContabilLoteDomain.setLiberado(liberado);
		jsonData['programado'] = ContabilLoteDomain.setProgramado(programado);
		jsonData['valor'] = valor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		dataInclusao = Util.stringToDate(plutoRow.cells['dataInclusao']?.value);
		dataLiberacao = Util.stringToDate(plutoRow.cells['dataLiberacao']?.value);
		liberado = plutoRow.cells['liberado']?.value != '' ? plutoRow.cells['liberado']?.value : 'Sim';
		programado = plutoRow.cells['programado']?.value != '' ? plutoRow.cells['programado']?.value : 'Sim';
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	ContabilLoteModel clone() {
		return ContabilLoteModel(
			id: id,
			descricao: descricao,
			dataInclusao: dataInclusao,
			dataLiberacao: dataLiberacao,
			liberado: liberado,
			programado: programado,
			valor: valor,
		);			
	}

	
}