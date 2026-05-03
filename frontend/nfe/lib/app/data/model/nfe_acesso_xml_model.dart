import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/infra/infra_imports.dart';

class NfeAcessoXmlModel {
	int? id;
	int? idNfeCabecalho;
	String? cnpj;
	String? cpf;

	NfeAcessoXmlModel({
		this.id,
		this.idNfeCabecalho,
		this.cnpj,
		this.cpf,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cnpj',
		'cpf',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cnpj',
		'Cpf',
	];

	NfeAcessoXmlModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		cnpj = jsonData['cnpj'];
		cpf = jsonData['cpf'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['cnpj'] = Util.removeMask(cnpj);
		jsonData['cpf'] = Util.removeMask(cpf);
	
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
		cpf = plutoRow.cells['cpf']?.value;
	}	

	NfeAcessoXmlModel clone() {
		return NfeAcessoXmlModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			cnpj: cnpj,
			cpf: cpf,
		);			
	}

	
}