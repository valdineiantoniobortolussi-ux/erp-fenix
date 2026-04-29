import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Cfop")
class Cfops extends Table {
	@override
	String get tableName => 'cfop';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get codigo => integer().named('codigo').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();
	TextColumn get aplicacao => text().named('aplicacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CfopGrouped {
	Cfop? cfop; 

  CfopGrouped({
		this.cfop, 

  });
}
