import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("Setor")
class Setors extends Table {
	@override
	String get tableName => 'setor';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class SetorGrouped {
	Setor? setor; 

  SetorGrouped({
		this.setor, 

  });
}
