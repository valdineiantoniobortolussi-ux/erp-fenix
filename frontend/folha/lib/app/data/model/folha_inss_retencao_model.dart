import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/data/model/model_imports.dart';

class FolhaInssRetencaoModel {
	int? id;
	int? idFolhaInss;
	int? idFolhaInssServico;
	double? valorMensal;
	double? valor13;
	FolhaInssServicoModel? folhaInssServicoModel;

	FolhaInssRetencaoModel({
		this.id,
		this.idFolhaInss,
		this.idFolhaInssServico,
		this.valorMensal,
		this.valor13,
		this.folhaInssServicoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'valor_mensal',
		'valor_13',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Valor Mensal',
		'Valor 13',
	];

	FolhaInssRetencaoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idFolhaInss = jsonData['idFolhaInss'];
		idFolhaInssServico = jsonData['idFolhaInssServico'];
		valorMensal = jsonData['valorMensal']?.toDouble();
		valor13 = jsonData['valor13']?.toDouble();
		folhaInssServicoModel = jsonData['folhaInssServicoModel'] == null ? FolhaInssServicoModel() : FolhaInssServicoModel.fromJson(jsonData['folhaInssServicoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idFolhaInss'] = idFolhaInss != 0 ? idFolhaInss : null;
		jsonData['idFolhaInssServico'] = idFolhaInssServico != 0 ? idFolhaInssServico : null;
		jsonData['valorMensal'] = valorMensal;
		jsonData['valor13'] = valor13;
		jsonData['folhaInssServicoModel'] = folhaInssServicoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idFolhaInss = plutoRow.cells['idFolhaInss']?.value;
		idFolhaInssServico = plutoRow.cells['idFolhaInssServico']?.value;
		valorMensal = plutoRow.cells['valorMensal']?.value?.toDouble();
		valor13 = plutoRow.cells['valor13']?.value?.toDouble();
		folhaInssServicoModel = FolhaInssServicoModel();
		folhaInssServicoModel?.nome = plutoRow.cells['folhaInssServicoModel']?.value;
	}	

	FolhaInssRetencaoModel clone() {
		return FolhaInssRetencaoModel(
			id: id,
			idFolhaInss: idFolhaInss,
			idFolhaInssServico: idFolhaInssServico,
			valorMensal: valorMensal,
			valor13: valor13,
		);			
	}

	
}