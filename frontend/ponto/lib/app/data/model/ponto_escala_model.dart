import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';

class PontoEscalaModel {
	int? id;
	String? nome;
	String? descontoHoraDia;
	String? descontoDsr;
	String? codigoHorarioDomingo;
	String? codigoHorarioSegunda;
	String? codigoHorarioTerca;
	String? codigoHorarioQuarta;
	String? codigoHorarioQuinta;
	String? codigoHorarioSexta;
	String? codigoHorarioSabado;
	List<PontoTurmaModel>? pontoTurmaModelList;

	PontoEscalaModel({
		this.id,
		this.nome,
		this.descontoHoraDia,
		this.descontoDsr,
		this.codigoHorarioDomingo,
		this.codigoHorarioSegunda,
		this.codigoHorarioTerca,
		this.codigoHorarioQuarta,
		this.codigoHorarioQuinta,
		this.codigoHorarioSexta,
		this.codigoHorarioSabado,
		this.pontoTurmaModelList,
	});

	static List<String> dbColumns = <String>[
		'id',
		'nome',
		'desconto_hora_dia',
		'desconto_dsr',
		'codigo_horario_domingo',
		'codigo_horario_segunda',
		'codigo_horario_terca',
		'codigo_horario_quarta',
		'codigo_horario_quinta',
		'codigo_horario_sexta',
		'codigo_horario_sabado',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Nome',
		'Desconto Hora Dia',
		'Desconto Dsr',
		'Codigo Horario Domingo',
		'Codigo Horario Segunda',
		'Codigo Horario Terca',
		'Codigo Horario Quarta',
		'Codigo Horario Quinta',
		'Codigo Horario Sexta',
		'Codigo Horario Sabado',
	];

	PontoEscalaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		nome = jsonData['nome'];
		descontoHoraDia = jsonData['descontoHoraDia'];
		descontoDsr = jsonData['descontoDsr'];
		codigoHorarioDomingo = jsonData['codigoHorarioDomingo'];
		codigoHorarioSegunda = jsonData['codigoHorarioSegunda'];
		codigoHorarioTerca = jsonData['codigoHorarioTerca'];
		codigoHorarioQuarta = jsonData['codigoHorarioQuarta'];
		codigoHorarioQuinta = jsonData['codigoHorarioQuinta'];
		codigoHorarioSexta = jsonData['codigoHorarioSexta'];
		codigoHorarioSabado = jsonData['codigoHorarioSabado'];
		pontoTurmaModelList = (jsonData['pontoTurmaModelList'] as Iterable?)?.map((m) => PontoTurmaModel.fromJson(m)).toList() ?? [];
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['nome'] = nome;
		jsonData['descontoHoraDia'] = Util.removeMask(descontoHoraDia);
		jsonData['descontoDsr'] = Util.removeMask(descontoDsr);
		jsonData['codigoHorarioDomingo'] = codigoHorarioDomingo;
		jsonData['codigoHorarioSegunda'] = codigoHorarioSegunda;
		jsonData['codigoHorarioTerca'] = codigoHorarioTerca;
		jsonData['codigoHorarioQuarta'] = codigoHorarioQuarta;
		jsonData['codigoHorarioQuinta'] = codigoHorarioQuinta;
		jsonData['codigoHorarioSexta'] = codigoHorarioSexta;
		jsonData['codigoHorarioSabado'] = codigoHorarioSabado;
		
		var pontoTurmaModelLocalList = []; 
		for (PontoTurmaModel object in pontoTurmaModelList ?? []) { 
			pontoTurmaModelLocalList.add(object.toJson); 
		}
		jsonData['pontoTurmaModelList'] = pontoTurmaModelLocalList;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		nome = plutoRow.cells['nome']?.value;
		descontoHoraDia = plutoRow.cells['descontoHoraDia']?.value;
		descontoDsr = plutoRow.cells['descontoDsr']?.value;
		codigoHorarioDomingo = plutoRow.cells['codigoHorarioDomingo']?.value;
		codigoHorarioSegunda = plutoRow.cells['codigoHorarioSegunda']?.value;
		codigoHorarioTerca = plutoRow.cells['codigoHorarioTerca']?.value;
		codigoHorarioQuarta = plutoRow.cells['codigoHorarioQuarta']?.value;
		codigoHorarioQuinta = plutoRow.cells['codigoHorarioQuinta']?.value;
		codigoHorarioSexta = plutoRow.cells['codigoHorarioSexta']?.value;
		codigoHorarioSabado = plutoRow.cells['codigoHorarioSabado']?.value;
		pontoTurmaModelList = [];
	}	

	PontoEscalaModel clone() {
		return PontoEscalaModel(
			id: id,
			nome: nome,
			descontoHoraDia: descontoHoraDia,
			descontoDsr: descontoDsr,
			codigoHorarioDomingo: codigoHorarioDomingo,
			codigoHorarioSegunda: codigoHorarioSegunda,
			codigoHorarioTerca: codigoHorarioTerca,
			codigoHorarioQuarta: codigoHorarioQuarta,
			codigoHorarioQuinta: codigoHorarioQuinta,
			codigoHorarioSexta: codigoHorarioSexta,
			codigoHorarioSabado: codigoHorarioSabado,
			pontoTurmaModelList: pontoTurmaModelListClone(pontoTurmaModelList!),
		);			
	}

	pontoTurmaModelListClone(List<PontoTurmaModel> pontoTurmaModelList) { 
		List<PontoTurmaModel> resultList = [];
		for (var pontoTurmaModel in pontoTurmaModelList) {
			resultList.add(
				PontoTurmaModel(
					id: pontoTurmaModel.id,
					idPontoEscala: pontoTurmaModel.idPontoEscala,
					codigo: pontoTurmaModel.codigo,
					nome: pontoTurmaModel.nome,
				)
			);
		}
		return resultList;
	}

	
}