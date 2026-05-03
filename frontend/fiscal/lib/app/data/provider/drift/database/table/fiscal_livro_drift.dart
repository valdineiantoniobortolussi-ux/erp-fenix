import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';
import 'package:fiscal/app/data/provider/drift/database/database_imports.dart';

@DataClassName("FiscalLivro")
class FiscalLivros extends Table {
	@override
	String get tableName => 'fiscal_livro';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalLivroGrouped {
	FiscalLivro? fiscalLivro; 
	List<FiscalTermoGrouped>? fiscalTermoGroupedList; 

  FiscalLivroGrouped({
		this.fiscalLivro, 
		this.fiscalTermoGroupedList, 

  });
}
