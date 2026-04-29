import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoParametroModel {
	int? id;
	String? mesAno;
	int? diaInicialApuracao;
	String? horaNoturnaInicio;
	String? horaNoturnaFim;
	String? periodoMinimoInterjornada;
	double? percentualHeDiurna;
	double? percentualHeNoturna;
	String? duracaoHoraNoturna;
	String? tratamentoHoraMais;
	String? tratamentoHoraMenos;

	PontoParametroModel({
		this.id,
		this.mesAno,
		this.diaInicialApuracao,
		this.horaNoturnaInicio,
		this.horaNoturnaFim,
		this.periodoMinimoInterjornada,
		this.percentualHeDiurna,
		this.percentualHeNoturna,
		this.duracaoHoraNoturna,
		this.tratamentoHoraMais,
		this.tratamentoHoraMenos,
	});

	static List<String> dbColumns = <String>[
		'id',
		'mes_ano',
		'dia_inicial_apuracao',
		'hora_noturna_inicio',
		'hora_noturna_fim',
		'periodo_minimo_interjornada',
		'percentual_he_diurna',
		'percentual_he_noturna',
		'duracao_hora_noturna',
		'tratamento_hora_mais',
		'tratamento_hora_menos',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Mes Ano',
		'Dia Inicial Apuracao',
		'Hora Noturna Inicio',
		'Hora Noturna Fim',
		'Periodo Minimo Interjornada',
		'Percentual He Diurna',
		'Percentual He Noturna',
		'Duracao Hora Noturna',
		'Tratamento Hora Mais',
		'Tratamento Hora Menos',
	];

	PontoParametroModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		mesAno = jsonData['mesAno'];
		diaInicialApuracao = jsonData['diaInicialApuracao'];
		horaNoturnaInicio = jsonData['horaNoturnaInicio'];
		horaNoturnaFim = jsonData['horaNoturnaFim'];
		periodoMinimoInterjornada = jsonData['periodoMinimoInterjornada'];
		percentualHeDiurna = jsonData['percentualHeDiurna']?.toDouble();
		percentualHeNoturna = jsonData['percentualHeNoturna']?.toDouble();
		duracaoHoraNoturna = jsonData['duracaoHoraNoturna'];
		tratamentoHoraMais = PontoParametroDomain.getTratamentoHoraMais(jsonData['tratamentoHoraMais']);
		tratamentoHoraMenos = PontoParametroDomain.getTratamentoHoraMenos(jsonData['tratamentoHoraMenos']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['mesAno'] = Util.removeMask(mesAno);
		jsonData['diaInicialApuracao'] = diaInicialApuracao;
		jsonData['horaNoturnaInicio'] = Util.removeMask(horaNoturnaInicio);
		jsonData['horaNoturnaFim'] = Util.removeMask(horaNoturnaFim);
		jsonData['periodoMinimoInterjornada'] = Util.removeMask(periodoMinimoInterjornada);
		jsonData['percentualHeDiurna'] = percentualHeDiurna;
		jsonData['percentualHeNoturna'] = percentualHeNoturna;
		jsonData['duracaoHoraNoturna'] = Util.removeMask(duracaoHoraNoturna);
		jsonData['tratamentoHoraMais'] = PontoParametroDomain.setTratamentoHoraMais(tratamentoHoraMais);
		jsonData['tratamentoHoraMenos'] = PontoParametroDomain.setTratamentoHoraMenos(tratamentoHoraMenos);
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		mesAno = plutoRow.cells['mesAno']?.value;
		diaInicialApuracao = plutoRow.cells['diaInicialApuracao']?.value;
		horaNoturnaInicio = plutoRow.cells['horaNoturnaInicio']?.value;
		horaNoturnaFim = plutoRow.cells['horaNoturnaFim']?.value;
		periodoMinimoInterjornada = plutoRow.cells['periodoMinimoInterjornada']?.value;
		percentualHeDiurna = plutoRow.cells['percentualHeDiurna']?.value?.toDouble();
		percentualHeNoturna = plutoRow.cells['percentualHeNoturna']?.value?.toDouble();
		duracaoHoraNoturna = plutoRow.cells['duracaoHoraNoturna']?.value;
		tratamentoHoraMais = plutoRow.cells['tratamentoHoraMais']?.value != '' ? plutoRow.cells['tratamentoHoraMais']?.value : 'Extra';
		tratamentoHoraMenos = plutoRow.cells['tratamentoHoraMenos']?.value != '' ? plutoRow.cells['tratamentoHoraMenos']?.value : 'Falta';
	}	

	PontoParametroModel clone() {
		return PontoParametroModel(
			id: id,
			mesAno: mesAno,
			diaInicialApuracao: diaInicialApuracao,
			horaNoturnaInicio: horaNoturnaInicio,
			horaNoturnaFim: horaNoturnaFim,
			periodoMinimoInterjornada: periodoMinimoInterjornada,
			percentualHeDiurna: percentualHeDiurna,
			percentualHeNoturna: percentualHeNoturna,
			duracaoHoraNoturna: duracaoHoraNoturna,
			tratamentoHoraMais: tratamentoHoraMais,
			tratamentoHoraMenos: tratamentoHoraMenos,
		);			
	}

	
}