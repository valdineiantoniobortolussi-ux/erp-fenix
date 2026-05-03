import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:financeiro/app/data/model/model_imports.dart';

class BancoAgenciaModel {
	int? id;
	int? idBanco;
	String? numero;
	String? digito;
	String? nome;
	String? telefone;
	String? contato;
	String? gerente;
	String? observacao;
	BancoModel? bancoModel;

	BancoAgenciaModel({
		this.id,
		this.idBanco,
		this.numero,
		this.digito,
		this.nome,
		this.telefone,
		this.contato,
		this.gerente,
		this.observacao,
		this.bancoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'digito',
		'nome',
		'telefone',
		'contato',
		'gerente',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Digito',
		'Nome',
		'Telefone',
		'Contato',
		'Gerente',
		'Observacao',
	];

	BancoAgenciaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBanco = jsonData['idBanco'];
		numero = jsonData['numero'];
		digito = jsonData['digito'];
		nome = jsonData['nome'];
		telefone = jsonData['telefone'];
		contato = jsonData['contato'];
		gerente = jsonData['gerente'];
		observacao = jsonData['observacao'];
		bancoModel = jsonData['bancoModel'] == null ? BancoModel() : BancoModel.fromJson(jsonData['bancoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idBanco'] = idBanco != 0 ? idBanco : null;
		jsonData['numero'] = numero;
		jsonData['digito'] = digito;
		jsonData['nome'] = nome;
		jsonData['telefone'] = telefone;
		jsonData['contato'] = contato;
		jsonData['gerente'] = gerente;
		jsonData['observacao'] = observacao;
		jsonData['bancoModel'] = bancoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idBanco = plutoRow.cells['idBanco']?.value;
		numero = plutoRow.cells['numero']?.value;
		digito = plutoRow.cells['digito']?.value;
		nome = plutoRow.cells['nome']?.value;
		telefone = plutoRow.cells['telefone']?.value;
		contato = plutoRow.cells['contato']?.value;
		gerente = plutoRow.cells['gerente']?.value;
		observacao = plutoRow.cells['observacao']?.value;
		bancoModel = BancoModel();
		bancoModel?.nome = plutoRow.cells['bancoModel']?.value;
	}	

	BancoAgenciaModel clone() {
		return BancoAgenciaModel(
			id: id,
			idBanco: idBanco,
			numero: numero,
			digito: digito,
			nome: nome,
			telefone: telefone,
			contato: contato,
			gerente: gerente,
			observacao: observacao,
		);			
	}

	
}