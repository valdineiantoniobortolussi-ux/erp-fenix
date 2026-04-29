import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("Fap")
class Faps extends Table {
	@override
	String get tableName => 'fap';

	IntColumn get id => integer().named('id').nullable()();
	RealColumn get fap => real().named('fap').nullable()();
	DateTimeColumn get dataInicial => dateTime().named('data_inicial').nullable()();
	DateTimeColumn get dataFinal => dateTime().named('data_final').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FapGrouped {
	Fap? fap; 

  FapGrouped({
		this.fap, 

  });
}
