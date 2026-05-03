import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:agenda/app/data/domain/domain_imports.dart';

class AgendaNotificacaoModel {
	int? id;
	int? idAgendaCompromisso;
	DateTime? dataNotificacao;
	String? hora;
	String? tipo;

	AgendaNotificacaoModel({
		this.id,
		this.idAgendaCompromisso,
		this.dataNotificacao,
		this.hora,
		this.tipo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_notificacao',
		'hora',
		'tipo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Notificacao',
		'Hora',
		'Tipo',
	];

	AgendaNotificacaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idAgendaCompromisso = jsonData['idAgendaCompromisso'];
		dataNotificacao = jsonData['dataNotificacao'] != null ? DateTime.tryParse(jsonData['dataNotificacao']) : null;
		hora = jsonData['hora'];
		tipo = AgendaNotificacaoDomain.getTipo(jsonData['tipo']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idAgendaCompromisso'] = idAgendaCompromisso != 0 ? idAgendaCompromisso : null;
		jsonData['dataNotificacao'] = dataNotificacao != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataNotificacao!) : null;
		jsonData['hora'] = Util.removeMask(hora);
		jsonData['tipo'] = AgendaNotificacaoDomain.setTipo(tipo);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idAgendaCompromisso = plutoRow.cells['idAgendaCompromisso']?.value;
		dataNotificacao = Util.stringToDate(plutoRow.cells['dataNotificacao']?.value);
		hora = plutoRow.cells['hora']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Email';
	}	

	AgendaNotificacaoModel clone() {
		return AgendaNotificacaoModel(
			id: id,
			idAgendaCompromisso: idAgendaCompromisso,
			dataNotificacao: dataNotificacao,
			hora: hora,
			tipo: tipo,
		);			
	}

	
}