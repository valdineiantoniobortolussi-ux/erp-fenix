import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("CtResultadoNtFinanceira")
class CtResultadoNtFinanceiras extends Table {
	@override
	String get tableName => 'ct_resultado_nt_financeira';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCentroResultado => integer().named('id_centro_resultado').nullable()();
	IntColumn get idFinNaturezaFinanceira => integer().named('id_fin_natureza_financeira').nullable()();
	RealColumn get percentualRateio => real().named('percentual_rateio').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CtResultadoNtFinanceiraGrouped {
	CtResultadoNtFinanceira? ctResultadoNtFinanceira; 
	FinNaturezaFinanceira? finNaturezaFinanceira; 

  CtResultadoNtFinanceiraGrouped({
		this.ctResultadoNtFinanceira, 
		this.finNaturezaFinanceira, 

  });
}
