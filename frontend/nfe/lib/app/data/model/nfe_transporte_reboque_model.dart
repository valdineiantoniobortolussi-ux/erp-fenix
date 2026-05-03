import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/model/model_imports.dart';
import 'package:nfe/app/data/domain/domain_imports.dart';

class NfeTransporteReboqueModel {
	int? id;
	int? idNfeTransporte;
	String? placa;
	String? uf;
	String? rntc;
	String? vagao;
	String? balsa;
	NfeTransporteModel? nfeTransporteModel;

	NfeTransporteReboqueModel({
		this.id,
		this.idNfeTransporte,
		this.placa,
		this.uf,
		this.rntc,
		this.vagao,
		this.balsa,
		this.nfeTransporteModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'placa',
		'uf',
		'rntc',
		'vagao',
		'balsa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Placa',
		'Uf',
		'Rntc',
		'Vagao',
		'Balsa',
	];

	NfeTransporteReboqueModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeTransporte = jsonData['idNfeTransporte'];
		placa = jsonData['placa'];
		uf = NfeTransporteReboqueDomain.getUf(jsonData['uf']);
		rntc = jsonData['rntc'];
		vagao = jsonData['vagao'];
		balsa = jsonData['balsa'];
		nfeTransporteModel = jsonData['nfeTransporteModel'] == null ? NfeTransporteModel() : NfeTransporteModel.fromJson(jsonData['nfeTransporteModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeTransporte'] = idNfeTransporte != 0 ? idNfeTransporte : null;
		jsonData['placa'] = placa;
		jsonData['uf'] = NfeTransporteReboqueDomain.setUf(uf);
		jsonData['rntc'] = rntc;
		jsonData['vagao'] = vagao;
		jsonData['balsa'] = balsa;
		jsonData['nfeTransporteModel'] = nfeTransporteModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeTransporte = plutoRow.cells['idNfeTransporte']?.value;
		placa = plutoRow.cells['placa']?.value;
		uf = plutoRow.cells['uf']?.value != '' ? plutoRow.cells['uf']?.value : 'AC';
		rntc = plutoRow.cells['rntc']?.value;
		vagao = plutoRow.cells['vagao']?.value;
		balsa = plutoRow.cells['balsa']?.value;
		nfeTransporteModel = NfeTransporteModel();
		nfeTransporteModel?.cnpj = plutoRow.cells['nfeTransporteModel']?.value;
	}	

	NfeTransporteReboqueModel clone() {
		return NfeTransporteReboqueModel(
			id: id,
			idNfeTransporte: idNfeTransporte,
			placa: placa,
			uf: uf,
			rntc: rntc,
			vagao: vagao,
			balsa: balsa,
		);			
	}

	
}