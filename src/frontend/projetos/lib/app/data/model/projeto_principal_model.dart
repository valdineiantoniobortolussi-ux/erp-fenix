import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:projetos/app/infra/infra_imports.dart';
import 'package:projetos/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';

class ProjetoPrincipalModel {
	int? id;
	String? nome;
	DateTime? dataInicio;
	DateTime? dataPrevisaoFim;
	DateTime? dataFim;
	double? valorOrcamento;
	String? linkQuadroKanban;
	String? observacao;
	List<ProjetoCronogramaModel>? projetoCronogramaModelList;
	List<ProjetoRiscoModel>? projetoRiscoModelList;
	List<ProjetoCustoModel>? projetoCustoModelList;
	List<ProjetoStakeholdersModel>? projetoStakeholdersModelList;

	ProjetoPrincipalModel({
		this.id,
		this.nome,
		this.dataInicio,
		this.dataPrevisaoFim,
		this.dataFim,
		this.valorOrcamento,
		this.linkQuadroKanban,
		this.observacao,
		this.projetoCronogramaModelList,
		this.projetoRiscoModelList,
		this.projetoCustoModelList,
		this.projetoStakeholdersModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'data_inicio',
		'data_previsao_fim',
		'data_fim',
		'valor_orcamento',
		'link_quadro_kanban',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Data Inicio',
		'Data Previsao Fim',
		'Data Fim',
		'Valor Orcamento',
		'Link Quadro Kanban',
		'Observacao',
	];

	ProjetoPrincipalModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		dataInicio = jsonData['dataInicio'] != null ? DateTime.tryParse(jsonData['dataInicio']) : null;
		dataPrevisaoFim = jsonData['dataPrevisaoFim'] != null ? DateTime.tryParse(jsonData['dataPrevisaoFim']) : null;
		dataFim = jsonData['dataFim'] != null ? DateTime.tryParse(jsonData['dataFim']) : null;
		valorOrcamento = jsonData['valorOrcamento']?.toDouble();
		linkQuadroKanban = jsonData['linkQuadroKanban'];
		observacao = jsonData['observacao'];
		projetoCronogramaModelList = (jsonData['projetoCronogramaModelList'] as Iterable?)?.map((m) => ProjetoCronogramaModel.fromJson(m)).toList() ?? [];
		projetoRiscoModelList = (jsonData['projetoRiscoModelList'] as Iterable?)?.map((m) => ProjetoRiscoModel.fromJson(m)).toList() ?? [];
		projetoCustoModelList = (jsonData['projetoCustoModelList'] as Iterable?)?.map((m) => ProjetoCustoModel.fromJson(m)).toList() ?? [];
		projetoStakeholdersModelList = (jsonData['projetoStakeholdersModelList'] as Iterable?)?.map((m) => ProjetoStakeholdersModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['dataInicio'] = dataInicio != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataInicio!) : null;
		jsonData['dataPrevisaoFim'] = dataPrevisaoFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataPrevisaoFim!) : null;
		jsonData['dataFim'] = dataFim != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFim!) : null;
		jsonData['valorOrcamento'] = valorOrcamento;
		jsonData['linkQuadroKanban'] = linkQuadroKanban;
		jsonData['observacao'] = observacao;
		
		var projetoCronogramaModelLocalList = []; 
		for (ProjetoCronogramaModel object in projetoCronogramaModelList ?? []) { 
			projetoCronogramaModelLocalList.add(object.toJson); 
		}
		jsonData['projetoCronogramaModelList'] = projetoCronogramaModelLocalList;
		
		var projetoRiscoModelLocalList = []; 
		for (ProjetoRiscoModel object in projetoRiscoModelList ?? []) { 
			projetoRiscoModelLocalList.add(object.toJson); 
		}
		jsonData['projetoRiscoModelList'] = projetoRiscoModelLocalList;
		
		var projetoCustoModelLocalList = []; 
		for (ProjetoCustoModel object in projetoCustoModelList ?? []) { 
			projetoCustoModelLocalList.add(object.toJson); 
		}
		jsonData['projetoCustoModelList'] = projetoCustoModelLocalList;
		
		var projetoStakeholdersModelLocalList = []; 
		for (ProjetoStakeholdersModel object in projetoStakeholdersModelList ?? []) { 
			projetoStakeholdersModelLocalList.add(object.toJson); 
		}
		jsonData['projetoStakeholdersModelList'] = projetoStakeholdersModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		dataInicio = Util.stringToDate(plutoRow.cells['dataInicio']?.value);
		dataPrevisaoFim = Util.stringToDate(plutoRow.cells['dataPrevisaoFim']?.value);
		dataFim = Util.stringToDate(plutoRow.cells['dataFim']?.value);
		valorOrcamento = plutoRow.cells['valorOrcamento']?.value?.toDouble();
		linkQuadroKanban = plutoRow.cells['linkQuadroKanban']?.value;
		observacao = plutoRow.cells['observacao']?.value;
		projetoCronogramaModelList = [];
		projetoRiscoModelList = [];
		projetoCustoModelList = [];
		projetoStakeholdersModelList = [];
	}	

	ProjetoPrincipalModel clone() {
		return ProjetoPrincipalModel(
			id: id,
			nome: nome,
			dataInicio: dataInicio,
			dataPrevisaoFim: dataPrevisaoFim,
			dataFim: dataFim,
			valorOrcamento: valorOrcamento,
			linkQuadroKanban: linkQuadroKanban,
			observacao: observacao,
			projetoCronogramaModelList: projetoCronogramaModelListClone(projetoCronogramaModelList!),
			projetoRiscoModelList: projetoRiscoModelListClone(projetoRiscoModelList!),
			projetoCustoModelList: projetoCustoModelListClone(projetoCustoModelList!),
			projetoStakeholdersModelList: projetoStakeholdersModelListClone(projetoStakeholdersModelList!),
		);			
	}

	projetoCronogramaModelListClone(List<ProjetoCronogramaModel> projetoCronogramaModelList) { 
		List<ProjetoCronogramaModel> resultList = [];
		for (var projetoCronogramaModel in projetoCronogramaModelList) {
			resultList.add(
				ProjetoCronogramaModel(
					id: projetoCronogramaModel.id,
					idProjetoPrincipal: projetoCronogramaModel.idProjetoPrincipal,
					tarefa: projetoCronogramaModel.tarefa,
					dataTarefa: projetoCronogramaModel.dataTarefa,
					descricao: projetoCronogramaModel.descricao,
				)
			);
		}
		return resultList;
	}

	projetoRiscoModelListClone(List<ProjetoRiscoModel> projetoRiscoModelList) { 
		List<ProjetoRiscoModel> resultList = [];
		for (var projetoRiscoModel in projetoRiscoModelList) {
			resultList.add(
				ProjetoRiscoModel(
					id: projetoRiscoModel.id,
					idProjetoPrincipal: projetoRiscoModel.idProjetoPrincipal,
					nome: projetoRiscoModel.nome,
					probabilidade: projetoRiscoModel.probabilidade,
					impacto: projetoRiscoModel.impacto,
					descricao: projetoRiscoModel.descricao,
				)
			);
		}
		return resultList;
	}

	projetoCustoModelListClone(List<ProjetoCustoModel> projetoCustoModelList) { 
		List<ProjetoCustoModel> resultList = [];
		for (var projetoCustoModel in projetoCustoModelList) {
			resultList.add(
				ProjetoCustoModel(
					id: projetoCustoModel.id,
					idProjetoPrincipal: projetoCustoModel.idProjetoPrincipal,
					idFinNaturezaFinanceira: projetoCustoModel.idFinNaturezaFinanceira,
					nome: projetoCustoModel.nome,
					valorMensal: projetoCustoModel.valorMensal,
					valorTotal: projetoCustoModel.valorTotal,
					justificativa: projetoCustoModel.justificativa,
				)
			);
		}
		return resultList;
	}

	projetoStakeholdersModelListClone(List<ProjetoStakeholdersModel> projetoStakeholdersModelList) { 
		List<ProjetoStakeholdersModel> resultList = [];
		for (var projetoStakeholdersModel in projetoStakeholdersModelList) {
			resultList.add(
				ProjetoStakeholdersModel(
					id: projetoStakeholdersModel.id,
					idProjetoPrincipal: projetoStakeholdersModel.idProjetoPrincipal,
					idColaborador: projetoStakeholdersModel.idColaborador,
				)
			);
		}
		return resultList;
	}

	
}