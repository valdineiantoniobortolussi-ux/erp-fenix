import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';

@DataClassName("EstoqueMarca")
class EstoqueMarcas extends Table {
	@override
	String get tableName => 'estoque_marca';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EstoqueMarcaGrouped {
	EstoqueMarca? estoqueMarca; 

  EstoqueMarcaGrouped({
		this.estoqueMarca, 

  });
}
