import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteDuplicata")
class CteDuplicatas extends Table {
	@override
	String get tableName => 'cte_duplicata';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();
	DateTimeColumn get dataVencimento => dateTime().named('data_vencimento').nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteDuplicataGrouped {
	CteDuplicata? cteDuplicata; 

  CteDuplicataGrouped({
		this.cteDuplicata, 

  });
}
