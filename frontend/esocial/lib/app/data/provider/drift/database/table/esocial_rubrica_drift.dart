import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';

@DataClassName("EsocialRubrica")
class EsocialRubricas extends Table {
	@override
	String get tableName => 'esocial_rubrica';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EsocialRubricaGrouped {
	EsocialRubrica? esocialRubrica; 

  EsocialRubricaGrouped({
		this.esocialRubrica, 

  });
}
