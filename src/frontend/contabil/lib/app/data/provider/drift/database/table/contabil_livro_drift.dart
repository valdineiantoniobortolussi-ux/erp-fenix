import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ContabilLivro")
class ContabilLivros extends Table {
	@override
	String get tableName => 'contabil_livro';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	TextColumn get formaEscrituracao => text().named('forma_escrituracao').withLength(min: 0, max: 1).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilLivroGrouped {
	ContabilLivro? contabilLivro; 
	List<ContabilTermoGrouped>? contabilTermoGroupedList; 

  ContabilLivroGrouped({
		this.contabilLivro, 
		this.contabilTermoGroupedList, 

  });
}
