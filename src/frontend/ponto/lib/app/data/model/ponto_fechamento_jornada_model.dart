import 'dart:convert';
import 'package:pluto_grid/pluto_grid.dart';

import 'package:ponto/app/infra/infra_imports.dart';
import 'package:ponto/app/data/model/model_imports.dart';
import 'package:intl/intl.dart';
import 'package:ponto/app/data/domain/domain_imports.dart';

class PontoFechamentoJornadaModel {
	int? id;
	int? idPontoClassificacaoJornada;
	int? idColaborador;
	DateTime? dataFechamento;
	String? diaSemana;
	String? codigoHorario;
	String? cargaHorariaEsperada;
	String? cargaHorariaDiurna;
	String? cargaHorariaNoturna;
	String? cargaHorariaTotal;
	String? entrada01;
	String? saida01;
	String? entrada02;
	String? saida02;
	String? entrada03;
	String? saida03;
	String? entrada04;
	String? saida04;
	String? entrada05;
	String? saida05;
	String? horaInicioJornada;
	String? horaFimJornada;
	String? horaExtra01;
	double? percentualHoraExtra01;
	String? modalidadeHoraExtra01;
	String? horaExtra02;
	double? percentualHoraExtra02;
	String? modalidadeHoraExtra02;
	String? horaExtra03;
	double? percentualHoraExtra03;
	String? modalidadeHoraExtra03;
	String? horaExtra04;
	double? percentualHoraExtra04;
	String? modalidadeHoraExtra04;
	String? faltaAtraso;
	String? compensar;
	String? bancoHoras;
	String? observacao;
	ViewPessoaColaboradorModel? viewPessoaColaboradorModel;
	PontoClassificacaoJornadaModel? pontoClassificacaoJornadaModel;

	PontoFechamentoJornadaModel({
		this.id,
		this.idPontoClassificacaoJornada,
		this.idColaborador,
		this.dataFechamento,
		this.diaSemana,
		this.codigoHorario,
		this.cargaHorariaEsperada,
		this.cargaHorariaDiurna,
		this.cargaHorariaNoturna,
		this.cargaHorariaTotal,
		this.entrada01,
		this.saida01,
		this.entrada02,
		this.saida02,
		this.entrada03,
		this.saida03,
		this.entrada04,
		this.saida04,
		this.entrada05,
		this.saida05,
		this.horaInicioJornada,
		this.horaFimJornada,
		this.horaExtra01,
		this.percentualHoraExtra01,
		this.modalidadeHoraExtra01,
		this.horaExtra02,
		this.percentualHoraExtra02,
		this.modalidadeHoraExtra02,
		this.horaExtra03,
		this.percentualHoraExtra03,
		this.modalidadeHoraExtra03,
		this.horaExtra04,
		this.percentualHoraExtra04,
		this.modalidadeHoraExtra04,
		this.faltaAtraso,
		this.compensar,
		this.bancoHoras,
		this.observacao,
		this.viewPessoaColaboradorModel,
		this.pontoClassificacaoJornadaModel,
	});

	static List<String> dbColumns = <String>[
		'id',
		'data_fechamento',
		'dia_semana',
		'codigo_horario',
		'carga_horaria_esperada',
		'carga_horaria_diurna',
		'carga_horaria_noturna',
		'carga_horaria_total',
		'entrada01',
		'saida01',
		'entrada02',
		'saida02',
		'entrada03',
		'saida03',
		'entrada04',
		'saida04',
		'entrada05',
		'saida05',
		'hora_inicio_jornada',
		'hora_fim_jornada',
		'hora_extra01',
		'percentual_hora_extra01',
		'modalidade_hora_extra01',
		'hora_extra02',
		'percentual_hora_extra02',
		'modalidade_hora_extra02',
		'hora_extra03',
		'percentual_hora_extra03',
		'modalidade_hora_extra03',
		'hora_extra04',
		'percentual_hora_extra04',
		'modalidade_hora_extra04',
		'falta_atraso',
		'compensar',
		'banco_horas',
		'observacao',
	];
	
	static List<String> aliasColumns = <String>[
		'Id',
		'Data Fechamento',
		'Dia Semana',
		'Codigo Horario',
		'Carga Horaria Esperada',
		'Carga Horaria Diurna',
		'Carga Horaria Noturna',
		'Carga Horaria Total',
		'Entrada01',
		'Saida01',
		'Entrada02',
		'Saida02',
		'Entrada03',
		'Saida03',
		'Entrada04',
		'Saida04',
		'Entrada05',
		'Saida05',
		'Hora Inicio Jornada',
		'Hora Fim Jornada',
		'Hora Extra01',
		'Percentual Hora Extra01',
		'Modalidade Hora Extra01',
		'Hora Extra02',
		'Percentual Hora Extra02',
		'Modalidade Hora Extra02',
		'Hora Extra03',
		'Percentual Hora Extra03',
		'Modalidade Hora Extra03',
		'Hora Extra04',
		'Percentual Hora Extra04',
		'Modalidade Hora Extra04',
		'Falta Atraso',
		'Compensar',
		'Banco Horas',
		'Observacao',
	];

