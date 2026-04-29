import 'package:drift/drift.dart';
import 'package:ponto/app/data/provider/drift/database/database.dart';

@DataClassName("PontoTurma")
class PontoTurmas extends Table {
	@override
	String get tableName => 'ponto_turma';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPontoEscala => integer().named('id_ponto_escala').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 5).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PontoTurmaGrouped {
	PontoTurma? pontoTurma; 

  PontoTurmaGrouped({
		this.pontoTurma, 

  });
}
