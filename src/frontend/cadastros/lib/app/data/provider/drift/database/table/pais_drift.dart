import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Pais")
class Paiss extends Table {
	@override
	String get tableName => 'pais';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nomePtbr => text().named('nome_ptbr').withLength(min: 0, max: 100).nullable()();
	TextColumn get nomeEn => text().named('nome_en').withLength(min: 0, max: 100).nullable()();
	IntColumn get codigo => integer().named('codigo').nullable()();
	TextColumn get sigla2 => text().named('sigla2').withLength(min: 0, max: 2).nullable()();
	TextColumn get sigla3 => text().named('sigla3').withLength(min: 0, max: 3).nullable()();
	IntColumn get codigoBacen => integer().named('codigo_bacen').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PaisGrouped {
	Pais? pais; 

  PaisGrouped({
		this.pais, 

  });
}
