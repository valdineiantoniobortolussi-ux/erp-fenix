import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfse/app/infra/infra_imports.dart';

class NfseIntermediarioModel {
	int? id;
	int? idNfseCabecalho;
	String? cnpj;
	String? inscricaoMunicipal;
	String? razao;

	NfseIntermediarioModel({
		this.id,
		this.idNfseCabecalho,
		this.cnpj,
		this.inscricaoMunicipal,
		this.razao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'inscricao_municipal',
		'razao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Inscricao Municipal',
		'Razao',
	];

	NfseIntermediarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfseCabecalho = jsonData['idNfseCabecalho'];
		cnpj = jsonData['cnpj'];
		inscricaoMunicipal = jsonData['inscricaoMunicipal'];
		razao = jsonData['razao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfseCabecalho'] = idNfseCabecalho != 0 ? idNfseCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['inscricaoMunicipal'] = inscricaoMunicipal;
		jsonData['razao'] = razao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfseCabecalho = plutoRow.cells['idNfseCabecalho']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		inscricaoMunicipal = plutoRow.cells['inscricaoMunicipal']?.value;
		razao = plutoRow.cells['razao']?.value;
	}	

	NfseIntermediarioModel clone() {
		return NfseIntermediarioModel(
			id: id,
			idNfseCabecalho: idNfseCabecalho,
			cnpj: cnpj,
			inscricaoMunicipal: inscricaoMunicipal,
			razao: razao,
		);			
	}

	
}