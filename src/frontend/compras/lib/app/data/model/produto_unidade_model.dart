import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:compras/app/data/domain/domain_imports.dart';

class ProdutoUnidadeModel {
	int? id;
	String? sigla;
	String? descricao;
	String? podeFracionar;

	ProdutoUnidadeModel({
		this.id,
		this.sigla,
		this.descricao,
		this.podeFracionar,
	});

	static List<String> dbColumns = <String>[
		'id',
		'sigla',
		'descricao',
		'pode_fracionar',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Sigla',
		'Descricao',
		'Pode Fracionar',
	];

	ProdutoUnidadeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		sigla = jsonData['sigla'];
		descricao = jsonData['descricao'];
		podeFracionar = ProdutoUnidadeDomain.getPodeFracionar(jsonData['podeFracionar']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['sigla'] = sigla;
		jsonData['descricao'] = descricao;
		jsonData['podeFracionar'] = ProdutoUnidadeDomain.setPodeFracionar(podeFracionar);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		sigla = plutoRow.cells['sigla']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		podeFracionar = plutoRow.cells['podeFracionar']?.value != '' ? plutoRow.cells['podeFracionar']?.value : 'AAA';
	}	

	ProdutoUnidadeModel clone() {
		return ProdutoUnidadeModel(
			id: id,
			sigla: sigla,
			descricao: descricao,
			podeFracionar: podeFracionar,
		);			
	}

	
}