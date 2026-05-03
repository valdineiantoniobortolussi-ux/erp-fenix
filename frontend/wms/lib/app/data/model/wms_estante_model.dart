import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/data/model/model_imports.dart';

class WmsEstanteModel {
	int? id;
	int? idWmsRua;
	String? codigo;
	int? quantidadeCaixa;
	WmsRuaModel? wmsRuaModel;

	WmsEstanteModel({
		this.id,
		this.idWmsRua,
		this.codigo,
		this.quantidadeCaixa,
		this.wmsRuaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'quantidade_caixa',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Quantidade Caixa',
	];

	WmsEstanteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idWmsRua = jsonData['idWmsRua'];
		codigo = jsonData['codigo'];
		quantidadeCaixa = jsonData['quantidadeCaixa'];
		wmsRuaModel = jsonData['wmsRuaModel'] == null ? WmsRuaModel() : WmsRuaModel.fromJson(jsonData['wmsRuaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idWmsRua'] = idWmsRua != 0 ? idWmsRua : null;
		jsonData['codigo'] = codigo;
		jsonData['quantidadeCaixa'] = quantidadeCaixa;
		jsonData['wmsRuaModel'] = wmsRuaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idWmsRua = plutoRow.cells['idWmsRua']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		quantidadeCaixa = plutoRow.cells['quantidadeCaixa']?.value;
		wmsRuaModel = WmsRuaModel();
		wmsRuaModel?.nome = plutoRow.cells['wmsRuaModel']?.value;
	}	

	WmsEstanteModel clone() {
		return WmsEstanteModel(
			id: id,
			idWmsRua: idWmsRua,
			codigo: codigo,
			quantidadeCaixa: quantidadeCaixa,
		);			
	}

	
}