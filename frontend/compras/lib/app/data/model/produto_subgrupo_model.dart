import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/data/model/model_imports.dart';

class ProdutoSubgrupoModel {
	int? id;
	int? idProdutoGrupo;
	String? nome;
	String? descricao;
	ProdutoGrupoModel? produtoGrupoModel;

	ProdutoSubgrupoModel({
		this.id,
		this.idProdutoGrupo,
		this.nome,
		this.descricao,
		this.produtoGrupoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
	];

	ProdutoSubgrupoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProdutoGrupo = jsonData['idProdutoGrupo'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		produtoGrupoModel = jsonData['produtoGrupoModel'] == null ? ProdutoGrupoModel() : ProdutoGrupoModel.fromJson(jsonData['produtoGrupoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProdutoGrupo'] = idProdutoGrupo != 0 ? idProdutoGrupo : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['produtoGrupoModel'] = produtoGrupoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProdutoGrupo = plutoRow.cells['idProdutoGrupo']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		produtoGrupoModel = ProdutoGrupoModel();
		produtoGrupoModel?.nome = plutoRow.cells['produtoGrupoModel']?.value;
	}	

	ProdutoSubgrupoModel clone() {
		return ProdutoSubgrupoModel(
			id: id,
			idProdutoGrupo: idProdutoGrupo,
			nome: nome,
			descricao: descricao,
		);			
	}

	
}