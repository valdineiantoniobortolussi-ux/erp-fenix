import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:orcamentos/app/data/domain/domain_imports.dart';

class FinNaturezaFinanceiraModel {
	int? id;
	String? codigo;
	String? descricao;
	String? tipo;
	String? aplicacao;

	FinNaturezaFinanceiraModel({
		this.id,
		this.codigo,
		this.descricao,
		this.tipo,
		this.aplicacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'descricao',
		'tipo',
		'aplicacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Descricao',
		'Tipo',
		'Aplicacao',
	];

	FinNaturezaFinanceiraModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = FinNaturezaFinanceiraDomain.getCodigo(jsonData['codigo']);
		descricao = jsonData['descricao'];
		tipo = FinNaturezaFinanceiraDomain.getTipo(jsonData['tipo']);
		aplicacao = jsonData['aplicacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = FinNaturezaFinanceiraDomain.setCodigo(codigo);
		jsonData['descricao'] = descricao;
		jsonData['tipo'] = FinNaturezaFinanceiraDomain.setTipo(tipo);
		jsonData['aplicacao'] = aplicacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value != '' ? plutoRow.cells['codigo']?.value : 'AAA';
		descricao = plutoRow.cells['descricao']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'AAA';
		aplicacao = plutoRow.cells['aplicacao']?.value;
	}	

	FinNaturezaFinanceiraModel clone() {
		return FinNaturezaFinanceiraModel(
			id: id,
			codigo: codigo,
			descricao: descricao,
			tipo: tipo,
			aplicacao: aplicacao,
		);			
	}

	
}