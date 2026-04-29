import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

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
	List<PapelFuncaoGrouped>? papelFuncaoGroupedList; 

  FuncaoGrouped({
		this.funcao, 
		this.papelFuncaoGroupedList, 

  });
}
