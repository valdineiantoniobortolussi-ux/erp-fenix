import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:agenda/app/infra/infra_imports.dart';
import 'package:agenda/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:agenda/app/data/domain/domain_imports.dart';

class AgendaCompromissoModel {
	int? id;
	int? idAgendaCategoriaCompromisso;
	int? idColaborador;
	DateTime? dataCompromisso;
	String? hora;
	int? duracao;
	String? tipo;
	String? onde;
	String? descricao;
	List<AgendaNotificacaoModel>? agendaNotificacaoModelList;
	List<AgendaCompromissoConvidadoModel>? agendaCompromissoConvidadoModelList;
	List<ReuniaoSalaEventoModel>? reuniaoSalaEventoModelList;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	AgendaCategoriaCompromissoModel? agendaCategoriaCompromissoModel;

	AgendaCompromissoModel({
		this.id,
		this.idAgendaCategoriaCompromisso,
		this.idColaborador,
		this.dataCompromisso,
		this.hora,
		this.duracao,
		this.tipo,
		this.onde,
		this.descricao,
		this.agendaNotificacaoModelList,
		this.agendaCompromissoConvidadoModelList,
		this.reuniaoSalaEventoModelList,
		this.viewPessoaColaboradorModel,
		this.agendaCategoriaCompromissoModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_compromisso',
		'hora',
		'duracao',
		'tipo',
		'onde',
		'descricao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Compromisso',
		'Hora',
		'Duracao',
		'Tipo',
		'Onde',
		'Descricao',
	];

	AgendaCompromissoModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idAgendaCategoriaCompromisso = jsonData['idAgendaCategoriaCompromisso'];
		idColaborador = jsonData['idColaborador'];
		dataCompromisso = jsonData['dataCompromisso'] != null ? DateTime.tryParse(jsonData['dataCompromisso']) : null;
		hora = jsonData['hora'];
		duracao = jsonData['duracao'];
		tipo = AgendaCompromissoDomain.getTipo(jsonData['tipo']);
		onde = jsonData['onde'];
		descricao = jsonData['descricao'];
		agendaNotificacaoModelList = (jsonData['agendaNotificacaoModelList'] as Iterable?)?.map((m) => AgendaNotificacaoModel.fromJson(m)).toList() ?? [];
		agendaCompromissoConvidadoModelList = (jsonData['agendaCompromissoConvidadoModelList'] as Iterable?)?.map((m) => AgendaCompromissoConvidadoModel.fromJson(m)).toList() ?? [];
		reuniaoSalaEventoModelList = (jsonData['reuniaoSalaEventoModelList'] as Iterable?)?.map((m) => ReuniaoSalaEventoModel.fromJson(m)).toList() ?? [];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		agendaCategoriaCompromissoModel = jsonData['agendaCategoriaCompromissoModel'] == null ? AgendaCategoriaCompromissoModel() : AgendaCategoriaCompromissoModel.fromJson(jsonData['agendaCategoriaCompromissoModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idAgendaCategoriaCompromisso'] = idAgendaCategoriaCompromisso != 0 ? idAgendaCategoriaCompromisso : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataCompromisso'] = dataCompromisso != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataCompromisso!) : null;
		jsonData['hora'] = hora;
		jsonData['duracao'] = duracao;
		jsonData['tipo'] = AgendaCompromissoDomain.setTipo(tipo);
		jsonData['onde'] = onde;
		jsonData['descricao'] = descricao;
		
		var agendaNotificacaoModelLocalList = []; 
		for (AgendaNotificacaoModel object in agendaNotificacaoModelList ?? []) { 
			agendaNotificacaoModelLocalList.add(object.toJson); 
		}
		jsonData['agendaNotificacaoModelList'] = agendaNotificacaoModelLocalList;
		
		var agendaCompromissoConvidadoModelLocalList = []; 
		for (AgendaCompromissoConvidadoModel object in agendaCompromissoConvidadoModelList ?? []) { 
			agendaCompromissoConvidadoModelLocalList.add(object.toJson); 
		}
		jsonData['agendaCompromissoConvidadoModelList'] = agendaCompromissoConvidadoModelLocalList;
		
		var reuniaoSalaEventoModelLocalList = []; 
		for (ReuniaoSalaEventoModel object in reuniaoSalaEventoModelList ?? []) { 
			reuniaoSalaEventoModelLocalList.add(object.toJson); 
		}
		jsonData['reuniaoSalaEventoModelList'] = reuniaoSalaEventoModelLocalList;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['agendaCategoriaCompromissoModel'] = agendaCategoriaCompromissoModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idAgendaCategoriaCompromisso = plutoRow.cells['idAgendaCategoriaCompromisso']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		dataCompromisso = Util.stringToDate(plutoRow.cells['dataCompromisso']?.value);
		hora = plutoRow.cells['hora']?.value;
		duracao = plutoRow.cells['duracao']?.value;
		tipo = plutoRow.cells['tipo']?.value != '' ? plutoRow.cells['tipo']?.value : 'Pessoal';
		onde = plutoRow.cells['onde']?.value;
		descricao = plutoRow.cells['descricao']?.value;
		agendaNotificacaoModelList = [];
		agendaCompromissoConvidadoModelList = [];
		reuniaoSalaEventoModelList = [];
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		agendaCategoriaCompromissoModel = AgendaCategoriaCompromissoModel();
		agendaCategoriaCompromissoModel?.nome = plutoRow.cells['agendaCategoriaCompromissoModel']?.value;
	}	

	AgendaCompromissoModel clone() {
		return AgendaCompromissoModel(
			id: id,
			idAgendaCategoriaCompromisso: idAgendaCategoriaCompromisso,
			idColaborador: idColaborador,
			dataCompromisso: dataCompromisso,
			hora: hora,
			duracao: duracao,
			tipo: tipo,
			onde: onde,
			descricao: descricao,
			agendaNotificacaoModelList: agendaNotificacaoModelListClone(agendaNotificacaoModelList!),
			agendaCompromissoConvidadoModelList: agendaCompromissoConvidadoModelListClone(agendaCompromissoConvidadoModelList!),
			reuniaoSalaEventoModelList: reuniaoSalaEventoModelListClone(reuniaoSalaEventoModelList!),
		);			
	}

	agendaNotificacaoModelListClone(List<AgendaNotificacaoModel> agendaNotificacaoModelList) { 
		List<AgendaNotificacaoModel> resultList = [];
		for (var agendaNotificacaoModel in agendaNotificacaoModelList) {
			resultList.add(
				AgendaNotificacaoModel(
					id: agendaNotificacaoModel.id,
					idAgendaCompromisso: agendaNotificacaoModel.idAgendaCompromisso,
					dataNotificacao: agendaNotificacaoModel.dataNotificacao,
					hora: agendaNotificacaoModel.hora,
					tipo: agendaNotificacaoModel.tipo,
				)
			);
		}
		return resultList;
	}

	agendaCompromissoConvidadoModelListClone(List<AgendaCompromissoConvidadoModel> agendaCompromissoConvidadoModelList) { 
		List<AgendaCompromissoConvidadoModel> resultList = [];
		for (var agendaCompromissoConvidadoModel in agendaCompromissoConvidadoModelList) {
			resultList.add(
				AgendaCompromissoConvidadoModel(
					id: agendaCompromissoConvidadoModel.id,
					idAgendaCompromisso: agendaCompromissoConvidadoModel.idAgendaCompromisso,
					idColaborador: agendaCompromissoConvidadoModel.idColaborador,
				)
			);
		}
		return resultList;
	}

	reuniaoSalaEventoModelListClone(List<ReuniaoSalaEventoModel> reuniaoSalaEventoModelList) { 
		List<ReuniaoSalaEventoModel> resultList = [];
		for (var reuniaoSalaEventoModel in reuniaoSalaEventoModelList) {
			resultList.add(
				ReuniaoSalaEventoModel(
					id: reuniaoSalaEventoModel.id,
					idAgendaCompromisso: reuniaoSalaEventoModel.idAgendaCompromisso,
					idReuniaoSala: reuniaoSalaEventoModel.idReuniaoSala,
					dataReserva: reuniaoSalaEventoModel.dataReserva,
				)
			);
		}
		return resultList;
	}

	
}