import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("NivelFormacao")
class NivelFormacaos extends Table {
	@override
	String get tableName => 'nivel_formacao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NivelFormacaoGrouped {
	NivelFormacao? nivelFormacao; 

  NivelFormacaoGrouped({
		this.nivelFormacao, 

  });
}
