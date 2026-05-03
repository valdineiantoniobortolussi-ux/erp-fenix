import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class NfeCteReferenciadoModel {
	int? id;
	int? idNfeCabecalho;
	String? chaveAcesso;

	NfeCteReferenciadoModel({
		this.id,
		this.idNfeCabecalho,
		this.chaveAcesso,
	});

	static List<String> dbColumns = <String>[
		'id',
		'chave_acesso',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Chave Acesso',
	];

	NfeCteReferenciadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		chaveAcesso = jsonData['chaveAcesso'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['chaveAcesso'] = chaveAcesso;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		chaveAcesso = plutoRow.cells['chaveAcesso']?.value;
	}	

	NfeCteReferenciadoModel clone() {
		return NfeCteReferenciadoModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			chaveAcesso: chaveAcesso,
		);			
	}

	
}