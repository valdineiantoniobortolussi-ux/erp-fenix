import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ordem_servico/app/data/model/model_imports.dart';
import 'package:ordem_servico/app/data/domain/domain_imports.dart';

class OsAberturaEquipamentoModel {
	int? id;
	int? idOsAbertura;
	int? idOsEquipamento;
	String? tipoCobertura;
	String? numeroSerie;
	OsEquipamentoModel? osEquipamentoModel;

	OsAberturaEquipamentoModel({
		this.id,
		this.idOsAbertura,
		this.idOsEquipamento,
		this.tipoCobertura,
		this.numeroSerie,
		this.osEquipamentoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'tipo_cobertura',
		'numero_serie',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Tipo Cobertura',
		'Numero Serie',
	];

	OsAberturaEquipamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idOsAbertura = jsonData['idOsAbertura'];
		idOsEquipamento = jsonData['idOsEquipamento'];
		tipoCobertura = OsAberturaEquipamentoDomain.getTipoCobertura(jsonData['tipoCobertura']);
		numeroSerie = jsonData['numeroSerie'];
		osEquipamentoModel = jsonData['osEquipamentoModel'] == null ? OsEquipamentoModel() : OsEquipamentoModel.fromJson(jsonData['osEquipamentoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idOsAbertura'] = idOsAbertura != 0 ? idOsAbertura : null;
		jsonData['idOsEquipamento'] = idOsEquipamento != 0 ? idOsEquipamento : null;
		jsonData['tipoCobertura'] = OsAberturaEquipamentoDomain.setTipoCobertura(tipoCobertura);
		jsonData['numeroSerie'] = numeroSerie;
		jsonData['osEquipamentoModel'] = osEquipamentoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idOsAbertura = plutoRow.cells['idOsAbertura']?.value;
		idOsEquipamento = plutoRow.cells['idOsEquipamento']?.value;
		tipoCobertura = plutoRow.cells['tipoCobertura']?.value != '' ? plutoRow.cells['tipoCobertura']?.value : 'Nenhum';
		numeroSerie = plutoRow.cells['numeroSerie']?.value;
		osEquipamentoModel = OsEquipamentoModel();
		osEquipamentoModel?.nome = plutoRow.cells['osEquipamentoModel']?.value;
	}	

	OsAberturaEquipamentoModel clone() {
		return OsAberturaEquipamentoModel(
			id: id,
			idOsAbertura: idOsAbertura,
			idOsEquipamento: idOsEquipamento,
			tipoCobertura: tipoCobertura,
			numeroSerie: numeroSerie,
		);			
	}

	
}