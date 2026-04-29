import 'package:drift/drift.dart';
import 'package:folha/app/data/provider/drift/database/database.dart';

@DataClassName("FolhaPppCat")
class FolhaPppCats extends Table {
	@override
	String get tableName => 'folha_ppp_cat';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idFolhaPpp => integer().named('id_folha_ppp').nullable()();
	IntColumn get numeroCat => integer().named('numero_cat').nullable()();
	DateTimeColumn get dataAfastamento => dateTime().named('data_afastamento').nullable()();
	DateTimeColumn get dataRegistro => dateTime().named('data_registro').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FolhaPppCatGrouped {
	FolhaPppCat? folhaPppCat; 

  FolhaPppCatGrouped({
		this.folhaPppCat, 

  });
}
