import 'package:drift/drift.dart';
import 'package:cadastros/app/data/provider/drift/database/database.dart';
import 'package:cadastros/app/data/provider/drift/database/database_imports.dart';

@DataClassName("Papel")
class Papels extends Table {
	@override
	String get tableName => 'papel';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get descrica => text().named('descrica').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PapelGrouped {
	Papel? papel; 
	List<PapelFuncaoGrouped>? papelFuncaoGroupedList; 
	List<UsuarioGrouped>? usuarioGroupedList; 

  PapelGrouped({
		this.papel, 
		this.papelFuncaoGroupedList, 
		this.usuarioGroupedList, 

  });
}
