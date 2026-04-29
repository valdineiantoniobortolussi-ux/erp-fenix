import 'package:drift/drift.dart';
import 'package:contratos/app/data/provider/drift/database/database.dart';

@DataClassName("ContratoHistFaturamento")
class ContratoHistFaturamentos extends Table {
	@override
	String get tableName => 'contrato_hist_faturamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContrato => integer().named('id_contrato').nullable()();
	DateTimeColumn get dataFatura => dateTime().named('data_fatura').nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContratoHistFaturamentoGrouped {
	ContratoHistFaturamento? contratoHistFaturamento; 

  ContratoHistFaturamentoGrouped({
		this.contratoHistFaturamento, 

  });
}
