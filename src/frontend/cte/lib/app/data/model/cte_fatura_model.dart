import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CteFaturaModel {
	int? id;
	int? idCteCabecalho;
	String? numero;
	double? valorOriginal;
	double? valorDesconto;
	double? valorLiquido;

	CteFaturaModel({
		this.id,
		this.idCteCabecalho,
		this.numero,
		this.valorOriginal,
		this.valorDesconto,
		this.valorLiquido,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'valor_original',
		'valor_desconto',
		'valor_liquido',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Valor Original',
		'Valor Desconto',
		'Valor Liquido',
	];

	CteFaturaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		numero = jsonData['numero'];
		valorOriginal = jsonData['valorOriginal']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorLiquido = jsonData['valorLiquido']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['numero'] = numero;
		jsonData['valorOriginal'] = valorOriginal;
		jsonData['valorDesconto'] = valorDesconto;
		jsonData['valorLiquido'] = valorLiquido;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		numero = plutoRow.cells['numero']?.value;
		valorOriginal = plutoRow.cells['valorOriginal']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorLiquido = plutoRow.cells['valorLiquido']?.value?.toDouble();
	}	

	CteFaturaModel clone() {
		return CteFaturaModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			numero: numero,
			valorOriginal: valorOriginal,
			valorDesconto: valorDesconto,
			valorLiquido: valorLiquido,
		);			
	}

	
}