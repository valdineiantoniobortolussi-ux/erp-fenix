import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeNfReferenciadaModel {
	int? id;
	int? idNfeCabecalho;
	int? codigoUf;
	String? anoMes;
	String? cnpj;
	String? modelo;
	String? serie;
	int? numeroNf;

	NfeNfReferenciadaModel({
		this.id,
		this.idNfeCabecalho,
		this.codigoUf,
		this.anoMes,
		this.cnpj,
		this.modelo,
		this.serie,
		this.numeroNf,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo_uf',
		'ano_mes',
		'cnpj',
		'modelo',
		'serie',
		'numero_nf',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo Uf',
		'Ano Mes',
		'Cnpj',
		'Modelo',
		'Serie',
		'Numero Nf',
	];

	NfeNfReferenciadaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		codigoUf = jsonData['codigoUf'];
		anoMes = jsonData['anoMes'];
		cnpj = jsonData['cnpj'];
		modelo = NfeNfReferenciadaDomain.getModelo(jsonData['modelo']);
		serie = NfeNfReferenciadaDomain.getSerie(jsonData['serie']);
		numeroNf = jsonData['numeroNf'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['codigoUf'] = codigoUf;
		jsonData['anoMes'] = anoMes;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['modelo'] = NfeNfReferenciadaDomain.setModelo(modelo);
		jsonData['serie'] = NfeNfReferenciadaDomain.setSerie(serie);
		jsonData['numeroNf'] = numeroNf;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		codigoUf = plutoRow.cells['codigoUf']?.value;
		anoMes = plutoRow.cells['anoMes']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		modelo = plutoRow.cells['modelo']?.value != '' ? plutoRow.cells['modelo']?.value : 'AAA';
		serie = plutoRow.cells['serie']?.value != '' ? plutoRow.cells['serie']?.value : 'AAA';
		numeroNf = plutoRow.cells['numeroNf']?.value;
	}	

	NfeNfReferenciadaModel clone() {
		return NfeNfReferenciadaModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			codigoUf: codigoUf,
			anoMes: anoMes,
			cnpj: cnpj,
			modelo: modelo,
			serie: serie,
			numeroNf: numeroNf,
		);			
	}

	
}