import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class EmpresaTransporteItinerarioModel {
	int? id;
	int? idEmpresaTransporte;
	String? nome;
	double? tarifa;
	String? trajeto;

	EmpresaTransporteItinerarioModel({
		this.id,
		this.idEmpresaTransporte,
		this.nome,
		this.tarifa,
		this.trajeto,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'tarifa',
		'trajeto',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Tarifa',
		'Trajeto',
	];

	EmpresaTransporteItinerarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idEmpresaTransporte = jsonData['idEmpresaTransporte'];
		nome = jsonData['nome'];
		tarifa = jsonData['tarifa']?.toDouble();
		trajeto = jsonData['trajeto'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idEmpresaTransporte'] = idEmpresaTransporte != 0 ? idEmpresaTransporte : null;
		jsonData['nome'] = nome;
		jsonData['tarifa'] = tarifa;
		jsonData['trajeto'] = trajeto;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idEmpresaTransporte = plutoRow.cells['idEmpresaTransporte']?.value;
		nome = plutoRow.cells['nome']?.value;
		tarifa = plutoRow.cells['tarifa']?.value?.toDouble();
		trajeto = plutoRow.cells['trajeto']?.value;
	}	

	EmpresaTransporteItinerarioModel clone() {
		return EmpresaTransporteItinerarioModel(
			id: id,
			idEmpresaTransporte: idEmpresaTransporte,
			nome: nome,
			tarifa: tarifa,
			trajeto: trajeto,
		);			
	}

	
}