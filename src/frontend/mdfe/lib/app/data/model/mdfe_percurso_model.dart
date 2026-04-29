import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';
import 'package:mdfe/app/data/domain/domain_imports.dart';

class MdfePercursoModel {
	int? id;
	int? idMdfeCabecalho;
	String? ufPercurso;
	DateTime? dataInicioViagem;

	MdfePercursoModel({
		this.id,
		this.idMdfeCabecalho,
		this.ufPercurso,
		this.dataInicioViagem,
	});

	static List<String> dbColumns = <String>[
		'id',
		'uf_percurso',
		'data_inicio_viagem',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Uf Percurso',
		'Data Inicio Viagem',
	];

	MdfePercursoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeCabecalho = jsonData['idMdfeCabecalho'];
		ufPercurso = MdfePercursoDomain.getUfPercurso(jsonData['ufPercurso']);
		dataInicioViagem = jsonData['dataInicioViagem'] != null ? DateTime.tryParse(jsonData['dataInicioViagem']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeCabecalho'] = idMdfeCabecalho != 0 ? idMdfeCabecalho : null;
		jsonData['ufPercurso'] = MdfePercursoDomain.setUfPercurso(ufPercurso);
		jsonData['dataInicioViagem'] = dataInicioViagem != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicioViagem!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeCabecalho = plutoRow.cells['idMdfeCabecalho']?.value;
		ufPercurso = plutoRow.cells['ufPercurso']?.value != '' ? plutoRow.cells['ufPercurso']?.value : 'AC';
		dataInicioViagem = Util.stringToDate(plutoRow.cells['dataInicioViagem']?.value);
	}	

	MdfePercursoModel clone() {
		return MdfePercursoModel(
			id: id,
			idMdfeCabecalho: idMdfeCabecalho,
			ufPercurso: ufPercurso,
			dataInicioViagem: dataInicioViagem,
		);			
	}

	
}