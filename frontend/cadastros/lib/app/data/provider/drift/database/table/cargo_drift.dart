import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';

@DataClassName("Cargo")
class Cargos extends Table {
	@override
	String get tableName => 'cargo';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();
	RealColumn get salario => real().named('salario').nullable()();
	TextColumn get cbo1994 => text().named('cbo_1994').withLength(min: 0, max: 10).nullable()();
	TextColumn get cbo2002 => text().named('cbo_2002').withLength(min: 0, max: 10).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CargoGrouped {
	Cargo? cargo; 

  CargoGrouped({
		this.cargo, 

  });
}
