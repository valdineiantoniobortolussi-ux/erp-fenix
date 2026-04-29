import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:cadastros/app/data/model/model_imports.dart';

class PapelModel {
	int? id;
	String? nome;
	String? descrica;
	List<PapelFuncaoModel>? papelFuncaoModelList;
	List<UsuarioModel>? usuarioModelList;

	PapelModel({
		this.id,
		this.nome,
		this.descrica,
		this.papelFuncaoModelList,
		this.usuarioModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'descrica',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Descrica',
	];

	PapelModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descrica = jsonData['descrica'];
		papelFuncaoModelList = (jsonData['papelFuncaoModelList'] as Iterable?)?.map((m) => PapelFuncaoModel.fromJson(m)).toList() ?? [];
		usuarioModelList = (jsonData['usuarioModelList'] as Iterable?)?.map((m) => UsuarioModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['descrica'] = descrica;
		
		var papelFuncaoModelLocalList = []; 
		for (PapelFuncaoModel object in papelFuncaoModelList ?? []) { 
			papelFuncaoModelLocalList.add(object.toJson); 
		}
		jsonData['papelFuncaoModelList'] = papelFuncaoModelLocalList;
		
		var usuarioModelLocalList = []; 
		for (UsuarioModel object in usuarioModelList ?? []) { 
			usuarioModelLocalList.add(object.toJson); 
		}
		jsonData['usuarioModelList'] = usuarioModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		descrica = plutoRow.cells['descrica']?.value;
		papelFuncaoModelList = [];
		usuarioModelList = [];
	}	

	PapelModel clone() {
		return PapelModel(
			id: id,
			nome: nome,
			descrica: descrica,
			papelFuncaoModelList: papelFuncaoModelListClone(papelFuncaoModelList!),
			usuarioModelList: usuarioModelListClone(usuarioModelList!),
		);			
	}

	papelFuncaoModelListClone(List<PapelFuncaoModel> papelFuncaoModelList) { 
		List<PapelFuncaoModel> resultList = [];
		for (var papelFuncaoModel in papelFuncaoModelList) {
			resultList.add(
				PapelFuncaoModel(
					id: papelFuncaoModel.id,
					idPapel: papelFuncaoModel.idPapel,
					idFuncao: papelFuncaoModel.idFuncao,
					habilitado: papelFuncaoModel.habilitado,
					podeInserir: papelFuncaoModel.podeInserir,
					podeAlterar: papelFuncaoModel.podeAlterar,
					podeExcluir: papelFuncaoModel.podeExcluir,
				)
			);
		}
		return resultList;
	}

	usuarioModelListClone(List<UsuarioModel> usuarioModelList) { 
		List<UsuarioModel> resultList = [];
		for (var usuarioModel in usuarioModelList) {
			resultList.add(
				UsuarioModel(
					id: usuarioModel.id,
					idPapel: usuarioModel.idPapel,
					idColaborador: usuarioModel.idColaborador,
					login: usuarioModel.login,
					senha: usuarioModel.senha,
					administrador: usuarioModel.administrador,
					dataCadastro: usuarioModel.dataCadastro,
				)
			);
		}
		return resultList;
	}

	
}