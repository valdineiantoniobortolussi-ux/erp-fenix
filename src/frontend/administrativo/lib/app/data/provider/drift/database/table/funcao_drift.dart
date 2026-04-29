import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';

@DataClassName("Funcao")
class Funcaos extends Table {
	@override
	String get tableName => 'funcao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FuncaoGrouped {
	Funcao? funcao; 

  FuncaoGrouped({
		this.funcao, 

  });
}
