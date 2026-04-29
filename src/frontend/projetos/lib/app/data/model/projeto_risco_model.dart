import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class ProjetoRiscoModel {
	int? id;
	int? idProjetoPrincipal;
	String? nome;
	int? probabilidade;
	int? impacto;
	String? descricao;

	ProjetoRiscoModel({
		this.id,
		this.idProjetoPrincipal,
		this.nome,
		this.probabilidade,
		this.impacto,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'probabilidade',
		'impacto',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Probabilidade',
		'Impacto',
		'Descricao',
	];

	ProjetoRiscoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProjetoPrincipal = jsonData['idProjetoPrincipal'];
		nome = jsonData['nome'];
		probabilidade = jsonData['probabilidade'];
		impacto = jsonData['impacto'];
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProjetoPrincipal'] = idProjetoPrincipal != 0 ? idProjetoPrincipal : null;
		jsonData['nome'] = nome;
		jsonData['probabilidade'] = probabilidade;
		jsonData['impacto'] = impacto;
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProjetoPrincipal = plutoRow.cells['idProjetoPrincipal']?.value;
		nome = plutoRow.cells['nome']?.value;
		probabilidade = plutoRow.cells['probabilidade']?.value;
		impacto = plutoRow.cells['impacto']?.value;
		descricao = plutoRow.cells['descricao']?.value;
	}	

	ProjetoRiscoModel clone() {
		return ProjetoRiscoModel(
			id: id,
			idProjetoPrincipal: idProjetoPrincipal,
			nome: nome,
			probabilidade: probabilidade,
			impacto: impacto,
			descricao: descricao,
		);			
	}

	
}