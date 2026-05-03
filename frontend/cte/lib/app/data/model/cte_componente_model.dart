import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';


class CteComponenteModel {
	int? id;
	int? idCteCabecalho;
	String? nome;
	double? valor;

	CteComponenteModel({
		this.id,
		this.idCteCabecalho,
		this.nome,
		this.valor,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'valor',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Valor',
	];

	CteComponenteModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteCabecalho = jsonData['idCteCabecalho'];
		nome = jsonData['nome'];
		valor = jsonData['valor']?.toDouble();
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteCabecalho'] = idCteCabecalho != 0 ? idCteCabecalho : null;
		jsonData['nome'] = nome;
		jsonData['valor'] = valor;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteCabecalho = plutoRow.cells['idCteCabecalho']?.value;
		nome = plutoRow.cells['nome']?.value;
		valor = plutoRow.cells['valor']?.value?.toDouble();
	}	

	CteComponenteModel clone() {
		return CteComponenteModel(
			id: id,
			idCteCabecalho: idCteCabecalho,
			nome: nome,
			valor: valor,
		);			
	}

	
}