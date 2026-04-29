import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class PaisModel {
	int? id;
	String? nomePtbr;
	String? nomeEn;
	int? codigo;
	String? sigla2;
	String? sigla3;
	int? codigoBacen;

	PaisModel({
		this.id,
		this.nomePtbr,
		this.nomeEn,
		this.codigo,
		this.sigla2,
		this.sigla3,
		this.codigoBacen,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome_ptbr',
		'nome_en',
		'codigo',
		'sigla2',
		'sigla3',
		'codigo_bacen',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome Ptbr',
		'Nome En',
		'Codigo',
		'Sigla2',
		'Sigla3',
		'Codigo Bacen',
	];

	PaisModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nomePtbr = jsonData['nomePtbr'];
		nomeEn = jsonData['nomeEn'];
		codigo = jsonData['codigo'];
		sigla2 = jsonData['sigla2'];
		sigla3 = jsonData['sigla3'];
		codigoBacen = jsonData['codigoBacen'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nomePtbr'] = nomePtbr;
		jsonData['nomeEn'] = nomeEn;
		jsonData['codigo'] = codigo;
		jsonData['sigla2'] = sigla2;
		jsonData['sigla3'] = sigla3;
		jsonData['codigoBacen'] = codigoBacen;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nomePtbr = plutoRow.cells['nomePtbr']?.value;
		nomeEn = plutoRow.cells['nomeEn']?.value;
		codigo = plutoRow.cells['codigo']?.value;
		sigla2 = plutoRow.cells['sigla2']?.value;
		sigla3 = plutoRow.cells['sigla3']?.value;
		codigoBacen = plutoRow.cells['codigoBacen']?.value;
	}	

	PaisModel clone() {
		return PaisModel(
			id: id,
			nomePtbr: nomePtbr,
			nomeEn: nomeEn,
			codigo: codigo,
			sigla2: sigla2,
			sigla3: sigla3,
			codigoBacen: codigoBacen,
		);			
	}

	
}