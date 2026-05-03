import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("EstadoCivil")
class EstadoCivils extends Table {
	@override
	String get tableName => 'estado_civil';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EstadoCivilGrouped {
	EstadoCivil? estadoCivil; 

  EstadoCivilGrouped({
		this.estadoCivil, 

  });
}
