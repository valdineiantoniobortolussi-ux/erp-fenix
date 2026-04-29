import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:wms/app/data/model/model_imports.dart';

class WmsArmazenamentoModel {
	int? id;
	int? idWmsCaixa;
	int? idWmsRecebimentoDetalhe;
	int? quantidade;
	WmsRecebimentoDetalheModel? wmsRecebimentoDetalheModel;

	WmsArmazenamentoModel({
		this.id,
		this.idWmsCaixa,
		this.idWmsRecebimentoDetalhe,
		this.quantidade,
		this.wmsRecebimentoDetalheModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'quantidade',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Quantidade',
	];

	WmsArmazenamentoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idWmsCaixa = jsonData['idWmsCaixa'];
		idWmsRecebimentoDetalhe = jsonData['idWmsRecebimentoDetalhe'];
		quantidade = jsonData['quantidade'];
		wmsRecebimentoDetalheModel = jsonData['wmsRecebimentoDetalheModel'] == null ? WmsRecebimentoDetalheModel() : WmsRecebimentoDetalheModel.fromJson(jsonData['wmsRecebimentoDetalheModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idWmsCaixa'] = idWmsCaixa != 0 ? idWmsCaixa : null;
		jsonData['idWmsRecebimentoDetalhe'] = idWmsRecebimentoDetalhe != 0 ? idWmsRecebimentoDetalhe : null;
		jsonData['quantidade'] = quantidade;
		jsonData['wmsRecebimentoDetalheModel'] = wmsRecebimentoDetalheModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idWmsCaixa = plutoRow.cells['idWmsCaixa']?.value;
		idWmsRecebimentoDetalhe = plutoRow.cells['idWmsRecebimentoDetalhe']?.value;
		quantidade = plutoRow.cells['quantidade']?.value;
		wmsRecebimentoDetalheModel = WmsRecebimentoDetalheModel();
		wmsRecebimentoDetalheModel?.id = plutoRow.cells['wmsRecebimentoDetalheModel']?.value;
	}	

	WmsArmazenamentoModel clone() {
		return WmsArmazenamentoModel(
			id: id,
			idWmsCaixa: idWmsCaixa,
			idWmsRecebimentoDetalhe: idWmsRecebimentoDetalhe,
			quantidade: quantidade,
		);			
	}

	
}