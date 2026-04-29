import 'dart:convert';

class AdmModuloModel {
	int? id;
	int? idEmpresa;
	String? codigo;
	String? bloco;
	String? nome;
	String? descricao;
	String? link;

	AdmModuloModel({
		this.id,
		this.idEmpresa,
		this.codigo,
		this.bloco,
		this.nome,
		this.descricao,
		this.link,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'bloco',
		'nome',
		'descricao',
    'link',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Bloco',
		'Nome',
		'Descricao',
		'Link',
	];

	AdmModuloModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idEmpresa = jsonData['idEmpresa'];
		codigo = jsonData['codigo'];
		bloco = jsonData['bloco'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		link = jsonData['link'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idEmpresa'] = idEmpresa != 0 ? idEmpresa : null;
		jsonData['codigo'] = codigo;
		jsonData['bloco'] = bloco;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['link'] = link;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}
	
}