import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeCanaModel {
	int? id;
	int? idNfeCabecalho;
	String? safra;
	String? mesAnoReferencia;

	NfeCanaModel({
		this.id,
		this.idNfeCabecalho,
		this.safra,
		this.mesAnoReferencia,
	});

	static List<String> dbColumns = <String>[
		'id',
		'safra',
		'mes_ano_referencia',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Safra',
		'Mes Ano Referencia',
	];

	NfeCanaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		safra = jsonData['safra'];
		mesAnoReferencia = jsonData['mesAnoReferencia'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['safra'] = safra;
		jsonData['mesAnoReferencia'] = mesAnoReferencia;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		safra = plutoRow.cells['safra']?.value;
		mesAnoReferencia = plutoRow.cells['mesAnoReferencia']?.value;
	}	

	NfeCanaModel clone() {
		return NfeCanaModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			safra: safra,
			mesAnoReferencia: mesAnoReferencia,
		);			
	}

	
}