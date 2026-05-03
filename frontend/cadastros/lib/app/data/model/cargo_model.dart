import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CargoModel {
	int? id;
	String? nome;
	String? descricao;
	double? salario;
	String? cbo1994;
	String? cbo2002;

	CargoModel({
		this.id,
		this.nome,
		this.descricao,
		this.salario,
		this.cbo1994,
		this.cbo2002,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descricao',
		'salario',
		'cbo_1994',
		'cbo_2002',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descricao',
		'Salario',
		'Cbo 1994',
		'Cbo 2002',
	];

	CargoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descricao = jsonData['descricao'];
		salario = jsonData['salario']?.toDouble();
		cbo1994 = jsonData['cbo1994'];
		cbo2002 = jsonData['cbo2002'];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['descricao'] = descricao;
		jsonData['salario'] = salario;
		jsonData['cbo1994'] = cbo1994;
		jsonData['cbo2002'] = cbo2002;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		salario = plutoRow.cells['salario']?.value?.toDouble();
		cbo1994 = plutoRow.cells['cbo1994']?.value;
		cbo2002 = plutoRow.cells['cbo2002']?.value;
	}	

	CargoModel clone() {
		return CargoModel(
			id: id,
			nome: nome,
			descricao: descricao,
			salario: salario,
			cbo1994: cbo1994,
			cbo2002: cbo2002,
		);			
	}

	
}