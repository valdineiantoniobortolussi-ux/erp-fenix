import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class ReuniaoSalaEventoModel {
	int? id;
	int? idAgendaCompromisso;
	int? idReuniaoSala;
	DateTime? dataReserva;
	ReuniaoSalaModel? reuniaoSalaModel;

	ReuniaoSalaEventoModel({
		this.id,
		this.idAgendaCompromisso,
		this.idReuniaoSala,
		this.dataReserva,
		this.reuniaoSalaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_reserva',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Reserva',
	];

	ReuniaoSalaEventoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idAgendaCompromisso = jsonData['idAgendaCompromisso'];
		idReuniaoSala = jsonData['idReuniaoSala'];
		dataReserva = jsonData['dataReserva'] != null ? DateTime.tryParse(jsonData['dataReserva']) : null;
		reuniaoSalaModel = jsonData['reuniaoSalaModel'] == null ? ReuniaoSalaModel() : ReuniaoSalaModel.fromJson(jsonData['reuniaoSalaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idAgendaCompromisso'] = idAgendaCompromisso != 0 ? idAgendaCompromisso : null;
		jsonData['idReuniaoSala'] = idReuniaoSala != 0 ? idReuniaoSala : null;
		jsonData['dataReserva'] = dataReserva != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataReserva!) : null;
		jsonData['reuniaoSalaModel'] = reuniaoSalaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idAgendaCompromisso = plutoRow.cells['idAgendaCompromisso']?.value;
		idReuniaoSala = plutoRow.cells['idReuniaoSala']?.value;
		dataReserva = Util.stringToDate(plutoRow.cells['dataReserva']?.value);
		reuniaoSalaModel = ReuniaoSalaModel();
		reuniaoSalaModel?.nome = plutoRow.cells['reuniaoSalaModel']?.value;
	}	

	ReuniaoSalaEventoModel clone() {
		return ReuniaoSalaEventoModel(
			id: id,
			idAgendaCompromisso: idAgendaCompromisso,
			idReuniaoSala: idReuniaoSala,
			dataReserva: dataReserva,
		);			
	}

	
}