	PontoFechamentoJornadaModel.fromJson(Map<String, dynamic> jsonData) {
		id = jsonData['id'];
		idPontoClassificacaoJornada = jsonData['idPontoClassificacaoJornada'];
		idColaborador = jsonData['idColaborador'];
		dataFechamento = jsonData['dataFechamento'] != null ? DateTime.tryParse(jsonData['dataFechamento']) : null;
		diaSemana = PontoFechamentoJornadaDomain.getDiaSemana(jsonData['diaSemana']);
		codigoHorario = jsonData['codigoHorario'];
		cargaHorariaEsperada = jsonData['cargaHorariaEsperada'];
		cargaHorariaDiurna = jsonData['cargaHorariaDiurna'];
		cargaHorariaNoturna = jsonData['cargaHorariaNoturna'];
		cargaHorariaTotal = jsonData['cargaHorariaTotal'];
		entrada01 = jsonData['entrada01'];
		saida01 = jsonData['saida01'];
		entrada02 = jsonData['entrada02'];
		saida02 = jsonData['saida02'];
		entrada03 = jsonData['entrada03'];
		saida03 = jsonData['saida03'];
		entrada04 = jsonData['entrada04'];
		saida04 = jsonData['saida04'];
		entrada05 = jsonData['entrada05'];
		saida05 = jsonData['saida05'];
		horaInicioJornada = jsonData['horaInicioJornada'];
		horaFimJornada = jsonData['horaFimJornada'];
		horaExtra01 = jsonData['horaExtra01'];
		percentualHoraExtra01 = jsonData['percentualHoraExtra01']?.toDouble();
		modalidadeHoraExtra01 = PontoFechamentoJornadaDomain.getModalidadeHoraExtra01(jsonData['modalidadeHoraExtra01']);
		horaExtra02 = jsonData['horaExtra02'];
		percentualHoraExtra02 = jsonData['percentualHoraExtra02']?.toDouble();
		modalidadeHoraExtra02 = PontoFechamentoJornadaDomain.getModalidadeHoraExtra02(jsonData['modalidadeHoraExtra02']);
		horaExtra03 = jsonData['horaExtra03'];
		percentualHoraExtra03 = jsonData['percentualHoraExtra03']?.toDouble();
		modalidadeHoraExtra03 = PontoFechamentoJornadaDomain.getModalidadeHoraExtra03(jsonData['modalidadeHoraExtra03']);
		horaExtra04 = jsonData['horaExtra04'];
		percentualHoraExtra04 = jsonData['percentualHoraExtra04']?.toDouble();
		modalidadeHoraExtra04 = PontoFechamentoJornadaDomain.getModalidadeHoraExtra04(jsonData['modalidadeHoraExtra04']);
		faltaAtraso = jsonData['faltaAtraso'];
		compensar = PontoFechamentoJornadaDomain.getCompensar(jsonData['compensar']);
		bancoHoras = jsonData['bancoHoras'];
		observacao = jsonData['observacao'];
		viewPessoaColaboradorModel = jsonData['viewPessoaColaboradorModel'] == null ? ViewPessoaColaboradorModel() : ViewPessoaColaboradorModel.fromJson(jsonData['viewPessoaColaboradorModel']);
		pontoClassificacaoJornadaModel = jsonData['pontoClassificacaoJornadaModel'] == null ? PontoClassificacaoJornadaModel() : PontoClassificacaoJornadaModel.fromJson(jsonData['pontoClassificacaoJornadaModel']);
	}

