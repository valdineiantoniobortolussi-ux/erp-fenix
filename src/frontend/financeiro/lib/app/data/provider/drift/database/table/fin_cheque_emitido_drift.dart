import 'package:drift/drift.dart';
import 'package:financeiro/app/data/provider/drift/database/database.dart';

@DataClassName("FinChequeEmitido")
class FinChequeEmitidos extends Table {
	@override
	String get tableName => 'fin_cheque_emitido';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCheque => integer().named('id_cheque').nullable()();
	DateTimeColumn get dataEmissao => dateTime().named('data_emissao').nullable()();
	DateTimeColumn get bomPara => dateTime().named('bom_para').nullable()();
	DateTimeColumn get dataCompensacao => dateTime().named('data_compensacao').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get nominalA => text().named('nominal_a').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinChequeEmitidoGrouped {
	FinChequeEmitido? finChequeEmitido; 
	Cheque? cheque; 

  FinChequeEmitidoGrouped({
		this.finChequeEmitido, 
		this.cheque, 

  });
}
