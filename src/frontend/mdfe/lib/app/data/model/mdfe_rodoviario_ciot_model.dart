import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:mdfe/app/infra/infra_imports.dart';
import 'package:mdfe/app/data/model/model_imports.dart';

class MdfeRodoviarioCiotModel {
	int? id;
	int? idMdfeRodoviario;
	String? ciot;
	String? cpf;
	String? cnpj;
	MdfeRodoviarioModel? mdfeRodoviarioModel;

	MdfeRodoviarioCiotModel({
		this.id,
		this.idMdfeRodoviario,
		this.ciot,
		this.cpf,
		this.cnpj,
		this.mdfeRodoviarioModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'ciot',
		'cpf',
		'cnpj',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Ciot',
		'Cpf',
		'Cnpj',
	];

	MdfeRodoviarioCiotModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idMdfeRodoviario = jsonData['idMdfeRodoviario'];
		ciot = jsonData['ciot'];
		cpf = jsonData['cpf'];
		cnpj = jsonData['cnpj'];
		mdfeRodoviarioModel = jsonData['mdfeRodoviarioModel'] == null ? MdfeRodoviarioModel() : MdfeRodoviarioModel.fromJson(jsonData['mdfeRodoviarioModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idMdfeRodoviario'] = idMdfeRodoviario != 0 ? idMdfeRodoviario : null;
		jsonData['ciot'] = ciot;
		jsonData['cpf'] = Util.removeMask(cpf);
		jsonData['cnpj'] = Util.removeMask(cnpj);
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
		ciot = plutoRow.cells['ciot']?.value;
		cpf = plutoRow.cells['cpf']?.value;
		cnpj = plutoRow.cells['cnpj']?.value;
		mdfeRodoviarioModel = MdfeRodoviarioModel();
		mdfeRodoviarioModel?.codigoAgendamento = plutoRow.cells['mdfeRodoviarioModel']?.value;
	}	

	MdfeRodoviarioCiotModel clone() {
		return MdfeRodoviarioCiotModel(
			id: id,
			idMdfeRodoviario: idMdfeRodoviario,
			ciot: ciot,
			cpf: cpf,
			cnpj: cnpj,
		);			
	}

	
}