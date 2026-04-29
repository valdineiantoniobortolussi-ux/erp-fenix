import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/infra/infra_imports.dart';
import 'package:cadastros/app/data/model/model_imports.dart';

class BancoAgenciaModel {
	int? id;
	int? idBanco;
	String? nome;
	String? numero;
	String? digito;
	String? telefone;
	String? contato;
	String? gerente;
	String? observacao;
	BancoModel? bancoModel;

	BancoAgenciaModel({
		this.id,
		this.idBanco,
		this.nome,
		this.numero,
		this.digito,
		this.telefone,
		this.contato,
		this.gerente,
		this.observacao,
		this.bancoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'numero',
		'digito',
		'telefone',
		'contato',
		'gerente',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Numero',
		'Digito',
		'Telefone',
		'Contato',
		'Gerente',
		'Observacao',
	];

	BancoAgenciaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idBanco = jsonData['idBanco'];
		nome = jsonData['nome'];
		numero = jsonData['numero'];
		digito = jsonData['digito'];
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
		jsonData['nome'] = nome;
		jsonData['numero'] = numero;
		jsonData['digito'] = digito;
		jsonData['telefone'] = Util.removeMask(telefone);
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
		nome = plutoRow.cells['nome']?.value;
		numero = plutoRow.cells['numero']?.value;
		digito = plutoRow.cells['digito']?.value;
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
			nome: nome,
			numero: numero,
			digito: digito,
			telefone: telefone,
			contato: contato,
			gerente: gerente,
			observacao: observacao,
		);			
	}

	
}