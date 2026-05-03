import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeNumero")
class NfeNumeros extends Table {
	@override
	String get tableName => 'nfe_numero';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	IntColumn get numero => integer().named('numero').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeNumeroGrouped {
	NfeNumero? nfeNumero; 

  NfeNumeroGrouped({
		this.nfeNumero, 

  });
}
