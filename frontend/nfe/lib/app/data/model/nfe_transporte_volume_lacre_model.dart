import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/model/model_imports.dart';

class NfeTransporteVolumeLacreModel {
	int? id;
	int? idNfeTransporteVolume;
	String? numero;
	NfeTransporteVolumeModel? nfeTransporteVolumeModel;

	NfeTransporteVolumeLacreModel({
		this.id,
		this.idNfeTransporteVolume,
		this.numero,
		this.nfeTransporteVolumeModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
	];

	NfeTransporteVolumeLacreModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeTransporteVolume = jsonData['idNfeTransporteVolume'];
		numero = jsonData['numero'];
		nfeTransporteVolumeModel = jsonData['nfeTransporteVolumeModel'] == null ? NfeTransporteVolumeModel() : NfeTransporteVolumeModel.fromJson(jsonData['nfeTransporteVolumeModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeTransporteVolume'] = idNfeTransporteVolume != 0 ? idNfeTransporteVolume : null;
		jsonData['numero'] = numero;
		jsonData['nfeTransporteVolumeModel'] = nfeTransporteVolumeModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeTransporteVolume = plutoRow.cells['idNfeTransporteVolume']?.value;
		numero = plutoRow.cells['numero']?.value;
		nfeTransporteVolumeModel = NfeTransporteVolumeModel();
		nfeTransporteVolumeModel?.numeracao = plutoRow.cells['nfeTransporteVolumeModel']?.value;
	}	

	NfeTransporteVolumeLacreModel clone() {
		return NfeTransporteVolumeLacreModel(
			id: id,
			idNfeTransporteVolume: idNfeTransporteVolume,
			numero: numero,
		);			
	}

	
}