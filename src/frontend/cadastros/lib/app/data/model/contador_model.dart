import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/domain/domain_imports.dart';

class ContadorModel {
	int? id;
	int? idPessoa;
	String? crcInscricao;
	String? crcUf;

	ContadorModel({
		this.id,
		this.idPessoa,
		this.crcInscricao,
		this.crcUf,
	});

	static List<String> dbColumns = <String>[
		'id',
		'crc_inscricao',
		'crc_uf',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Crc Inscricao',
		'Crc Uf',
	];

	ContadorModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		crcInscricao = jsonData['crcInscricao'];
		crcUf = ContadorDomain.getCrcUf(jsonData['crcUf']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['crcInscricao'] = crcInscricao;
		jsonData['crcUf'] = ContadorDomain.setCrcUf(crcUf);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		crcInscricao = plutoRow.cells['crcInscricao']?.value;
		crcUf = plutoRow.cells['crcUf']?.value != '' ? plutoRow.cells['crcUf']?.value : 'AC';
	}	

	ContadorModel clone() {
		return ContadorModel(
			id: id,
			idPessoa: idPessoa,
			crcInscricao: crcInscricao,
			crcUf: crcUf,
		);			
	}

	
}