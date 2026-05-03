import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/domain/domain_imports.dart';

class CteSeguroModel {
	int? id;
	int? idCteCabecalho;
	String? responsavel;
	String? seguradora;
	String? apolice;
	String? averbacao;
	double? valorCarga;

	CteSeguroModel({
		this.id,
		this.idCteCabecalho,
		this.responsavel,
		this.seguradora,
		this.apolice,
		this.averbacao,
		this.valorCarga,
	});

	static List<String> dbColumns = <String>[
		'id',
		'responsavel',
		'seguradora',
		'apolice',
		'averbacao',
		'valor_carga',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Responsavel',
		'Seguradora',
		'Apolice',
		'Averbacao',
		'Valor Carga',
	];

	CteSeguroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		responsavel = CteSeguroDomain.getResponsavel(jsonData['responsavel']);
		seguradora = jsonData['seguradora'];
		apolice = jsonData['apolice'];
		averbacao = jsonData['averbacao'];
		valorCarga = jsonData['valorCarga']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['responsavel'] = CteSeguroDomain.setResponsavel(responsavel);
		jsonData['seguradora'] = seguradora;
		jsonData['apolice'] = apolice;
		jsonData['averbacao'] = averbacao;
		jsonData['valorCarga'] = valorCarga;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		responsavel = plutoRow.cells['responsavel']?.value != '' ? plutoRow.cells['responsavel']?.value : 'AAA';
		seguradora = plutoRow.cells['seguradora']?.value;
		apolice = plutoRow.cells['apolice']?.value;
		averbacao = plutoRow.cells['averbacao']?.value;
		valorCarga = plutoRow.cells['valorCarga']?.value?.toDouble();
	}	

	CteSeguroModel clone() {
		return CteSeguroModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			responsavel: responsavel,
			seguradora: seguradora,
			apolice: apolice,
			averbacao: averbacao,
			valorCarga: valorCarga,
		);			
	}

	
}