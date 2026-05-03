import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';
import 'package:folha/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FolhaInss")
class FolhaInsss extends Table {
	@override
	String get tableName => 'folha_inss';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaInssGrouped {
	FolhaInss? folhaInss; 
	List<FolhaInssRetencaoGrouped>? folhaInssRetencaoGroupedList; 

  FolhaInssGrouped({
		this.folhaInss, 
		this.folhaInssRetencaoGroupedList, 

  });
}
