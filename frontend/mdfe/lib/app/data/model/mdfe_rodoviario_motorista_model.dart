import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioMotoristaModel {
	int? id;
	int? idMdfeRodoviario;
	String? nome;
	String? cpf;
	MdfeRodoviarioModel? mdfeRodoviarioModel;

	MdfeRodoviarioMotoristaModel({
		this.id,
		this.idMdfeRodoviario,
		this.nome,
		this.cpf,
		this.mdfeRodoviarioModel,
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

	MdfeRodoviarioMotoristaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeRodoviario = jsonData['idMdfeRodoviario'];
		nome = jsonData['nome'];
		cpf = jsonData['cpf'];
		mdfeRodoviarioModel = jsonData['mdfeRodoviarioModel'] == null ? MdfeRodoviarioModel() : MdfeRodoviarioModel.fromJson(jsonData['mdfeRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeRodoviario'] = idMdfeRodoviario != 0 ? idMdfeRodoviario : null;
		jsonData['nome'] = nome;
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['mdfeRodoviarioModel'] = mdfeRodoviarioModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idMdfeRodoviario = plutoRow.cells['idMdfeRodoviario']?.value;
		nome = plutoRow.cells['nome']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		mdfeRodoviarioModel = MdfeRodoviarioModel();
		mdfeRodoviarioModel?.codigoAgendamento = plutoRow.cells['mdfeRodoviarioModel']?.value;
	}	

	MdfeRodoviarioMotoristaModel clone() {
		return MdfeRodoviarioMotoristaModel(
			id: id,
			idMdfeRodoviario: idMdfeRodoviario,
			nome: nome,
			cpf: cpf,
		);			
	}

	
}