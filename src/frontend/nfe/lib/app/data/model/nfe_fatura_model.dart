import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeFaturaModel {
	int? id;
	int? idNfeCabecalho;
	String? numero;
	double? valorOriginal;
	double? valorDesconto;
	double? valorLiquido;

	NfeFaturaModel({
		this.id,
		this.idNfeCabecalho,
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

	NfeFaturaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		numero = jsonData['numero'];
		valorOriginal = jsonData['valorOriginal']?.toDouble();
		valorDesconto = jsonData['valorDesconto']?.toDouble();
		valorLiquido = jsonData['valorLiquido']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
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
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		numero = plutoRow.cells['numero']?.value;
		valorOriginal = plutoRow.cells['valorOriginal']?.value?.toDouble();
		valorDesconto = plutoRow.cells['valorDesconto']?.value?.toDouble();
		valorLiquido = plutoRow.cells['valorLiquido']?.value?.toDouble();
	}	

	NfeFaturaModel clone() {
		return NfeFaturaModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			numero: numero,
			valorOriginal: valorOriginal,
			valorDesconto: valorDesconto,
			valorLiquido: valorLiquido,
		);			
	}

	
}