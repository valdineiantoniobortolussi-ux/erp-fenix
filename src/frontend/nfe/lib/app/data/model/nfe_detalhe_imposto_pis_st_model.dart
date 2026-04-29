import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeDetalheImpostoPisStModel {
	int? id;
	int? idNfeDetalhe;
	double? valorBaseCalculoPisSt;
	double? aliquotaPisStPercentual;
	double? quantidadeVendidaPisSt;
	double? aliquotaPisStReais;
	double? valorPisSt;

	NfeDetalheImpostoPisStModel({
		this.id,
		this.idNfeDetalhe,
		this.valorBaseCalculoPisSt,
		this.aliquotaPisStPercentual,
		this.quantidadeVendidaPisSt,
		this.aliquotaPisStReais,
		this.valorPisSt,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor_base_calculo_pis_st',
		'aliquota_pis_st_percentual',
		'quantidade_vendida_pis_st',
		'aliquota_pis_st_reais',
		'valor_pis_st',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor Base Calculo Pis St',
		'Aliquota Pis St Percentual',
		'Quantidade Vendida Pis St',
		'Aliquota Pis St Reais',
		'Valor Pis St',
	];

	NfeDetalheImpostoPisStModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeDetalhe = jsonData['idNfeDetalhe'];
		valorBaseCalculoPisSt = jsonData['valorBaseCalculoPisSt']?.toDouble();
		aliquotaPisStPercentual = jsonData['aliquotaPisStPercentual']?.toDouble();
		quantidadeVendidaPisSt = jsonData['quantidadeVendidaPisSt']?.toDouble();
		aliquotaPisStReais = jsonData['aliquotaPisStReais']?.toDouble();
		valorPisSt = jsonData['valorPisSt']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeDetalhe'] = idNfeDetalhe != 0 ? idNfeDetalhe : null;
		jsonData['valorBaseCalculoPisSt'] = valorBaseCalculoPisSt;
		jsonData['aliquotaPisStPercentual'] = aliquotaPisStPercentual;
		jsonData['quantidadeVendidaPisSt'] = quantidadeVendidaPisSt;
		jsonData['aliquotaPisStReais'] = aliquotaPisStReais;
		jsonData['valorPisSt'] = valorPisSt;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeDetalhe = plutoRow.cells['idNfeDetalhe']?.value;
		valorBaseCalculoPisSt = plutoRow.cells['valorBaseCalculoPisSt']?.value?.toDouble();
		aliquotaPisStPercentual = plutoRow.cells['aliquotaPisStPercentual']?.value?.toDouble();
		quantidadeVendidaPisSt = plutoRow.cells['quantidadeVendidaPisSt']?.value?.toDouble();
		aliquotaPisStReais = plutoRow.cells['aliquotaPisStReais']?.value?.toDouble();
		valorPisSt = plutoRow.cells['valorPisSt']?.value?.toDouble();
	}	

	NfeDetalheImpostoPisStModel clone() {
		return NfeDetalheImpostoPisStModel(
			id: id,
			idNfeDetalhe: idNfeDetalhe,
			valorBaseCalculoPisSt: valorBaseCalculoPisSt,
			aliquotaPisStPercentual: aliquotaPisStPercentual,
			quantidadeVendidaPisSt: quantidadeVendidaPisSt,
			aliquotaPisStReais: aliquotaPisStReais,
			valorPisSt: valorPisSt,
		);			
	}

	
}