	Map<String, dynamic> get toJson {
		Map<String, dynamic> jsonData = <String, dynamic>{};

		jsonData['id'] = id != 0 ? id : null;
		jsonData['idPontoClassificacaoJornada'] = idPontoClassificacaoJornada != 0 ? idPontoClassificacaoJornada : null;
		jsonData['idColaborador'] = idColaborador != 0 ? idColaborador : null;
		jsonData['dataFechamento'] = dataFechamento != null ? DateFormat('yyyy-MM-ddT00:00:00').format(dataFechamento!) : null;
		jsonData['diaSemana'] = PontoFechamentoJornadaDomain.setDiaSemana(diaSemana);
		jsonData['codigoHorario'] = codigoHorario;
		jsonData['cargaHorariaEsperada'] = Util.removeMask(cargaHorariaEsperada);
		jsonData['cargaHorariaDiurna'] = Util.removeMask(cargaHorariaDiurna);
		jsonData['cargaHorariaNoturna'] = Util.removeMask(cargaHorariaNoturna);
		jsonData['cargaHorariaTotal'] = Util.removeMask(cargaHorariaTotal);
		jsonData['entrada01'] = Util.removeMask(entrada01);
		jsonData['saida01'] = Util.removeMask(saida01);
		jsonData['entrada02'] = Util.removeMask(entrada02);
		jsonData['saida02'] = Util.removeMask(saida02);
		jsonData['entrada03'] = Util.removeMask(entrada03);
		jsonData['saida03'] = Util.removeMask(saida03);
		jsonData['entrada04'] = Util.removeMask(entrada04);
		jsonData['saida04'] = Util.removeMask(saida04);
		jsonData['entrada05'] = Util.removeMask(entrada05);
		jsonData['saida05'] = Util.removeMask(saida05);
		jsonData['horaInicioJornada'] = Util.removeMask(horaInicioJornada);
		jsonData['horaFimJornada'] = Util.removeMask(horaFimJornada);
		jsonData['horaExtra01'] = Util.removeMask(horaExtra01);
		jsonData['percentualHoraExtra01'] = percentualHoraExtra01;
		jsonData['modalidadeHoraExtra01'] = PontoFechamentoJornadaDomain.setModalidadeHoraExtra01(modalidadeHoraExtra01);
		jsonData['horaExtra02'] = Util.removeMask(horaExtra02);
		jsonData['percentualHoraExtra02'] = percentualHoraExtra02;
		jsonData['modalidadeHoraExtra02'] = PontoFechamentoJornadaDomain.setModalidadeHoraExtra02(modalidadeHoraExtra02);
		jsonData['horaExtra03'] = Util.removeMask(horaExtra03);
		jsonData['percentualHoraExtra03'] = percentualHoraExtra03;
		jsonData['modalidadeHoraExtra03'] = PontoFechamentoJornadaDomain.setModalidadeHoraExtra03(modalidadeHoraExtra03);
		jsonData['horaExtra04'] = Util.removeMask(horaExtra04);
		jsonData['percentualHoraExtra04'] = percentualHoraExtra04;
		jsonData['modalidadeHoraExtra04'] = PontoFechamentoJornadaDomain.setModalidadeHoraExtra04(modalidadeHoraExtra04);
		jsonData['faltaAtraso'] = Util.removeMask(faltaAtraso);
		jsonData['compensar'] = PontoFechamentoJornadaDomain.setCompensar(compensar);
		jsonData['bancoHoras'] = Util.removeMask(bancoHoras);
		jsonData['observacao'] = observacao;
		jsonData['viewPessoaColaboradorModel'] = viewPessoaColaboradorModel?.toJson;
		jsonData['pontoClassificacaoJornadaModel'] = pontoClassificacaoJornadaModel?.toJson;
	
		return jsonData;
	}
	
	String objectEncodeJson() {
		final jsonData = toJson;
		return json.encode(jsonData);
	}

