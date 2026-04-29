import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class TributOperacaoFiscalModel {
	int? id;
	String? descricao;
	String? descricaoNaNf;
	int? cfop;
	String? observacao;

	TributOperacaoFiscalModel({
		this.id,
		this.descricao,
		this.descricaoNaNf,
		this.cfop,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'descricao_na_nf',
		'cfop',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Descricao Na Nf',
		'Cfop',
		'Observacao',
	];

	TributOperacaoFiscalModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		descricaoNaNf = jsonData['descricaoNaNf'];
		cfop = jsonData['cfop'];
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['descricaoNaNf'] = descricaoNaNf;
		jsonData['cfop'] = cfop;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		descricaoNaNf = plutoRow.cells['descricaoNaNf']?.value;
		cfop = plutoRow.cells['cfop']?.value;
		observacao = plutoRow.cells['observacao']?.value;
	}	

	TributOperacaoFiscalModel clone() {
		return TributOperacaoFiscalModel(
			id: id,
			descricao: descricao,
			descricaoNaNf: descricaoNaNf,
			cfop: cfop,
			observacao: observacao,
		);			
	}

	
}