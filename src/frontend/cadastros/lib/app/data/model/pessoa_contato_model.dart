import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class PessoaContatoModel {
	int? id;
	int? idPessoa;
	String? nome;
	String? email;
	String? observacao;

	PessoaContatoModel({
		this.id,
		this.idPessoa,
		this.nome,
		this.email,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'email',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Email',
		'Observacao',
	];

	PessoaContatoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPessoa = jsonData['idPessoa'];
		nome = jsonData['nome'];
		email = jsonData['email'];
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPessoa'] = idPessoa != 0 ? idPessoa : null;
		jsonData['nome'] = nome;
		jsonData['email'] = email;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPessoa = plutoRow.cells['idPessoa']?.value;
		nome = plutoRow.cells['nome']?.value;
		email = plutoRow.cells['email']?.value;
		observacao = plutoRow.cells['observacao']?.value;
	}	

	PessoaContatoModel clone() {
		return PessoaContatoModel(
			id: id,
			idPessoa: idPessoa,
			nome: nome,
			email: email,
			observacao: observacao,
		);			
	}

	
}