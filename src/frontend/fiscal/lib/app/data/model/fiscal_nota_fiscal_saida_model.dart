import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:fiscal/app/infra/infra_imports.dart';
import 'package:fiscal/app/data/model/model_imports.dart';

class FiscalNotaFiscalSaidaModel {
	int? id;
	int? idNfeCabecalho;
	String? competencia;
	NfeCabecalhoModel? nfeCabecalhoModel;

	FiscalNotaFiscalSaidaModel({
		this.id,
		this.idNfeCabecalho,
		this.competencia,
		this.nfeCabecalhoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
	];

	FiscalNotaFiscalSaidaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCabecalho = jsonData['idNfeCabecalho'];
		competencia = jsonData['competencia'];
		nfeCabecalhoModel = jsonData['nfeCabecalhoModel'] == null ? NfeCabecalhoModel() : NfeCabecalhoModel.fromJson(jsonData['nfeCabecalhoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCabecalho'] = idNfeCabecalho != 0 ? idNfeCabecalho : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['nfeCabecalhoModel'] = nfeCabecalhoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCabecalho = plutoRow.cells['idNfeCabecalho']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		nfeCabecalhoModel = NfeCabecalhoModel();
		nfeCabecalhoModel?.chave_acesso = plutoRow.cells['nfeCabecalhoModel']?.value;
	}	

	FiscalNotaFiscalSaidaModel clone() {
		return FiscalNotaFiscalSaidaModel(
			id: id,
			idNfeCabecalho: idNfeCabecalho,
			competencia: competencia,
		);			
	}

	
}