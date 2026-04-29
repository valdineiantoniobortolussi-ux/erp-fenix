import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class MdfeRodoviarioModel {
	int? id;
	int? idMdfeCabecalho;
	String? rntrc;
	String? codigoAgendamento;

	MdfeRodoviarioModel({
		this.id,
		this.idMdfeCabecalho,
		this.rntrc,
		this.codigoAgendamento,
	});

	static List<String> dbColumns = <String>[
		'id',
		'rntrc',
		'codigo_agendamento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Rntrc',
		'Codigo Agendamento',
	];

	MdfeRodoviarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeCabecalho = jsonData['idMdfeCabecalho'];
		rntrc = jsonData['rntrc'];
		codigoAgendamento = jsonData['codigoAgendamento'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeCabecalho'] = idMdfeCabecalho != 0 ? idMdfeCabecalho : null;
		jsonData['rntrc'] = rntrc;
		jsonData['codigoAgendamento'] = codigoAgendamento;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeCabecalho = plutoRow.cells['idMdfeCabecalho']?.value;
		rntrc = plutoRow.cells['rntrc']?.value;
		codigoAgendamento = plutoRow.cells['codigoAgendamento']?.value;
	}	

	MdfeRodoviarioModel clone() {
		return MdfeRodoviarioModel(
			id: id,
			idMdfeCabecalho: idMdfeCabecalho,
			rntrc: rntrc,
			codigoAgendamento: codigoAgendamento,
		);			
	}

	
}