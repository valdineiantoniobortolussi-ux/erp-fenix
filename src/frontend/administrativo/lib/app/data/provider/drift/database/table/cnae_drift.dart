import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("Cnae")
class Cnaes extends Table {
	@override
	String get tableName => 'cnae';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 7).nullable()();
	TextColumn get denominacao => text().named('denominacao').withLength(min: 0, max: 1000).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CnaeGrouped {
	Cnae? cnae; 

  CnaeGrouped({
		this.cnae, 

  });
}
