import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoParametro")
class PontoParametros extends Table {
	@override
	String get tableName => 'ponto_parametro';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get mesAno => text().named('mes_ano').withLength(min: 0, max: 7).nullable()();
	IntColumn get diaInicialApuracao => integer().named('dia_inicial_apuracao').nullable()();
	TextColumn get horaNoturnaInicio => text().named('hora_noturna_inicio').withLength(min: 0, max: 8).nullable()();
	TextColumn get horaNoturnaFim => text().named('hora_noturna_fim').withLength(min: 0, max: 8).nullable()();
	TextColumn get periodoMinimoInterjornada => text().named('periodo_minimo_interjornada').withLength(min: 0, max: 8).nullable()();
	RealColumn get percentualHeDiurna => real().named('percentual_he_diurna').nullable()();
	RealColumn get percentualHeNoturna => real().named('percentual_he_noturna').nullable()();
	TextColumn get duracaoHoraNoturna => text().named('duracao_hora_noturna').withLength(min: 0, max: 8).nullable()();
	TextColumn get tratamentoHoraMais => text().named('tratamento_hora_mais').withLength(min: 0, max: 1).nullable()();
	TextColumn get tratamentoHoraMenos => text().named('tratamento_hora_menos').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoParametroGrouped {
	PontoParametro? pontoParametro; 

  PontoParametroGrouped({
		this.pontoParametro, 

  });
}
