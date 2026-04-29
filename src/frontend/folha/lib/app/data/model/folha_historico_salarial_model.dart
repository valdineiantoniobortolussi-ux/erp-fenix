import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:folha/app/infra/infra_imports.dart';
import 'package:folha/app/data/model/model_imports.dart';

class FolhaHistoricoSalarialModel {
	int? id;
	int? idColaborador;
	String? competencia;
	double? salarioAtual;
	double? percentualAumento;
	double? salarioNovo;
	String? validoAPartir;
	String? motivo;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;

	FolhaHistoricoSalarialModel({
		this.id,
		this.idColaborador,
		this.competencia,
		this.salarioAtual,
		this.percentualAumento,
		this.salarioNovo,
		this.validoAPartir,
		this.motivo,
		this.viewPessoaColaboradorModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'competencia',
		'salario_atual',
		'percentual_aumento',
		'salario_novo',
		'valido_a_partir',
		'motivo',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Competencia',
		'Salario Atual',
		'Percentual Aumento',
		'Salario Novo',
		'Valido A Partir',
		'Motivo',
	];

	FolhaHistoricoSalarialModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idColaborador = jsonData['idColaborador'];
		competencia = jsonData['competencia'];
		salarioAtual = jsonData['salarioAtual']?.toDouble();
		percentualAumento = jsonData['percentualAumento']?.toDouble();
		salarioNovo = jsonData['salarioNovo']?.toDouble();
		validoAPartir = jsonData['validoAPartir'];
		motivo = jsonData['motivo'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['competencia'] = Util.removeMask(competencia);
		jsonData['salarioAtual'] = salarioAtual;
		jsonData['percentualAumento'] = percentualAumento;
		jsonData['salarioNovo'] = salarioNovo;
		jsonData['validoAPartir'] = Util.removeMask(validoAPartir);
		jsonData['motivo'] = motivo;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		competencia = plutoRow.cells['competencia']?.value;
		salarioAtual = plutoRow.cells['salarioAtual']?.value?.toDouble();
		percentualAumento = plutoRow.cells['percentualAumento']?.value?.toDouble();
		salarioNovo = plutoRow.cells['salarioNovo']?.value?.toDouble();
		validoAPartir = plutoRow.cells['validoAPartir']?.value;
		motivo = plutoRow.cells['motivo']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
	}	

	FolhaHistoricoSalarialModel clone() {
		return FolhaHistoricoSalarialModel(
			id: id,
			idColaborador: idColaborador,
			competencia: competencia,
			salarioAtual: salarioAtual,
			percentualAumento: percentualAumento,
			salarioNovo: salarioNovo,
			validoAPartir: validoAPartir,
			motivo: motivo,
		);			
	}

	
}