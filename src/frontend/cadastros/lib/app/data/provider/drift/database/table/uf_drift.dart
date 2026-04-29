import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Uf")
class Ufs extends Table {
	@override
	String get tableName => 'uf';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get sigla => text().named('sigla').withLength(min: 0, max: 2).nullable()();
	IntColumn get codigoIbge => integer().named('codigo_ibge').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class UfGrouped {
	Uf? uf; 

  UfGrouped({
		this.uf, 

  });
}
