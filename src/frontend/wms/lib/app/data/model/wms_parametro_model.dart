import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/data/domain/domain_imports.dart';

class WmsParametroModel {
	int? id;
	int? horaPorVolume;
	int? pessoaPorVolume;
	int? horaPorPeso;
	int? pessoaPorPeso;
	String? itemDiferenteCaixa;

	WmsParametroModel({
		this.id,
		this.horaPorVolume,
		this.pessoaPorVolume,
		this.horaPorPeso,
		this.pessoaPorPeso,
		this.itemDiferenteCaixa,
	});

	static List<String> dbColumns = <String>[
		'id',
		'hora_por_volume',
		'pessoa_por_volume',
		'hora_por_peso',
		'pessoa_por_peso',
		'item_diferente_caixa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Hora Por Volume',
		'Pessoa Por Volume',
		'Hora Por Peso',
		'Pessoa Por Peso',
		'Item Diferente Caixa',
	];

	WmsParametroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		horaPorVolume = jsonData['horaPorVolume'];
		pessoaPorVolume = jsonData['pessoaPorVolume'];
		horaPorPeso = jsonData['horaPorPeso'];
		pessoaPorPeso = jsonData['pessoaPorPeso'];
		itemDiferenteCaixa = WmsParametroDomain.getItemDiferenteCaixa(jsonData['itemDiferenteCaixa']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['horaPorVolume'] = horaPorVolume;
		jsonData['pessoaPorVolume'] = pessoaPorVolume;
		jsonData['horaPorPeso'] = horaPorPeso;
		jsonData['pessoaPorPeso'] = pessoaPorPeso;
		jsonData['itemDiferenteCaixa'] = WmsParametroDomain.setItemDiferenteCaixa(itemDiferenteCaixa);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		horaPorVolume = plutoRow.cells['horaPorVolume']?.value;
		pessoaPorVolume = plutoRow.cells['pessoaPorVolume']?.value;
		horaPorPeso = plutoRow.cells['horaPorPeso']?.value;
		pessoaPorPeso = plutoRow.cells['pessoaPorPeso']?.value;
		itemDiferenteCaixa = plutoRow.cells['itemDiferenteCaixa']?.value != '' ? plutoRow.cells['itemDiferenteCaixa']?.value : 'S';
	}	

	WmsParametroModel clone() {
		return WmsParametroModel(
			id: id,
			horaPorVolume: horaPorVolume,
			pessoaPorVolume: pessoaPorVolume,
			horaPorPeso: horaPorPeso,
			pessoaPorPeso: pessoaPorPeso,
			itemDiferenteCaixa: itemDiferenteCaixa,
		);			
	}

	
}