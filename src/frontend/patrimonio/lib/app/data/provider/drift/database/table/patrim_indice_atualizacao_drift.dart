import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimIndiceAtualizacao")
class PatrimIndiceAtualizacaos extends Table {
	@override
	String get tableName => 'patrim_indice_atualizacao';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataIndice => dateTime().named('data_indice').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 10).nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	RealColumn get valorAlternativo => real().named('valor_alternativo').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimIndiceAtualizacaoGrouped {
	PatrimIndiceAtualizacao? patrimIndiceAtualizacao; 

  PatrimIndiceAtualizacaoGrouped({
		this.patrimIndiceAtualizacao, 

  });
}
