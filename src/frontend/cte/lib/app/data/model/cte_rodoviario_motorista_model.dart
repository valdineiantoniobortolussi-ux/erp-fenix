import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cte/app/infra/infra_imports.dart';
import 'package:cte/app/data/model/model_imports.dart';

class CteRodoviarioMotoristaModel {
	int? id;
	int? idCteRodoviario;
	String? nome;
	String? cpf;
	CteRodoviarioModel? cteRodoviarioModel;

	CteRodoviarioMotoristaModel({
		this.id,
		this.idCteRodoviario,
		this.nome,
		this.cpf,
		this.cteRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'cpf',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Cpf',
	];

	CteRodoviarioMotoristaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idCteRodoviario = jsonData['idCteRodoviario'];
		nome = jsonData['nome'];
		cpf = jsonData['cpf'];
		cteRodoviarioModel = jsonData['cteRodoviarioModel'] == null ? CteRodoviarioModel() : CteRodoviarioModel.fromJson(jsonData['cteRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idCteRodoviario'] = idCteRodoviario != 0 ? idCteRodoviario : null;
		jsonData['nome'] = nome;
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['cteRodoviarioModel'] = cteRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idCteRodoviario = plutoRow.cells['idCteRodoviario']?.value;
		nome = plutoRow.cells['nome']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		cteRodoviarioModel = CteRodoviarioModel();
		cteRodoviarioModel?.rntrc = plutoRow.cells['cteRodoviarioModel']?.value;
	}	

	CteRodoviarioMotoristaModel clone() {
		return CteRodoviarioMotoristaModel(
			id: id,
			idCteRodoviario: idCteRodoviario,
			nome: nome,
			cpf: cpf,
		);			
	}

	
}