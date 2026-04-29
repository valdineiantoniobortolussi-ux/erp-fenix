import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/domain/domain_imports.dart';

class ProdutoUnidadeModel {
	int? id;
	String? sigla;
	String? podeFracionar;
	String? descricao;

	ProdutoUnidadeModel({
		this.id,
		this.sigla,
		this.podeFracionar,
		this.descricao,
	});

	static List<String> dbColumns = <String>[
		'id',
		'sigla',
		'pode_fracionar',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Sigla',
		'Pode Fracionar',
		'Descricao',
	];

	ProdutoUnidadeModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		sigla = jsonData['sigla'];
		podeFracionar = ProdutoUnidadeDomain.getPodeFracionar(jsonData['podeFracionar']);
		descricao = jsonData['descricao'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['sigla'] = sigla;
		jsonData['podeFracionar'] = ProdutoUnidadeDomain.setPodeFracionar(podeFracionar);
		jsonData['descricao'] = descricao;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		sigla = plutoRow.cells['sigla']?.value;
		podeFracionar = plutoRow.cells['podeFracionar']?.value != '' ? plutoRow.cells['podeFracionar']?.value : 'Sim';
		descricao = plutoRow.cells['descricao']?.value;
	}	

	ProdutoUnidadeModel clone() {
		return ProdutoUnidadeModel(
			id: id,
			sigla: sigla,
			podeFracionar: podeFracionar,
			descricao: descricao,
		);			
	}

	
}