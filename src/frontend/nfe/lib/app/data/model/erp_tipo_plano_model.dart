import 'dart:convert';

class ErpTipoPlanoModel {
	int? id;
	String? nome;
	double? valor;
	String? frequencia;
	bool? acessoTotal;
	bool? ativo;

	ErpTipoPlanoModel({
		this.id,
		this.nome,
		this.valor,
		this.frequencia,
		this.acessoTotal,
		this.ativo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'valor',
		'frequencia',
		'acesso_total',
		'ativo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Valor',
		'Frequencia',
		'Acesso Total',
		'Ativo',
	];

	ErpTipoPlanoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		valor = jsonData['valor']?.toDouble();
		frequencia = jsonData['frequencia'];
		acessoTotal = jsonData['acessoTotal'];
		ativo = jsonData['ativo'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['valor'] = valor;
		jsonData['frequencia'] = frequencia;
		jsonData['acessoTotal'] = acessoTotal;
		jsonData['ativo'] = ativo;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}
	
}