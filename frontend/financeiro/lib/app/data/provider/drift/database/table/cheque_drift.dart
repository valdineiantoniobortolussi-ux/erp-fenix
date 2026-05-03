import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("Cheque")
class Cheques extends Table {
	@override
	String get tableName => 'cheque';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idTalonarioCheque => integer().named('id_talonario_cheque').nullable()();
	IntColumn get numero => integer().named('numero').nullable()();
	TextColumn get statusCheque => text().named('status_cheque').withLength(min: 0, max: 1).nullable()();
	DateTimeColumn get dataStatus => dateTime().named('data_status').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ChequeGrouped {
	Cheque? cheque; 

  ChequeGrouped({
		this.cheque, 

  });
}
