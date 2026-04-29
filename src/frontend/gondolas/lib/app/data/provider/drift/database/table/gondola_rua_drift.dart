import 'package:drift/drift.dart';
import 'package:gondolas/app/data/provider/drift/database/database.dart';

@DataClassName("GondolaRua")
class GondolaRuas extends Table {
	@override
	String get tableName => 'gondola_rua';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 10).nullable()();
	IntColumn get quantidadeEstante => integer().named('quantidade_estante').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class GondolaRuaGrouped {
	GondolaRua? gondolaRua; 

  GondolaRuaGrouped({
		this.gondolaRua, 

  });
}
