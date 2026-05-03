import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FolhaFeriasColetivasModel {
	int? id;
	DateTime? dataInicio;
	DateTime? dataFim;
	int? diasGozo;
	DateTime? abonoPecuniarioInicio;
	DateTime? abonoPecuniarioFim;
	int? diasAbono;
	DateTime? dataPagamento;

	FolhaFeriasColetivasModel({
		this.id,
		this.dataInicio,
		this.dataFim,
		this.diasGozo,
		this.abonoPecuniarioInicio,
		this.abonoPecuniarioFim,
		this.diasAbono,
		this.dataPagamento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_inicio',
		'data_fim',
		'dias_gozo',
		'abono_pecuniario_inicio',
		'abono_pecuniario_fim',
		'dias_abono',
		'data_pagamento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Inicio',
		'Data Fim',
		'Dias Gozo',
		'Abono Pecuniario Inicio',
		'Abono Pecuniario Fim',
		'Dias Abono',
		'Data Pagamento',
	];

	FolhaFeriasColetivasModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		diasGozo = jsonData['diasGozo'];
		abonoPecuniarioInicio = jsonData['abonoPecuniarioInicio'] != null ? DateTime.tryParse(jsonData['abonoPecuniarioInicio']) : null;
		abonoPecuniarioFim = jsonData['abonoPecuniarioFim'] != null ? DateTime.tryParse(jsonData['abonoPecuniarioFim']) : null;
		diasAbono = jsonData['diasAbono'];
		dataPagamento = jsonData['dataPagamento'] != null ? DateTime.tryParse(jsonData['dataPagamento']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['diasGozo'] = diasGozo;
		jsonData['abonoPecuniarioInicio'] = abonoPecuniarioInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(abonoPecuniarioInicio!) : null;
		jsonData['abonoPecuniarioFim'] = abonoPecuniarioFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(abonoPecuniarioFim!) : null;
		jsonData['diasAbono'] = diasAbono;
		jsonData['dataPagamento'] = dataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPagamento!) : null;
	
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
		diasGozo = plutoRow.cells['diasGozo']?.value;
		abonoPecuniarioInicio = Util.stringToDate(plutoRow.cells['abonoPecuniarioInicio']?.value);
		abonoPecuniarioFim = Util.stringToDate(plutoRow.cells['abonoPecuniarioFim']?.value);
		diasAbono = plutoRow.cells['diasAbono']?.value;
		dataPagamento = Util.stringToDate(plutoRow.cells['dataPagamento']?.value);
	}	

	FolhaFeriasColetivasModel clone() {
		return FolhaFeriasColetivasModel(
			id: id,
			dataInicio: dataInicio,
			dataFim: dataFim,
			diasGozo: diasGozo,
			abonoPecuniarioInicio: abonoPecuniarioInicio,
			abonoPecuniarioFim: abonoPecuniarioFim,
			diasAbono: diasAbono,
			dataPagamento: dataPagamento,
		);			
	}

	
}