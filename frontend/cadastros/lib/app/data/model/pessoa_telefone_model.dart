import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class PessoaTelefoneModel {
	int? id;
	int? idPessoa;
	String? tipo;
	String? numero;

	PessoaTelefoneModel({
		this.id,
		this.idPessoa,
		this.tipo,
		this.numero,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo',
		'numero',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo',
		'Numero',
	];

	PessoaTelefoneModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		tipo = PessoaTelefoneDomain.getTipo(jsonData['tipo']);
		numero = jsonData['numero'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['tipo'] = PessoaTelefoneDomain.setTipo(tipo);
		jsonData['numero'] = Util.removeMask(numero);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Fixo';
		numero = plutoRow.cells['numero']?.value;
	}	

	PessoaTelefoneModel clone() {
		return PessoaTelefoneModel(
			id: id,
			idPessoa: idPessoa,
			tipo: tipo,
			numero: numero,
		);			
	}

	
}