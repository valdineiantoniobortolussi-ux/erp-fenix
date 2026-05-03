import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeResponsavelTecnicoModel {
	int? id;
	int? idNfeCabecalho;
	String? cnpj;
	String? contato;
	String? email;
	String? telefone;
	String? identificadorCsrt;
	String? hashCsrt;

	NfeResponsavelTecnicoModel({
		this.id,
		this.idNfeCabecalho,
		this.cnpj,
		this.contato,
		this.email,
		this.telefone,
		this.identificadorCsrt,
		this.hashCsrt,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'contato',
		'email',
		'telefone',
		'identificador_csrt',
		'hash_csrt',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Contato',
		'Email',
		'Telefone',
		'Identificador Csrt',
		'Hash Csrt',
	];

	NfeResponsavelTecnicoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		cnpj = jsonData['cnpj'];
		contato = jsonData['contato'];
		email = jsonData['email'];
		telefone = jsonData['telefone'];
		identificadorCsrt = NfeResponsavelTecnicoDomain.getIdentificadorCsrt(jsonData['identificadorCsrt']);
		hashCsrt = jsonData['hashCsrt'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['contato'] = contato;
		jsonData['email'] = email;
		jsonData['telefone'] = telefone;
		jsonData['identificadorCsrt'] = NfeResponsavelTecnicoDomain.setIdentificadorCsrt(identificadorCsrt);
		jsonData['hashCsrt'] = hashCsrt;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		contato = plutoRow.cells['contato']?.value;
		email = plutoRow.cells['email']?.value;
		telefone = plutoRow.cells['telefone']?.value;
		identificadorCsrt = plutoRow.cells['identificadorCsrt']?.value != '' ? plutoRow.cells['identificadorCsrt']?.value : 'AAA';
		hashCsrt = plutoRow.cells['hashCsrt']?.value;
	}	

	NfeResponsavelTecnicoModel clone() {
		return NfeResponsavelTecnicoModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			cnpj: cnpj,
			contato: contato,
			email: email,
			telefone: telefone,
			identificadorCsrt: identificadorCsrt,
			hashCsrt: hashCsrt,
		);			
	}

	
}