import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/model/model_imports.dart';
import 'package:cadastros/app/data/domain/domain_imports.dart';

class BancoContaCaixaModel {
	int? id;
	int? idBancoAgencia;
	String? numero;
	String? digito;
	String? nome;
	String? tipo;
	String? descricao;
	BancoAgenciaModel? bancoAgenciaModel;

	BancoContaCaixaModel({
		this.id,
		this.idBancoAgencia,
		this.numero,
		this.digito,
		this.nome,
		this.tipo,
		this.descricao,
		this.bancoAgenciaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'digito',
		'nome',
		'tipo',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Digito',
		'Nome',
		'Tipo',
		'Descricao',
	];

	BancoContaCaixaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBancoAgencia = jsonData['idBancoAgencia'];
		numero = jsonData['numero'];
		digito = jsonData['digito'];
		nome = jsonData['nome'];
		tipo = BancoContaCaixaDomain.getTipo(jsonData['tipo']);
		descricao = jsonData['descricao'];
		bancoAgenciaModel = jsonData['bancoAgenciaModel'] == null ? BancoAgenciaModel() : BancoAgenciaModel.fromJson(jsonData['bancoAgenciaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idBancoAgencia'] = idBancoAgencia != 0 ? idBancoAgencia : null;
		jsonData['numero'] = numero;
		jsonData['digito'] = digito;
		jsonData['nome'] = nome;
		jsonData['tipo'] = BancoContaCaixaDomain.setTipo(tipo);
		jsonData['descricao'] = descricao;
		jsonData['bancoAgenciaModel'] = bancoAgenciaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idBancoAgencia = plutoRow.cells['idBancoAgencia']?.value;
		numero = plutoRow.cells['numero']?.value;
		digito = plutoRow.cells['digito']?.value;
		nome = plutoRow.cells['nome']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Corrente';
		descricao = plutoRow.cells['descricao']?.value;
		bancoAgenciaModel = BancoAgenciaModel();
		bancoAgenciaModel?.nome = plutoRow.cells['bancoAgenciaModel']?.value;
	}	

	BancoContaCaixaModel clone() {
		return BancoContaCaixaModel(
			id: id,
			idBancoAgencia: idBancoAgencia,
			numero: numero,
			digito: digito,
			nome: nome,
			tipo: tipo,
			descricao: descricao,
		);			
	}

	
}