import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/data/model/model_imports.dart';

class CteInfNfCargaLacreModel {
	int? id;
	int? idCteInformacaoNfCarga;
	String? numero;
	double? quantidadeRateada;
	CteInformacaoNfCargaModel? cteInformacaoNfCargaModel;

	CteInfNfCargaLacreModel({
		this.id,
		this.idCteInformacaoNfCarga,
		this.numero,
		this.quantidadeRateada,
		this.cteInformacaoNfCargaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'numero',
		'quantidade_rateada',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Numero',
		'Quantidade Rateada',
	];

	CteInfNfCargaLacreModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteInformacaoNfCarga = jsonData['idCteInformacaoNfCarga'];
		numero = jsonData['numero'];
		quantidadeRateada = jsonData['quantidadeRateada']?.toDouble();
		cteInformacaoNfCargaModel = jsonData['cteInformacaoNfCargaModel'] == null ? CteInformacaoNfCargaModel() : CteInformacaoNfCargaModel.fromJson(jsonData['cteInformacaoNfCargaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteInformacaoNfCarga'] = idCteInformacaoNfCarga != 0 ? idCteInformacaoNfCarga : null;
		jsonData['numero'] = numero;
		jsonData['quantidadeRateada'] = quantidadeRateada;
		jsonData['cteInformacaoNfCargaModel'] = cteInformacaoNfCargaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteInformacaoNfCarga = plutoRow.cells['idCteInformacaoNfCarga']?.value;
		numero = plutoRow.cells['numero']?.value;
		quantidadeRateada = plutoRow.cells['quantidadeRateada']?.value?.toDouble();
		cteInformacaoNfCargaModel = CteInformacaoNfCargaModel();
		cteInformacaoNfCargaModel?.tipoUnidadeCarga = plutoRow.cells['cteInformacaoNfCargaModel']?.value;
	}	

	CteInfNfCargaLacreModel clone() {
		return CteInfNfCargaLacreModel(
			id: id,
			idCteInformacaoNfCarga: idCteInformacaoNfCarga,
			numero: numero,
			quantidadeRateada: quantidadeRateada,
		);			
	}

	
}