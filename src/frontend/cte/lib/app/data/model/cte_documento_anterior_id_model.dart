import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteDocumentoAnteriorIdModel {
	int? id;
	int? idCteDocumentoAnterior;
	String? tipo;
	String? serie;
	String? subserie;
	String? numero;
	DateTime? dataEmissao;
	String? chaveCte;

	CteDocumentoAnteriorIdModel({
		this.id,
		this.idCteDocumentoAnterior,
		this.tipo,
		this.serie,
		this.subserie,
		this.numero,
		this.dataEmissao,
		this.chaveCte,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo',
		'serie',
		'subserie',
		'numero',
		'data_emissao',
		'chave_cte',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo',
		'Serie',
		'Subserie',
		'Numero',
		'Data Emissao',
		'Chave Cte',
	];

	CteDocumentoAnteriorIdModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteDocumentoAnterior = jsonData['idCteDocumentoAnterior'];
		tipo = CteDocumentoAnteriorIdDomain.getTipo(jsonData['tipo']);
		serie = CteDocumentoAnteriorIdDomain.getSerie(jsonData['serie']);
		subserie = CteDocumentoAnteriorIdDomain.getSubserie(jsonData['subserie']);
		numero = jsonData['numero'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		chaveCte = jsonData['chaveCte'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteDocumentoAnterior'] = idCteDocumentoAnterior != 0 ? idCteDocumentoAnterior : null;
		jsonData['tipo'] = CteDocumentoAnteriorIdDomain.setTipo(tipo);
		jsonData['serie'] = CteDocumentoAnteriorIdDomain.setSerie(serie);
		jsonData['subserie'] = CteDocumentoAnteriorIdDomain.setSubserie(subserie);
		jsonData['numero'] = numero;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['chaveCte'] = chaveCte;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteDocumentoAnterior = plutoRow.cells['idCteDocumentoAnterior']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'AAA';
		serie = plutoRow.cells['serie']?.value != '' ? plutoRow.cells['serie']?.value : 'AAA';
		subserie = plutoRow.cells['subserie']?.value != '' ? plutoRow.cells['subserie']?.value : 'AAA';
		numero = plutoRow.cells['numero']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		chaveCte = plutoRow.cells['chaveCte']?.value;
	}	

	CteDocumentoAnteriorIdModel clone() {
		return CteDocumentoAnteriorIdModel(
			id: id,
			idCteDocumentoAnterior: idCteDocumentoAnterior,
			tipo: tipo,
			serie: serie,
			subserie: subserie,
			numero: numero,
			dataEmissao: dataEmissao,
			chaveCte: chaveCte,
		);			
	}

	
}