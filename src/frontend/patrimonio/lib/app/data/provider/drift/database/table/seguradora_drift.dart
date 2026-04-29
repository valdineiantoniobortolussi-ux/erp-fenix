import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("Seguradora")
class Seguradoras extends Table {
	@override
	String get tableName => 'seguradora';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get contato => text().named('contato').withLength(min: 0, max: 50).nullable()();
	TextColumn get telefone => text().named('telefone').withLength(min: 0, max: 14).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class SeguradoraGrouped {
	Seguradora? seguradora; 

  SeguradoraGrouped({
		this.seguradora, 

  });
}
