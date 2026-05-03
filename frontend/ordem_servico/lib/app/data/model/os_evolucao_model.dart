import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ordem_servico/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:ordem_servico/app/data/domain/domain_imports.dart';

class OsEvolucaoModel {
	int? id;
	int? idOsAbertura;
	DateTime? dataRegistro;
	String? horaRegistro;
	String? enviarEmail;
	String? observacao;

	OsEvolucaoModel({
		this.id,
		this.idOsAbertura,
		this.dataRegistro,
		this.horaRegistro,
		this.enviarEmail,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_registro',
		'hora_registro',
		'enviar_email',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Registro',
		'Hora Registro',
		'Enviar Email',
		'Observacao',
	];

	OsEvolucaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOsAbertura = jsonData['idOsAbertura'];
		dataRegistro = jsonData['dataRegistro'] != null ? DateTime.tryParse(jsonData['dataRegistro']) : null;
		horaRegistro = jsonData['horaRegistro'];
		enviarEmail = OsEvolucaoDomain.getEnviarEmail(jsonData['enviarEmail']);
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idOsAbertura'] = idOsAbertura != 0 ? idOsAbertura : null;
		jsonData['dataRegistro'] = dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRegistro!) : null;
		jsonData['horaRegistro'] = Util.removeMask(horaRegistro);
		jsonData['enviarEmail'] = OsEvolucaoDomain.setEnviarEmail(enviarEmail);
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idOsAbertura = plutoRow.cells['idOsAbertura']?.value;
		dataRegistro = Util.stringToDate(plutoRow.cells['dataRegistro']?.value);
		horaRegistro = plutoRow.cells['horaRegistro']?.value;
		enviarEmail = plutoRow.cells['enviarEmail']?.value != '' ? plutoRow.cells['enviarEmail']?.value : 'S';
		observacao = plutoRow.cells['observacao']?.value;
	}	

	OsEvolucaoModel clone() {
		return OsEvolucaoModel(
			id: id,
			idOsAbertura: idOsAbertura,
			dataRegistro: dataRegistro,
			horaRegistro: horaRegistro,
			enviarEmail: enviarEmail,
			observacao: observacao,
		);			
	}

	
}