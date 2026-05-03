import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimEstadoConservacao")
class PatrimEstadoConservacaos extends Table {
	@override
	String get tableName => 'patrim_estado_conservacao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 1).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimEstadoConservacaoGrouped {
	PatrimEstadoConservacao? patrimEstadoConservacao; 

  PatrimEstadoConservacaoGrouped({
		this.patrimEstadoConservacao, 

  });
}
