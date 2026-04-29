import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("FiscalEstadualPorte")
class FiscalEstadualPortes extends Table {
	@override
	String get tableName => 'fiscal_estadual_porte';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 20).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalEstadualPorteGrouped {
	FiscalEstadualPorte? fiscalEstadualPorte; 

  FiscalEstadualPorteGrouped({
		this.fiscalEstadualPorte, 

  });
}
