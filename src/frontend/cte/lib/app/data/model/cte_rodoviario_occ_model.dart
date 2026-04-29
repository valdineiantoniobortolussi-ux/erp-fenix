import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:cte/app/data/domain/domain_imports.dart';

class CteRodoviarioOccModel {
	int? id;
	int? idCteRodoviario;
	String? serie;
	int? numero;
	DateTime? dataEmissao;
	String? cnpj;
	String? codigoInterno;
	String? ie;
	String? uf;
	String? telefone;
	CteRodoviarioModel? cteRodoviarioModel;

	CteRodoviarioOccModel({
		this.id,
		this.idCteRodoviario,
		this.serie,
		this.numero,
		this.dataEmissao,
		this.cnpj,
		this.codigoInterno,
		this.ie,
		this.uf,
		this.telefone,
		this.cteRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'serie',
		'numero',
		'data_emissao',
		'cnpj',
		'codigo_interno',
		'ie',
		'uf',
		'telefone',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Serie',
		'Numero',
		'Data Emissao',
		'Cnpj',
		'Codigo Interno',
		'Ie',
		'Uf',
		'Telefone',
	];

	CteRodoviarioOccModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteRodoviario = jsonData['idCteRodoviario'];
		serie = CteRodoviarioOccDomain.getSerie(jsonData['serie']);
		numero = jsonData['numero'];
		dataEmissao = jsonData['dataEmissao'] != null ? DateTime.tryParse(jsonData['dataEmissao']) : null;
		cnpj = jsonData['cnpj'];
		codigoInterno = jsonData['codigoInterno'];
		ie = jsonData['ie'];
		uf = CteRodoviarioOccDomain.getUf(jsonData['uf']);
		telefone = jsonData['telefone'];
		cteRodoviarioModel = jsonData['cteRodoviarioModel'] == null ? CteRodoviarioModel() : CteRodoviarioModel.fromJson(jsonData['cteRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteRodoviario'] = idCteRodoviario != 0 ? idCteRodoviario : null;
		jsonData['serie'] = CteRodoviarioOccDomain.setSerie(serie);
		jsonData['numero'] = numero;
		jsonData['dataEmissao'] = dataEmissao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataEmissao!) : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['codigoInterno'] = codigoInterno;
		jsonData['ie'] = ie;
		jsonData['uf'] = CteRodoviarioOccDomain.setUf(uf);
		jsonData['telefone'] = telefone;
		jsonData['cteRodoviarioModel'] = cteRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteRodoviario = plutoRow.cells['idCteRodoviario']?.value;
		serie = plutoRow.cells['serie']?.value != '' ? plutoRow.cells['serie']?.value : 'AAA';
		numero = plutoRow.cells['numero']?.value;
		dataEmissao = Util.stringToDate(plutoRow.cells['dataEmissao']?.value);
		cnpj = plutoRow.cells['cnpj']?.value;
		codigoInterno = plutoRow.cells['codigoInterno']?.value;
		ie = plutoRow.cells['ie']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		telefone = plutoRow.cells['telefone']?.value;
		cteRodoviarioModel = CteRodoviarioModel();
		cteRodoviarioModel?.rntrc = plutoRow.cells['cteRodoviarioModel']?.value;
	}	

	CteRodoviarioOccModel clone() {
		return CteRodoviarioOccModel(
			id: id,
			idCteRodoviario: idCteRodoviario,
			serie: serie,
			numero: numero,
			dataEmissao: dataEmissao,
			cnpj: cnpj,
			codigoInterno: codigoInterno,
			ie: ie,
			uf: uf,
			telefone: telefone,
		);			
	}

	
}