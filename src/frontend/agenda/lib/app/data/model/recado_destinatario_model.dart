import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:agenda/app/data/model/model_imports.dart';

class RecadoDestinatarioModel {
	int? id;
	int? idRecadoRemetente;
	int? idColaborador;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	RecadoDestinatarioModel({
		this.id,
		this.idRecadoRemetente,
		this.idColaborador,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
	];

	RecadoDestinatarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idRecadoRemetente = jsonData['idRecadoRemetente'];
		idColaborador = jsonData['idColaborador'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idRecadoRemetente'] = idRecadoRemetente != 0 ? idRecadoRemetente : null;
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
		idRecadoRemetente = plutoRow.cells['idRecadoRemetente']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	RecadoDestinatarioModel clone() {
		return RecadoDestinatarioModel(
			id: id,
			idRecadoRemetente: idRecadoRemetente,
			idColaborador: idColaborador,
		);			
	}

	
}