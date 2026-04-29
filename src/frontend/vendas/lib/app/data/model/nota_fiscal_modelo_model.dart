import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:vendas/app/data/domain/domain_imports.dart';

class NotaFiscalModeloModel {
	int? id;
	String? codigo;
	String? descricao;
	String? modelo;

	NotaFiscalModeloModel({
		this.id,
		this.codigo,
		this.descricao,
		this.modelo,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'descricao',
		'modelo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Descricao',
		'Modelo',
	];

	NotaFiscalModeloModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = NotaFiscalModeloDomain.getCodigo(jsonData['codigo']);
		descricao = jsonData['descricao'];
		modelo = jsonData['modelo'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = NotaFiscalModeloDomain.setCodigo(codigo);
		jsonData['descricao'] = descricao;
		jsonData['modelo'] = modelo;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value != '' ? plutoRow.cells['codigo']?.value : 'AAA';
		descricao = plutoRow.cells['descricao']?.value;
		modelo = plutoRow.cells['modelo']?.value;
	}	

	NotaFiscalModeloModel clone() {
		return NotaFiscalModeloModel(
			id: id,
			codigo: codigo,
			descricao: descricao,
			modelo: modelo,
		);			
	}

	
}