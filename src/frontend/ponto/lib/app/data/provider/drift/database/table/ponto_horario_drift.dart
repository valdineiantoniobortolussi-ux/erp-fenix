import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoHorario")
class PontoHorarios extends Table {
	@override
	String get tableName => 'ponto_horario';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get tipoTrabalho => text().named('tipo_trabalho').withLength(min: 0, max: 1).nullable()();
	TextColumn get cargaHoraria => text().named('carga_horaria').withLength(min: 0, max: 8).nullable()();
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

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoHorarioGrouped {
	PontoHorario? pontoHorario; 

  PontoHorarioGrouped({
		this.pontoHorario, 

  });
}
