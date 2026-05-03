import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilContaRateio")
class ContabilContaRateios extends Table {
	@override
	String get tableName => 'contabil_conta_rateio';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCentroResultado => integer().named('id_centro_resultado').nullable()();
	IntColumn get idContabilConta => integer().named('id_contabil_conta').nullable()();
	RealColumn get porcentoRateio => real().named('porcento_rateio').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilContaRateioGrouped {
	ContabilContaRateio? contabilContaRateio; 
	ContabilConta? contabilConta; 
	CentroResultado? centroResultado; 

  ContabilContaRateioGrouped({
		this.contabilContaRateio, 
		this.contabilConta, 
		this.centroResultado, 

  });
}
