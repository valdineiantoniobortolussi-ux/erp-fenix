import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/data/domain/domain_imports.dart';

class TributGrupoTributarioModel {
	int? id;
	String? descricao;
	String? origemMercadoria;
	String? observacao;

	TributGrupoTributarioModel({
		this.id,
		this.descricao,
		this.origemMercadoria,
		this.observacao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'descricao',
		'origem_mercadoria',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Descricao',
		'Origem Mercadoria',
		'Observacao',
	];

	TributGrupoTributarioModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		descricao = jsonData['descricao'];
		origemMercadoria = TributGrupoTributarioDomain.getOrigemMercadoria(jsonData['origemMercadoria']);
		observacao = jsonData['observacao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['descricao'] = descricao;
		jsonData['origemMercadoria'] = TributGrupoTributarioDomain.setOrigemMercadoria(origemMercadoria);
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
		origemMercadoria = plutoRow.cells['origemMercadoria']?.value != '' ? plutoRow.cells['origemMercadoria']?.value : 'AAA';
		observacao = plutoRow.cells['observacao']?.value;
	}	

	TributGrupoTributarioModel clone() {
		return TributGrupoTributarioModel(
			id: id,
			descricao: descricao,
			origemMercadoria: origemMercadoria,
			observacao: observacao,
		);			
	}

	
}