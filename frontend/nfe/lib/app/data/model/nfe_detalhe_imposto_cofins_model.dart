import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeDetalheImpostoCofinsModel {
	int? id;
	int? idNfeDetalhe;
	String? cstCofins;
	double? baseCalculoCofins;
	double? aliquotaCofinsPercentual;
	double? quantidadeVendida;
	double? aliquotaCofinsReais;
	double? valorCofins;

	NfeDetalheImpostoCofinsModel({
		this.id,
		this.idNfeDetalhe,
		this.cstCofins,
		this.baseCalculoCofins,
		this.aliquotaCofinsPercentual,
		this.quantidadeVendida,
		this.aliquotaCofinsReais,
		this.valorCofins,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cst_cofins',
		'base_calculo_cofins',
		'aliquota_cofins_percentual',
		'quantidade_vendida',
		'aliquota_cofins_reais',
		'valor_cofins',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cst Cofins',
		'Base Calculo Cofins',
		'Aliquota Cofins Percentual',
		'Quantidade Vendida',
		'Aliquota Cofins Reais',
		'Valor Cofins',
	];

	NfeDetalheImpostoCofinsModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		cstCofins = NfeDetalheImpostoCofinsDomain.getCstCofins(jsonData['cstCofins']);
		baseCalculoCofins = jsonData['baseCalculoCofins']?.toDouble();
		aliquotaCofinsPercentual = jsonData['aliquotaCofinsPercentual']?.toDouble();
		quantidadeVendida = jsonData['quantidadeVendida']?.toDouble();
		aliquotaCofinsReais = jsonData['aliquotaCofinsReais']?.toDouble();
		valorCofins = jsonData['valorCofins']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['cstCofins'] = NfeDetalheImpostoCofinsDomain.setCstCofins(cstCofins);
		jsonData['baseCalculoCofins'] = baseCalculoCofins;
		jsonData['aliquotaCofinsPercentual'] = aliquotaCofinsPercentual;
		jsonData['quantidadeVendida'] = quantidadeVendida;
		jsonData['aliquotaCofinsReais'] = aliquotaCofinsReais;
		jsonData['valorCofins'] = valorCofins;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		cstCofins = plutoRow.cells['cstCofins']?.value != '' ? plutoRow.cells['cstCofins']?.value : 'AAA';
		baseCalculoCofins = plutoRow.cells['baseCalculoCofins']?.value?.toDouble();
		aliquotaCofinsPercentual = plutoRow.cells['aliquotaCofinsPercentual']?.value?.toDouble();
		quantidadeVendida = plutoRow.cells['quantidadeVendida']?.value?.toDouble();
		aliquotaCofinsReais = plutoRow.cells['aliquotaCofinsReais']?.value?.toDouble();
		valorCofins = plutoRow.cells['valorCofins']?.value?.toDouble();
	}	

	NfeDetalheImpostoCofinsModel clone() {
		return NfeDetalheImpostoCofinsModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			cstCofins: cstCofins,
			baseCalculoCofins: baseCalculoCofins,
			aliquotaCofinsPercentual: aliquotaCofinsPercentual,
			quantidadeVendida: quantidadeVendida,
			aliquotaCofinsReais: aliquotaCofinsReais,
			valorCofins: valorCofins,
		);			
	}

	
}