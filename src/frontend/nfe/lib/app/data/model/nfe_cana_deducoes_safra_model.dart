import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfe/app/data/model/model_imports.dart';

class NfeCanaDeducoesSafraModel {
	int? id;
	int? idNfeCana;
	String? decricao;
	double? valorDeducao;
	double? valorFornecimento;
	double? valorTotalDeducao;
	double? valorLiquidoFornecimento;
	NfeCanaModel? nfeCanaModel;

	NfeCanaDeducoesSafraModel({
		this.id,
		this.idNfeCana,
		this.decricao,
		this.valorDeducao,
		this.valorFornecimento,
		this.valorTotalDeducao,
		this.valorLiquidoFornecimento,
		this.nfeCanaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'decricao',
		'valor_deducao',
		'valor_fornecimento',
		'valor_total_deducao',
		'valor_liquido_fornecimento',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Decricao',
		'Valor Deducao',
		'Valor Fornecimento',
		'Valor Total Deducao',
		'Valor Liquido Fornecimento',
	];

	NfeCanaDeducoesSafraModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idNfeCana = jsonData['idNfeCana'];
		decricao = jsonData['decricao'];
		valorDeducao = jsonData['valorDeducao']?.toDouble();
		valorFornecimento = jsonData['valorFornecimento']?.toDouble();
		valorTotalDeducao = jsonData['valorTotalDeducao']?.toDouble();
		valorLiquidoFornecimento = jsonData['valorLiquidoFornecimento']?.toDouble();
		nfeCanaModel = jsonData['nfeCanaModel'] == null ? NfeCanaModel() : NfeCanaModel.fromJson(jsonData['nfeCanaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idNfeCana'] = idNfeCana != 0 ? idNfeCana : null;
		jsonData['decricao'] = decricao;
		jsonData['valorDeducao'] = valorDeducao;
		jsonData['valorFornecimento'] = valorFornecimento;
		jsonData['valorTotalDeducao'] = valorTotalDeducao;
		jsonData['valorLiquidoFornecimento'] = valorLiquidoFornecimento;
		jsonData['nfeCanaModel'] = nfeCanaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idNfeCana = plutoRow.cells['idNfeCana']?.value;
		decricao = plutoRow.cells['decricao']?.value;
		valorDeducao = plutoRow.cells['valorDeducao']?.value?.toDouble();
		valorFornecimento = plutoRow.cells['valorFornecimento']?.value?.toDouble();
		valorTotalDeducao = plutoRow.cells['valorTotalDeducao']?.value?.toDouble();
		valorLiquidoFornecimento = plutoRow.cells['valorLiquidoFornecimento']?.value?.toDouble();
		nfeCanaModel = NfeCanaModel();
		nfeCanaModel?.safra = plutoRow.cells['nfeCanaModel']?.value;
	}	

	NfeCanaDeducoesSafraModel clone() {
		return NfeCanaDeducoesSafraModel(
			id: id,
			idNfeCana: idNfeCana,
			decricao: decricao,
			valorDeducao: valorDeducao,
			valorFornecimento: valorFornecimento,
			valorTotalDeducao: valorTotalDeducao,
			valorLiquidoFornecimento: valorLiquidoFornecimento,
		);			
	}

	
}