import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinStatusParcelaModel {
	int? id;
	String? situacao;
	String? descricao;
	String? procedimento;

	FinStatusParcelaModel({
		this.id,
		this.situacao,
		this.descricao,
		this.procedimento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'situacao',
		'descricao',
		'procedimento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Situacao',
		'Descricao',
		'Procedimento',
	];

	FinStatusParcelaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		situacao = FinStatusParcelaDomain.getSituacao(jsonData['situacao']);
		descricao = jsonData['descricao'];
		procedimento = jsonData['procedimento'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['situacao'] = FinStatusParcelaDomain.setSituacao(situacao);
		jsonData['descricao'] = descricao;
		jsonData['procedimento'] = procedimento;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		situacao = plutoRow.cells['situacao']?.value != '' ? plutoRow.cells['situacao']?.value : '01 = Aberto';
		descricao = plutoRow.cells['descricao']?.value;
		procedimento = plutoRow.cells['procedimento']?.value;
	}	

	FinStatusParcelaModel clone() {
		return FinStatusParcelaModel(
			id: id,
			situacao: situacao,
			descricao: descricao,
			procedimento: procedimento,
		);			
	}

	
}