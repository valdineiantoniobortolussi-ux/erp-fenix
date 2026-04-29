import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/domain/domain_imports.dart';

class PapelFuncaoModel {
	int? id;
	int? idPapel;
	int? idFuncao;
	String? habilitado;
	String? podeInserir;
	String? podeAlterar;
	String? podeExcluir;

	PapelFuncaoModel({
		this.id,
		this.idPapel,
		this.idFuncao,
		this.habilitado,
		this.podeInserir,
		this.podeAlterar,
		this.podeExcluir,
	});

	static List<String> dbColumns = <String>[
		'id',
		'habilitado',
		'pode_inserir',
		'pode_alterar',
		'pode_excluir',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Habilitado',
		'Pode Inserir',
		'Pode Alterar',
		'Pode Excluir',
	];

	PapelFuncaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPapel = jsonData['idPapel'];
		idFuncao = jsonData['idFuncao'];
		habilitado = PapelFuncaoDomain.getHabilitado(jsonData['habilitado']);
		podeInserir = PapelFuncaoDomain.getPodeInserir(jsonData['podeInserir']);
		podeAlterar = PapelFuncaoDomain.getPodeAlterar(jsonData['podeAlterar']);
		podeExcluir = PapelFuncaoDomain.getPodeExcluir(jsonData['podeExcluir']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPapel'] = idPapel != 0 ? idPapel : null;
		jsonData['idFuncao'] = idFuncao != 0 ? idFuncao : null;
		jsonData['habilitado'] = PapelFuncaoDomain.setHabilitado(habilitado);
		jsonData['podeInserir'] = PapelFuncaoDomain.setPodeInserir(podeInserir);
		jsonData['podeAlterar'] = PapelFuncaoDomain.setPodeAlterar(podeAlterar);
		jsonData['podeExcluir'] = PapelFuncaoDomain.setPodeExcluir(podeExcluir);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPapel = plutoRow.cells['idPapel']?.value;
		idFuncao = plutoRow.cells['idFuncao']?.value;
		habilitado = plutoRow.cells['habilitado']?.value != '' ? plutoRow.cells['habilitado']?.value : 'Sim';
		podeInserir = plutoRow.cells['podeInserir']?.value != '' ? plutoRow.cells['podeInserir']?.value : 'Sim';
		podeAlterar = plutoRow.cells['podeAlterar']?.value != '' ? plutoRow.cells['podeAlterar']?.value : 'Sim';
		podeExcluir = plutoRow.cells['podeExcluir']?.value != '' ? plutoRow.cells['podeExcluir']?.value : 'Sim';
	}	

	PapelFuncaoModel clone() {
		return PapelFuncaoModel(
			id: id,
			idPapel: idPapel,
			idFuncao: idFuncao,
			habilitado: habilitado,
			podeInserir: podeInserir,
			podeAlterar: podeAlterar,
			podeExcluir: podeExcluir,
		);			
	}

	
}