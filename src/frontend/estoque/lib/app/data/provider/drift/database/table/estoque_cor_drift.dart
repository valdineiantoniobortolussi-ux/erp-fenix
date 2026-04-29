import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';

@DataClassName("EstoqueCor")
class EstoqueCors extends Table {
	@override
	String get tableName => 'estoque_cor';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EstoqueCorGrouped {
	EstoqueCor? estoqueCor; 

  EstoqueCorGrouped({
		this.estoqueCor, 

  });
}
