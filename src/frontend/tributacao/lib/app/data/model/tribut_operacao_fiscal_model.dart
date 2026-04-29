import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class TributOperacaoFiscalModel {
	int? id;
	int? cfop;
	String? descricao;
	String? descricaoNaNf;
	String? observacao;

	TributOperacaoFiscalModel({
		this.id,
		this.cfop,
		this.descricao,
		this.descricaoNaNf,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'cfop',
		'descricao',
		'descricao_na_nf',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Cfop',
		'Descricao',
		'Descricao Na Nf',
		'Observacao',
	];

	TributOperacaoFiscalModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		cfop = jsonData['cfop'];
		descricao = jsonData['descricao'];
		descricaoNaNf = jsonData['descricaoNaNf'];
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['cfop'] = cfop;
		jsonData['descricao'] = descricao;
		jsonData['descricaoNaNf'] = descricaoNaNf;
		jsonData['observacao'] = observacao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		cfop = plutoRow.cells['cfop']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		descricaoNaNf = plutoRow.cells['descricaoNaNf']?.value;
		observacao = plutoRow.cells['observacao']?.value;
	}	

	TributOperacaoFiscalModel clone() {
		return TributOperacaoFiscalModel(
			id: id,
			cfop: cfop,
			descricao: descricao,
			descricaoNaNf: descricaoNaNf,
			observacao: observacao,
		);			
	}

	
}