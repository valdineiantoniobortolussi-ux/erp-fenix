import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoFechamentoJornada")
class PontoFechamentoJornadas extends Table {
	@override
	String get tableName => 'ponto_fechamento_jornada';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPontoClassificacaoJornada => integer().named('id_ponto_classificacao_jornada').nullable()();
	IntColumn get idColaborador => integer().named('id_colaborador').nullable()();
	DateTimeColumn get dataFechamento => dateTime().named('data_fechamento').nullable()();
	TextColumn get diaSemana => text().named('dia_semana').withLength(min: 0, max: 7).nullable()();
	TextColumn get codigoHorario => text().named('codigo_horario').withLength(min: 0, max: 4).nullable()();
	TextColumn get cargaHorariaEsperada => text().named('carga_horaria_esperada').withLength(min: 0, max: 8).nullable()();
	TextColumn get cargaHorariaDiurna => text().named('carga_horaria_diurna').withLength(min: 0, max: 8).nullable()();
	TextColumn get cargaHorariaNoturna => text().named('carga_horaria_noturna').withLength(min: 0, max: 8).nullable()();
	TextColumn get cargaHorariaTotal => text().named('carga_horaria_total').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada01 => text().named('entrada01').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida01 => text().named('saida01').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada02 => text().named('entrada02').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida02 => text().named('saida02').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada03 => text().named('entrada03').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida03 => text().named('saida03').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada04 => text().named('entrada04').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida04 => text().named('saida04').withLength(min: 0, max: 8).nullable()();
	TextColumn get entrada05 => text().named('entrada05').withLength(min: 0, max: 8).nullable()();
	TextColumn get saida05 => text().named('saida05').withLength(min: 0, max: 8).nullable()();
	TextColumn get horaInicioJornada => text().named('hora_inicio_jornada').withLength(min: 0, max: 8).nullable()();
	TextColumn get horaFimJornada => text().named('hora_fim_jornada').withLength(min: 0, max: 8).nullable()();
	TextColumn get horaExtra01 => text().named('hora_extra01').withLength(min: 0, max: 8).nullable()();
	RealColumn get percentualHoraExtra01 => real().named('percentual_hora_extra01').nullable()();
	TextColumn get modalidadeHoraExtra01 => text().named('modalidade_hora_extra01').withLength(min: 0, max: 1).nullable()();
	TextColumn get horaExtra02 => text().named('hora_extra02').withLength(min: 0, max: 8).nullable()();
	RealColumn get percentualHoraExtra02 => real().named('percentual_hora_extra02').nullable()();
	TextColumn get modalidadeHoraExtra02 => text().named('modalidade_hora_extra02').withLength(min: 0, max: 1).nullable()();
	TextColumn get horaExtra03 => text().named('hora_extra03').withLength(min: 0, max: 8).nullable()();
	RealColumn get percentualHoraExtra03 => real().named('percentual_hora_extra03').nullable()();
	TextColumn get modalidadeHoraExtra03 => text().named('modalidade_hora_extra03').withLength(min: 0, max: 1).nullable()();
	TextColumn get horaExtra04 => text().named('hora_extra04').withLength(min: 0, max: 8).nullable()();
	RealColumn get percentualHoraExtra04 => real().named('percentual_hora_extra04').nullable()();
	TextColumn get modalidadeHoraExtra04 => text().named('modalidade_hora_extra04').withLength(min: 0, max: 1).nullable()();
	TextColumn get faltaAtraso => text().named('falta_atraso').withLength(min: 0, max: 8).nullable()();
	TextColumn get compensar => text().named('compensar').withLength(min: 0, max: 1).nullable()();
	TextColumn get bancoHoras => text().named('banco_horas').withLength(min: 0, max: 8).nullable()();
	TextColumn get observacao => text().named('observacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoFechamentoJornadaGrouped {
	PontoFechamentoJornada? pontoFechamentoJornada; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	PontoClassificacaoJornada? pontoClassificacaoJornada; 

  PontoFechamentoJornadaGrouped({
		this.pontoFechamentoJornada, 
		this.viewPessoaColaborador, 
		this.pontoClassificacaoJornada, 

  });
}
