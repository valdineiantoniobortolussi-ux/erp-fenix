import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:contabil/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:contabil/app/data/domain/domain_imports.dart';

class PlanoContaRefSpedModel {
	int? id;
	String? codCtaRef;
	DateTime? inicioValidade;
	DateTime? fimValidade;
	String? tipo;
	String? descricao;
	String? orientacoes;

	PlanoContaRefSpedModel({
		this.id,
		this.codCtaRef,
		this.inicioValidade,
		this.fimValidade,
		this.tipo,
		this.descricao,
		this.orientacoes,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cod_cta_ref',
		'inicio_validade',
		'fim_validade',
		'tipo',
		'descricao',
		'orientacoes',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cod Cta Ref',
		'Inicio Validade',
		'Fim Validade',
		'Tipo',
		'Descricao',
		'Orientacoes',
	];

	PlanoContaRefSpedModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codCtaRef = jsonData['codCtaRef'];
		inicioValidade = jsonData['inicioValidade'] != null ? DateTime.tryParse(jsonData['inicioValidade']) : null;
		fimValidade = jsonData['fimValidade'] != null ? DateTime.tryParse(jsonData['fimValidade']) : null;
		tipo = PlanoContaRefSpedDomain.getTipo(jsonData['tipo']);
		descricao = jsonData['descricao'];
		orientacoes = jsonData['orientacoes'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codCtaRef'] = codCtaRef;
		jsonData['inicioValidade'] = inicioValidade != null ? DateFormat('yyyy-MM-ddT00:00:00').format(inicioValidade!) : null;
		jsonData['fimValidade'] = fimValidade != null ? DateFormat('yyyy-MM-ddT00:00:00').format(fimValidade!) : null;
		jsonData['tipo'] = PlanoContaRefSpedDomain.setTipo(tipo);
		jsonData['descricao'] = descricao;
		jsonData['orientacoes'] = orientacoes;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codCtaRef = plutoRow.cells['codCtaRef']?.value;
		inicioValidade = Util.stringToDate(plutoRow.cells['inicioValidade']?.value);
		fimValidade = Util.stringToDate(plutoRow.cells['fimValidade']?.value);
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Sintética';
		descricao = plutoRow.cells['descricao']?.value;
		orientacoes = plutoRow.cells['orientacoes']?.value;
	}	

	PlanoContaRefSpedModel clone() {
		return PlanoContaRefSpedModel(
			id: id,
			codCtaRef: codCtaRef,
			inicioValidade: inicioValidade,
			fimValidade: fimValidade,
			tipo: tipo,
			descricao: descricao,
			orientacoes: orientacoes,
		);			
	}

	
}