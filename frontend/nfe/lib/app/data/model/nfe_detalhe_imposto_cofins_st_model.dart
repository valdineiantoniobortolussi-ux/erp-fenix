import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeDetalheImpostoCofinsStModel {
	int? id;
	int? idNfeDetalhe;
	double? baseCalculoCofinsSt;
	double? aliquotaCofinsStPercentual;
	double? quantidadeVendidaCofinsSt;
	double? aliquotaCofinsStReais;
	double? valorCofinsSt;

	NfeDetalheImpostoCofinsStModel({
		this.id,
		this.idNfeDetalhe,
		this.baseCalculoCofinsSt,
		this.aliquotaCofinsStPercentual,
		this.quantidadeVendidaCofinsSt,
		this.aliquotaCofinsStReais,
		this.valorCofinsSt,
	});

	static List<String> dbColumns = <String>[
		'id',
		'base_calculo_cofins_st',
		'aliquota_cofins_st_percentual',
		'quantidade_vendida_cofins_st',
		'aliquota_cofins_st_reais',
		'valor_cofins_st',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Base Calculo Cofins St',
		'Aliquota Cofins St Percentual',
		'Quantidade Vendida Cofins St',
		'Aliquota Cofins St Reais',
		'Valor Cofins St',
	];

	NfeDetalheImpostoCofinsStModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		baseCalculoCofinsSt = jsonData['baseCalculoCofinsSt']?.toDouble();
		aliquotaCofinsStPercentual = jsonData['aliquotaCofinsStPercentual']?.toDouble();
		quantidadeVendidaCofinsSt = jsonData['quantidadeVendidaCofinsSt']?.toDouble();
		aliquotaCofinsStReais = jsonData['aliquotaCofinsStReais']?.toDouble();
		valorCofinsSt = jsonData['valorCofinsSt']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['baseCalculoCofinsSt'] = baseCalculoCofinsSt;
		jsonData['aliquotaCofinsStPercentual'] = aliquotaCofinsStPercentual;
		jsonData['quantidadeVendidaCofinsSt'] = quantidadeVendidaCofinsSt;
		jsonData['aliquotaCofinsStReais'] = aliquotaCofinsStReais;
		jsonData['valorCofinsSt'] = valorCofinsSt;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		baseCalculoCofinsSt = plutoRow.cells['baseCalculoCofinsSt']?.value?.toDouble();
		aliquotaCofinsStPercentual = plutoRow.cells['aliquotaCofinsStPercentual']?.value?.toDouble();
		quantidadeVendidaCofinsSt = plutoRow.cells['quantidadeVendidaCofinsSt']?.value?.toDouble();
		aliquotaCofinsStReais = plutoRow.cells['aliquotaCofinsStReais']?.value?.toDouble();
		valorCofinsSt = plutoRow.cells['valorCofinsSt']?.value?.toDouble();
	}	

	NfeDetalheImpostoCofinsStModel clone() {
		return NfeDetalheImpostoCofinsStModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			baseCalculoCofinsSt: baseCalculoCofinsSt,
			aliquotaCofinsStPercentual: aliquotaCofinsStPercentual,
			quantidadeVendidaCofinsSt: quantidadeVendidaCofinsSt,
			aliquotaCofinsStReais: aliquotaCofinsStReais,
			valorCofinsSt: valorCofinsSt,
		);			
	}

	
}