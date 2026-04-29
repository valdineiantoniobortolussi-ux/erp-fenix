import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:folha/app/data/domain/domain_imports.dart';

class GuiasAcumuladasModel {
	int? id;
	String? gpsTipo;
	String? gpsCompetencia;
	double? gpsValorInss;
	double? gpsValorOutrasEnt;
	DateTime? gpsDataPagamento;
	String? irrfCompetencia;
	int? irrfCodigoRecolhimento;
	double? irrfValorAcumulado;
	DateTime? irrfDataPagamento;
	String? pisCompetencia;
	double? pisValorAcumulado;
	DateTime? pisDataPagamento;

	GuiasAcumuladasModel({
		this.id,
		this.gpsTipo,
		this.gpsCompetencia,
		this.gpsValorInss,
		this.gpsValorOutrasEnt,
		this.gpsDataPagamento,
		this.irrfCompetencia,
		this.irrfCodigoRecolhimento,
		this.irrfValorAcumulado,
		this.irrfDataPagamento,
		this.pisCompetencia,
		this.pisValorAcumulado,
		this.pisDataPagamento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'gps_tipo',
		'gps_competencia',
		'gps_valor_inss',
		'gps_valor_outras_ent',
		'gps_data_pagamento',
		'irrf_competencia',
		'irrf_codigo_recolhimento',
		'irrf_valor_acumulado',
		'irrf_data_pagamento',
		'pis_competencia',
		'pis_valor_acumulado',
		'pis_data_pagamento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Gps Tipo',
		'Gps Competencia',
		'Gps Valor Inss',
		'Gps Valor Outras Ent',
		'Gps Data Pagamento',
		'Irrf Competencia',
		'Irrf Codigo Recolhimento',
		'Irrf Valor Acumulado',
		'Irrf Data Pagamento',
		'Pis Competencia',
		'Pis Valor Acumulado',
		'Pis Data Pagamento',
	];

	GuiasAcumuladasModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		gpsTipo = GuiasAcumuladasDomain.getGpsTipo(jsonData['gpsTipo']);
		gpsCompetencia = jsonData['gpsCompetencia'];
		gpsValorInss = jsonData['gpsValorInss']?.toDouble();
		gpsValorOutrasEnt = jsonData['gpsValorOutrasEnt']?.toDouble();
		gpsDataPagamento = jsonData['gpsDataPagamento'] != null ? DateTime.tryParse(jsonData['gpsDataPagamento']) : null;
		irrfCompetencia = jsonData['irrfCompetencia'];
		irrfCodigoRecolhimento = jsonData['irrfCodigoRecolhimento'];
		irrfValorAcumulado = jsonData['irrfValorAcumulado']?.toDouble();
		irrfDataPagamento = jsonData['irrfDataPagamento'] != null ? DateTime.tryParse(jsonData['irrfDataPagamento']) : null;
		pisCompetencia = jsonData['pisCompetencia'];
		pisValorAcumulado = jsonData['pisValorAcumulado']?.toDouble();
		pisDataPagamento = jsonData['pisDataPagamento'] != null ? DateTime.tryParse(jsonData['pisDataPagamento']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['gpsTipo'] = GuiasAcumuladasDomain.setGpsTipo(gpsTipo);
		jsonData['gpsCompetencia'] = Util.removeMask(gpsCompetencia);
		jsonData['gpsValorInss'] = gpsValorInss;
		jsonData['gpsValorOutrasEnt'] = gpsValorOutrasEnt;
		jsonData['gpsDataPagamento'] = gpsDataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(gpsDataPagamento!) : null;
		jsonData['irrfCompetencia'] = Util.removeMask(irrfCompetencia);
		jsonData['irrfCodigoRecolhimento'] = irrfCodigoRecolhimento;
		jsonData['irrfValorAcumulado'] = irrfValorAcumulado;
		jsonData['irrfDataPagamento'] = irrfDataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(irrfDataPagamento!) : null;
		jsonData['pisCompetencia'] = Util.removeMask(pisCompetencia);
		jsonData['pisValorAcumulado'] = pisValorAcumulado;
		jsonData['pisDataPagamento'] = pisDataPagamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(pisDataPagamento!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		gpsTipo = plutoRow.cells['gpsTipo']?.value != '' ? plutoRow.cells['gpsTipo']?.value : '1-Filial própia empresa';
		gpsCompetencia = plutoRow.cells['gpsCompetencia']?.value;
		gpsValorInss = plutoRow.cells['gpsValorInss']?.value?.toDouble();
		gpsValorOutrasEnt = plutoRow.cells['gpsValorOutrasEnt']?.value?.toDouble();
		gpsDataPagamento = Util.stringToDate(plutoRow.cells['gpsDataPagamento']?.value);
		irrfCompetencia = plutoRow.cells['irrfCompetencia']?.value;
		irrfCodigoRecolhimento = plutoRow.cells['irrfCodigoRecolhimento']?.value;
		irrfValorAcumulado = plutoRow.cells['irrfValorAcumulado']?.value?.toDouble();
		irrfDataPagamento = Util.stringToDate(plutoRow.cells['irrfDataPagamento']?.value);
		pisCompetencia = plutoRow.cells['pisCompetencia']?.value;
		pisValorAcumulado = plutoRow.cells['pisValorAcumulado']?.value?.toDouble();
		pisDataPagamento = Util.stringToDate(plutoRow.cells['pisDataPagamento']?.value);
	}	

	GuiasAcumuladasModel clone() {
		return GuiasAcumuladasModel(
			id: id,
			gpsTipo: gpsTipo,
			gpsCompetencia: gpsCompetencia,
			gpsValorInss: gpsValorInss,
			gpsValorOutrasEnt: gpsValorOutrasEnt,
			gpsDataPagamento: gpsDataPagamento,
			irrfCompetencia: irrfCompetencia,
			irrfCodigoRecolhimento: irrfCodigoRecolhimento,
			irrfValorAcumulado: irrfValorAcumulado,
			irrfDataPagamento: irrfDataPagamento,
			pisCompetencia: pisCompetencia,
			pisValorAcumulado: pisValorAcumulado,
			pisDataPagamento: pisDataPagamento,
		);			
	}

	
}