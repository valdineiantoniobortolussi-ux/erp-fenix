import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class OperadoraPlanoSaudeModel {
	int? id;
	String? nome;
	String? registroAns;
	String? classificacaoContabilConta;

	OperadoraPlanoSaudeModel({
		this.id,
		this.nome,
		this.registroAns,
		this.classificacaoContabilConta,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'registro_ans',
		'classificacao_contabil_conta',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Registro Ans',
		'Classificacao Contabil Conta',
	];

	OperadoraPlanoSaudeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		registroAns = jsonData['registroAns'];
		classificacaoContabilConta = jsonData['classificacaoContabilConta'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['registroAns'] = registroAns;
		jsonData['classificacaoContabilConta'] = classificacaoContabilConta;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		registroAns = plutoRow.cells['registroAns']?.value;
		classificacaoContabilConta = plutoRow.cells['classificacaoContabilConta']?.value;
	}	

	OperadoraPlanoSaudeModel clone() {
		return OperadoraPlanoSaudeModel(
			id: id,
			nome: nome,
			registroAns: registroAns,
			classificacaoContabilConta: classificacaoContabilConta,
		);			
	}

	
}