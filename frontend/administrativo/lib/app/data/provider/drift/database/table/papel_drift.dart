import 'package:drift/drift.dart';
import 'package:administrativo/app/data/provider/drift/database/database.dart';
import 'package:administrativo/app/data/provider/drift/database/database_imports.dart';

@DataClassName("Papel")
class Papels extends Table {
	@override
	String get tableName => 'papel';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PapelGrouped {
	Papel? papel; 
	List<PapelFuncaoGrouped>? papelFuncaoGroupedList; 

  PapelGrouped({
		this.papel, 
		this.papelFuncaoGroupedList, 

  });
}
