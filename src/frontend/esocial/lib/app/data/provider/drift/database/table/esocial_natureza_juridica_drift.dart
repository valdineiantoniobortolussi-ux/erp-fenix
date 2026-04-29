import 'package:drift/drift.dart';
import 'package:esocial/app/data/provider/drift/database/database.dart';

@DataClassName("EsocialNaturezaJuridica")
class EsocialNaturezaJuridicas extends Table {
	@override
	String get tableName => 'esocial_natureza_juridica';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get grupo => integer().named('grupo').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 5).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EsocialNaturezaJuridicaGrouped {
	EsocialNaturezaJuridica? esocialNaturezaJuridica; 

  EsocialNaturezaJuridicaGrouped({
		this.esocialNaturezaJuridica, 

  });
}
