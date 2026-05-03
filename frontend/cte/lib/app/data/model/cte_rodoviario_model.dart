import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteRodoviarioModel {
	int? id;
	int? idCteCabecalho;
	String? rntrc;
	DateTime? dataPrevistaEntrega;
	String? indicadorLotacao;
	int? ciot;

	CteRodoviarioModel({
		this.id,
		this.idCteCabecalho,
		this.rntrc,
		this.dataPrevistaEntrega,
		this.indicadorLotacao,
		this.ciot,
	});

	static List<String> dbColumns = <String>[
		'id',
		'rntrc',
		'data_prevista_entrega',
		'indicador_lotacao',
		'ciot',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Rntrc',
		'Data Prevista Entrega',
		'Indicador Lotacao',
		'Ciot',
	];

	CteRodoviarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		rntrc = jsonData['rntrc'];
		dataPrevistaEntrega = jsonData['dataPrevistaEntrega'] != null ? DateTime.tryParse(jsonData['dataPrevistaEntrega']) : null;
		indicadorLotacao = CteRodoviarioDomain.getIndicadorLotacao(jsonData['indicadorLotacao']);
		ciot = jsonData['ciot'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['rntrc'] = rntrc;
		jsonData['dataPrevistaEntrega'] = dataPrevistaEntrega != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevistaEntrega!) : null;
		jsonData['indicadorLotacao'] = CteRodoviarioDomain.setIndicadorLotacao(indicadorLotacao);
		jsonData['ciot'] = ciot;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		rntrc = plutoRow.cells['rntrc']?.value;
		dataPrevistaEntrega = Util.stringToDate(plutoRow.cells['dataPrevistaEntrega']?.value);
		indicadorLotacao = plutoRow.cells['indicadorLotacao']?.value != '' ? plutoRow.cells['indicadorLotacao']?.value : 'AAA';
		ciot = plutoRow.cells['ciot']?.value;
	}	

	CteRodoviarioModel clone() {
		return CteRodoviarioModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			rntrc: rntrc,
			dataPrevistaEntrega: dataPrevistaEntrega,
			indicadorLotacao: indicadorLotacao,
			ciot: ciot,
		);			
	}

	
}