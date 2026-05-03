import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:nfse/app/data/model/model_imports.dart';
import 'package:nfse/app/data/domain/domain_imports.dart';

class OsStatusModel {
	int? id;
	String? codigo;
	String? nome;
	List<OsAberturaModel>? osAberturaModelList;

	OsStatusModel({
		this.id,
		this.codigo,
		this.nome,
		this.osAberturaModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'codigo',
		'nome',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Codigo',
		'Nome',
	];

	OsStatusModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		codigo = OsStatusDomain.getCodigo(jsonData['codigo']);
		nome = jsonData['nome'];
		osAberturaModelList = (jsonData['osAberturaModelList'] as Iterable?)?.map((m) => OsAberturaModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['codigo'] = OsStatusDomain.setCodigo(codigo);
		jsonData['nome'] = nome;
		
		var osAberturaModelLocalList = []; 
		for (OsAberturaModel object in osAberturaModelList ?? []) { 
			osAberturaModelLocalList.add(object.toJson); 
		}
		jsonData['osAberturaModelList'] = osAberturaModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		codigo = plutoRow.cells['codigo']?.value != '' ? plutoRow.cells['codigo']?.value : 'AAA';
		nome = plutoRow.cells['nome']?.value;
		osAberturaModelList = [];
	}	

	OsStatusModel clone() {
		return OsStatusModel(
			id: id,
			codigo: codigo,
			nome: nome,
			osAberturaModelList: osAberturaModelListClone(osAberturaModelList!),
		);			
	}

	osAberturaModelListClone(List<OsAberturaModel> osAberturaModelList) { 
		List<OsAberturaModel> resultList = [];
		for (var osAberturaModel in osAberturaModelList) {
			resultList.add(
				OsAberturaModel(
					id: osAberturaModel.id,
					idOsStatus: osAberturaModel.idOsStatus,
					idColaborador: osAberturaModel.idColaborador,
					idCliente: osAberturaModel.idCliente,
					numero: osAberturaModel.numero,
					dataInicio: osAberturaModel.dataInicio,
					horaInicio: osAberturaModel.horaInicio,
					dataPrevisao: osAberturaModel.dataPrevisao,
					horaPrevisao: osAberturaModel.horaPrevisao,
					dataFim: osAberturaModel.dataFim,
					horaFim: osAberturaModel.horaFim,
					nomeContato: osAberturaModel.nomeContato,
					foneContato: osAberturaModel.foneContato,
					observacaoCliente: osAberturaModel.observacaoCliente,
					observacaoAbertura: osAberturaModel.observacaoAbertura,
				)
			);
		}
		return resultList;
	}

	
}