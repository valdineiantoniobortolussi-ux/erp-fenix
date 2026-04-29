import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';
import 'package:ponto/app/data/provider/drift/database/database_imports.dart';

@DataClassName("PontoEscala")
class PontoEscalas extends Table {
	@override
	String get tableName => 'ponto_escala';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descontoHoraDia => text().named('desconto_hora_dia').withLength(min: 0, max: 8).nullable()();
	TextColumn get descontoDsr => text().named('desconto_dsr').withLength(min: 0, max: 8).nullable()();
	TextColumn get codigoHorarioDomingo => text().named('codigo_horario_domingo').withLength(min: 0, max: 4).nullable()();
	TextColumn get codigoHorarioSegunda => text().named('codigo_horario_segunda').withLength(min: 0, max: 4).nullable()();
	TextColumn get codigoHorarioTerca => text().named('codigo_horario_terca').withLength(min: 0, max: 4).nullable()();
	TextColumn get codigoHorarioQuarta => text().named('codigo_horario_quarta').withLength(min: 0, max: 4).nullable()();
	TextColumn get codigoHorarioQuinta => text().named('codigo_horario_quinta').withLength(min: 0, max: 4).nullable()();
	TextColumn get codigoHorarioSexta => text().named('codigo_horario_sexta').withLength(min: 0, max: 4).nullable()();
	TextColumn get codigoHorarioSabado => text().named('codigo_horario_sabado').withLength(min: 0, max: 4).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoEscalaGrouped {
	PontoEscala? pontoEscala; 
	List<PontoTurmaGrouped>? pontoTurmaGroupedList; 

  PontoEscalaGrouped({
		this.pontoEscala, 
		this.pontoTurmaGroupedList, 

  });
}
