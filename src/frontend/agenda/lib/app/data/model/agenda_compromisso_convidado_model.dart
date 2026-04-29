import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:agenda/app/data/model/model_imports.dart';

class AgendaCompromissoConvidadoModel {
	int? id;
	int? idAgendaCompromisso;
	int? idColaborador;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	AgendaCompromissoConvidadoModel({
		this.id,
		this.idAgendaCompromisso,
		this.idColaborador,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
	];

	AgendaCompromissoConvidadoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idAgendaCompromisso = jsonData['idAgendaCompromisso'];
		idColaborador = jsonData['idColaborador'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idAgendaCompromisso'] = idAgendaCompromisso != 0 ? idAgendaCompromisso : null;
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
		idAgendaCompromisso = plutoRow.cells['idAgendaCompromisso']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	AgendaCompromissoConvidadoModel clone() {
		return AgendaCompromissoConvidadoModel(
			id: id,
			idAgendaCompromisso: idAgendaCompromisso,
			idColaborador: idColaborador,
		);			
	}

	
}