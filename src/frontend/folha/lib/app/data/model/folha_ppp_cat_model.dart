import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:intl/intl.dart';

class FolhaPppCatModel {
	int? id;
	int? idFolhaPpp;
	int? numeroCat;
	DateTime? dataAfastamento;
	DateTime? dataRegistro;

	FolhaPppCatModel({
		this.id,
		this.idFolhaPpp,
		this.numeroCat,
		this.dataAfastamento,
		this.dataRegistro,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero_cat',
		'data_afastamento',
		'data_registro',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero Cat',
		'Data Afastamento',
		'Data Registro',
	];

	FolhaPppCatModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFolhaPpp = jsonData['idFolhaPpp'];
		numeroCat = jsonData['numeroCat'];
		dataAfastamento = jsonData['dataAfastamento'] != null ? DateTime.tryParse(jsonData['dataAfastamento']) : null;
		dataRegistro = jsonData['dataRegistro'] != null ? DateTime.tryParse(jsonData['dataRegistro']) : null;
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFolhaPpp'] = idFolhaPpp != 0 ? idFolhaPpp : null;
		jsonData['numeroCat'] = numeroCat;
		jsonData['dataAfastamento'] = dataAfastamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataAfastamento!) : null;
		jsonData['dataRegistro'] = dataRegistro != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataRegistro!) : null;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFolhaPpp = plutoRow.cells['idFolhaPpp']?.value;
		numeroCat = plutoRow.cells['numeroCat']?.value;
		dataAfastamento = Util.stringToDate(plutoRow.cells['dataAfastamento']?.value);
		dataRegistro = Util.stringToDate(plutoRow.cells['dataRegistro']?.value);
	}	

	FolhaPppCatModel clone() {
		return FolhaPppCatModel(
			id: id,
			idFolhaPpp: idFolhaPpp,
			numeroCat: numeroCat,
			dataAfastamento: dataAfastamento,
			dataRegistro: dataRegistro,
		);			
	}

	
}