	plutoRowToObject(PlutoRow plutoRow) {
		id = plutoRow.cells['id']?.value;
		idPontoClassificacaoJornada = plutoRow.cells['idPontoClassificacaoJornada']?.value;
		idColaborador = plutoRow.cells['idColaborador']?.value;
		dataFechamento = Util.stringToDate(plutoRow.cells['dataFechamento']?.value);
		diaSemana = plutoRow.cells['diaSemana']?.value != '' ? plutoRow.cells['diaSemana']?.value : 'DOMINGO';
		codigoHorario = plutoRow.cells['codigoHorario']?.value;
		cargaHorariaEsperada = plutoRow.cells['cargaHorariaEsperada']?.value;
		cargaHorariaDiurna = plutoRow.cells['cargaHorariaDiurna']?.value;
		cargaHorariaNoturna = plutoRow.cells['cargaHorariaNoturna']?.value;
		cargaHorariaTotal = plutoRow.cells['cargaHorariaTotal']?.value;
		entrada01 = plutoRow.cells['entrada01']?.value;
		saida01 = plutoRow.cells['saida01']?.value;
		entrada02 = plutoRow.cells['entrada02']?.value;
		saida02 = plutoRow.cells['saida02']?.value;
		entrada03 = plutoRow.cells['entrada03']?.value;
		saida03 = plutoRow.cells['saida03']?.value;
		entrada04 = plutoRow.cells['entrada04']?.value;
		saida04 = plutoRow.cells['saida04']?.value;
		entrada05 = plutoRow.cells['entrada05']?.value;
		saida05 = plutoRow.cells['saida05']?.value;
		horaInicioJornada = plutoRow.cells['horaInicioJornada']?.value;
		horaFimJornada = plutoRow.cells['horaFimJornada']?.value;
		horaExtra01 = plutoRow.cells['horaExtra01']?.value;
		percentualHoraExtra01 = plutoRow.cells['percentualHoraExtra01']?.value?.toDouble();
		modalidadeHoraExtra01 = plutoRow.cells['modalidadeHoraExtra01']?.value != '' ? plutoRow.cells['modalidadeHoraExtra01']?.value : 'Diurna';
		horaExtra02 = plutoRow.cells['horaExtra02']?.value;
		percentualHoraExtra02 = plutoRow.cells['percentualHoraExtra02']?.value?.toDouble();
		modalidadeHoraExtra02 = plutoRow.cells['modalidadeHoraExtra02']?.value != '' ? plutoRow.cells['modalidadeHoraExtra02']?.value : 'Diurna';
		horaExtra03 = plutoRow.cells['horaExtra03']?.value;
		percentualHoraExtra03 = plutoRow.cells['percentualHoraExtra03']?.value?.toDouble();
		modalidadeHoraExtra03 = plutoRow.cells['modalidadeHoraExtra03']?.value != '' ? plutoRow.cells['modalidadeHoraExtra03']?.value : 'Diurna';
		horaExtra04 = plutoRow.cells['horaExtra04']?.value;
		percentualHoraExtra04 = plutoRow.cells['percentualHoraExtra04']?.value?.toDouble();
		modalidadeHoraExtra04 = plutoRow.cells['modalidadeHoraExtra04']?.value != '' ? plutoRow.cells['modalidadeHoraExtra04']?.value : 'Diurna';
		faltaAtraso = plutoRow.cells['faltaAtraso']?.value;
		compensar = plutoRow.cells['compensar']?.value != '' ? plutoRow.cells['compensar']?.value : 'Horas a mais';
		bancoHoras = plutoRow.cells['bancoHoras']?.value;
		observacao = plutoRow.cells['observacao']?.value;
		viewPessoaColaboradorModel = ViewPessoaColaboradorModel();
		viewPessoaColaboradorModel?.nome = plutoRow.cells['viewPessoaColaboradorModel']?.value;
		pontoClassificacaoJornadaModel = PontoClassificacaoJornadaModel();
		pontoClassificacaoJornadaModel?.nome = plutoRow.cells['pontoClassificacaoJornadaModel']?.value;
	}	

	PontoFechamentoJornadaModel clone() {
		return PontoFechamentoJornadaModel(
			id: id,
			idPontoClassificacaoJornada: idPontoClassificacaoJornada,
			idColaborador: idColaborador,
			dataFechamento: dataFechamento,
			diaSemana: diaSemana,
			codigoHorario: codigoHorario,
			cargaHorariaEsperada: cargaHorariaEsperada,
			cargaHorariaDiurna: cargaHorariaDiurna,
			cargaHorariaNoturna: cargaHorariaNoturna,
			cargaHorariaTotal: cargaHorariaTotal,
			entrada01: entrada01,
			saida01: saida01,
			entrada02: entrada02,
			saida02: saida02,
			entrada03: entrada03,
			saida03: saida03,
			entrada04: entrada04,
			saida04: saida04,
			entrada05: entrada05,
			saida05: saida05,
			horaInicioJornada: horaInicioJornada,
			horaFimJornada: horaFimJornada,
			horaExtra01: horaExtra01,
			percentualHoraExtra01: percentualHoraExtra01,
			modalidadeHoraExtra01: modalidadeHoraExtra01,
			horaExtra02: horaExtra02,
			percentualHoraExtra02: percentualHoraExtra02,
			modalidadeHoraExtra02: modalidadeHoraExtra02,
			horaExtra03: horaExtra03,
			percentualHoraExtra03: percentualHoraExtra03,
			modalidadeHoraExtra03: modalidadeHoraExtra03,
			horaExtra04: horaExtra04,
			percentualHoraExtra04: percentualHoraExtra04,
			modalidadeHoraExtra04: modalidadeHoraExtra04,
			faltaAtraso: faltaAtraso,
			compensar: compensar,
			bancoHoras: bancoHoras,
			observacao: observacao,
		);			
	}

	
}