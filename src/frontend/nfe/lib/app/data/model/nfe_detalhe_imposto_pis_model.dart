import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetalheImpostoPisModel {
	int? id;
	int? idNfeDetalhe;
	String? cstPis;
	double? valorBaseCalculoPis;
	double? aliquotaPisPercentual;
	double? valorPis;
	double? quantidadeVendida;
	double? aliquotaPisReais;

	NfeDetalheImpostoPisModel({
		this.id,
		this.idNfeDetalhe,
		this.cstPis,
		this.valorBaseCalculoPis,
		this.aliquotaPisPercentual,
		this.valorPis,
		this.quantidadeVendida,
		this.aliquotaPisReais,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cst_pis',
		'valor_base_calculo_pis',
		'aliquota_pis_percentual',
		'valor_pis',
		'quantidade_vendida',
		'aliquota_pis_reais',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cst Pis',
		'Valor Base Calculo Pis',
		'Aliquota Pis Percentual',
		'Valor Pis',
		'Quantidade Vendida',
		'Aliquota Pis Reais',
	];

	NfeDetalheImpostoPisModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		cstPis = NfeDetalheImpostoPisDomain.getCstPis(jsonData['cstPis']);
		valorBaseCalculoPis = jsonData['valorBaseCalculoPis']?.toDouble();
		aliquotaPisPercentual = jsonData['aliquotaPisPercentual']?.toDouble();
		valorPis = jsonData['valorPis']?.toDouble();
		quantidadeVendida = jsonData['quantidadeVendida']?.toDouble();
		aliquotaPisReais = jsonData['aliquotaPisReais']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['cstPis'] = NfeDetalheImpostoPisDomain.setCstPis(cstPis);
		jsonData['valorBaseCalculoPis'] = valorBaseCalculoPis;
		jsonData['aliquotaPisPercentual'] = aliquotaPisPercentual;
		jsonData['valorPis'] = valorPis;
		jsonData['quantidadeVendida'] = quantidadeVendida;
		jsonData['aliquotaPisReais'] = aliquotaPisReais;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		cstPis = plutoRow.cells['cstPis']?.value != '' ? plutoRow.cells['cstPis']?.value : 'AAA';
		valorBaseCalculoPis = plutoRow.cells['valorBaseCalculoPis']?.value?.toDouble();
		aliquotaPisPercentual = plutoRow.cells['aliquotaPisPercentual']?.value?.toDouble();
		valorPis = plutoRow.cells['valorPis']?.value?.toDouble();
		quantidadeVendida = plutoRow.cells['quantidadeVendida']?.value?.toDouble();
		aliquotaPisReais = plutoRow.cells['aliquotaPisReais']?.value?.toDouble();
	}	

	NfeDetalheImpostoPisModel clone() {
		return NfeDetalheImpostoPisModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			cstPis: cstPis,
			valorBaseCalculoPis: valorBaseCalculoPis,
			aliquotaPisPercentual: aliquotaPisPercentual,
			valorPis: valorPis,
			quantidadeVendida: quantidadeVendida,
			aliquotaPisReais: aliquotaPisReais,
		);			
	}

	
}