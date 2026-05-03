import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/data/domain/domain_imports.dart';

class FiscalInscricoesSubstitutasModel {
	int? id;
	int? idFiscalParametros;
	String? uf;
	String? inscricaoEstadual;
	String? pmpf;

	FiscalInscricoesSubstitutasModel({
		this.id,
		this.idFiscalParametros,
		this.uf,
		this.inscricaoEstadual,
		this.pmpf,
	});

	static List<String> dbColumns = <String>[
		'id',
		'uf',
		'inscricao_estadual',
		'pmpf',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Uf',
		'Inscricao Estadual',
		'Pmpf',
	];

	FiscalInscricoesSubstitutasModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFiscalParametros = jsonData['idFiscalParametros'];
		uf = FiscalInscricoesSubstitutasDomain.getUf(jsonData['uf']);
		inscricaoEstadual = jsonData['inscricaoEstadual'];
		pmpf = FiscalInscricoesSubstitutasDomain.getPmpf(jsonData['pmpf']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFiscalParametros'] = idFiscalParametros != 0 ? idFiscalParametros : null;
		jsonData['uf'] = FiscalInscricoesSubstitutasDomain.setUf(uf);
		jsonData['inscricaoEstadual'] = inscricaoEstadual;
		jsonData['pmpf'] = FiscalInscricoesSubstitutasDomain.setPmpf(pmpf);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFiscalParametros = plutoRow.cells['idFiscalParametros']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		inscricaoEstadual = plutoRow.cells['inscricaoEstadual']?.value;
		pmpf = plutoRow.cells['pmpf']?.value != '' ? plutoRow.cells['pmpf']?.value : 'Sim';
	}	

	FiscalInscricoesSubstitutasModel clone() {
		return FiscalInscricoesSubstitutasModel(
			id: id,
			idFiscalParametros: idFiscalParametros,
			uf: uf,
			inscricaoEstadual: inscricaoEstadual,
			pmpf: pmpf,
		);			
	}

	
}