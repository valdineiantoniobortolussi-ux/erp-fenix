import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:projetos/app/data/model/model_imports.dart';

class ProjetoStakeholdersModel {
	int? id;
	int? idProjetoPrincipal;
	int? idColaborador;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	ProjetoStakeholdersModel({
		this.id,
		this.idProjetoPrincipal,
		this.idColaborador,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
	];

	ProjetoStakeholdersModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idProjetoPrincipal = jsonData['idProjetoPrincipal'];
		idColaborador = jsonData['idColaborador'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idProjetoPrincipal'] = idProjetoPrincipal != 0 ? idProjetoPrincipal : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idProjetoPrincipal = plutoRow.cells['idProjetoPrincipal']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	ProjetoStakeholdersModel clone() {
		return ProjetoStakeholdersModel(
			id: id,
			idProjetoPrincipal: idProjetoPrincipal,
			idColaborador: idColaborador,
		);			
	}

	
}