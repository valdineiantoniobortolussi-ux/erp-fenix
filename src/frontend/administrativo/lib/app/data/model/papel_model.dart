import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:administrativo/app/data/model/model_imports.dart';


class PapelModel extends ModelBase {
  int? id;
  String? nome;
  String? descricao;
  List<PapelFuncaoModel>? papelFuncaoModelList;

  PapelModel({
    this.id,
    this.nome,
    this.descricao,
    List<PapelFuncaoModel>? papelFuncaoModelList,
  }) {
    this.papelFuncaoModelList = papelFuncaoModelList?.toList(growable: true) ?? [];
  }

  static List<String> dbColumns = <String>[
    'id',
    'nome',
    'descricao',
  ];

  static List<String> aliasColumns = <String>[
    'Id',
    'Nome',
    'Descricao',
  ];

  PapelModel.fromJson(Map<String, dynamic> jsonData) {
    id = jsonData['id'];
    nome = jsonData['nome'];
    descricao = jsonData['descricao'];
    papelFuncaoModelList = (jsonData['papelFuncaoModelList'] as Iterable?)?.map((m) => PapelFuncaoModel.fromJson(m)).toList() ?? [];
  }

  Map<String, dynamic> get toJson {
    Map<String, dynamic> jsonData = <String, dynamic>{};

    jsonData['id'] = id != 0 ? id : null;
    jsonData['nome'] = nome;
    jsonData['descricao'] = descricao;
    
		var papelFuncaoModelLocalList = []; 
		for (PapelFuncaoModel object in papelFuncaoModelList ?? []) { 
			papelFuncaoModelLocalList.add(object.toJson); 
		}
		jsonData['papelFuncaoModelList'] = papelFuncaoModelLocalList;

    return jsonData;
  }

  String objectEncodeJson() {
    final jsonData = toJson;
    return json.encode(jsonData);
  }

  static PapelModel fromPlutoRow(PlutoRow row) {
    return PapelModel(
      id: row.cells['id']?.value,
      nome: row.cells['nome']?.value,
      descricao: row.cells['descricao']?.value,
    );
  }

  PlutoRow toPlutoRow() {
    return PlutoRow(
      cells: {
        'tempId': PlutoCell(value: tempId),
        'id': PlutoCell(value: id ?? 0),
        'nome': PlutoCell(value: nome ?? ''),
        'descricao': PlutoCell(value: descricao ?? ''),
      },
    );
  }

  PapelModel clone() {
    return PapelModel(
      id: id,
      nome: nome,
      descricao: descricao,
      papelFuncaoModelList: papelFuncaoModelListClone(papelFuncaoModelList!),
    );
  }

  static PapelModel cloneFrom(PapelModel? model) {
    return PapelModel(
      id: model?.id,
      nome: model?.nome,
      descricao: model?.descricao,
    );
  }

  papelFuncaoModelListClone(List<PapelFuncaoModel> papelFuncaoModelList) { 
		List<PapelFuncaoModel> resultList = [];
		for (var papelFuncaoModel in papelFuncaoModelList) {
			resultList.add(PapelFuncaoModel.cloneFrom(papelFuncaoModel));
		}
		return resultList;
	}


}