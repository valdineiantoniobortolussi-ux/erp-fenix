import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/data/domain/domain_imports.dart';

class FinNaturezaFinanceiraModel {
	int? id;
	String? codigo;
	String? tipo;
	String? descricao;
	String? aplicacao;

	FinNaturezaFinanceiraModel({
		this.id,
		this.codigo,
		this.tipo,
		this.descricao,
		this.aplicacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'tipo',
		'descricao',
		'aplicacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Tipo',
		'Descricao',
		'Aplicacao',
	];

	FinNaturezaFinanceiraModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = jsonData['codigo'];
		tipo = FinNaturezaFinanceiraDomain.getTipo(jsonData['tipo']);
		descricao = jsonData['descricao'];
		aplicacao = jsonData['aplicacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = codigo;
		jsonData['tipo'] = FinNaturezaFinanceiraDomain.setTipo(tipo);
		jsonData['descricao'] = descricao;
		jsonData['aplicacao'] = aplicacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Receita';
		descricao = plutoRow.cells['descricao']?.value;
		aplicacao = plutoRow.cells['aplicacao']?.value;
	}	

	FinNaturezaFinanceiraModel clone() {
		return FinNaturezaFinanceiraModel(
			id: id,
			codigo: codigo,
			tipo: tipo,
			descricao: descricao,
			aplicacao: aplicacao,
		);			
	}

	
}