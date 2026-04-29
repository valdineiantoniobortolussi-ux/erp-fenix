import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("LancaCentroResultado")
class LancaCentroResultados extends Table {
	@override
	String get tableName => 'lanca_centro_resultado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCentroResultado => integer().named('id_centro_resultado').nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	DateTimeColumn get dataLancamento => dateTime().named('data_lancamento').nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();
	TextColumn get origemDeRateio => text().named('origem_de_rateio').withLength(min: 0, max: 1).nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class LancaCentroResultadoGrouped {
	LancaCentroResultado? lancaCentroResultado; 
	CentroResultado? centroResultado; 

  LancaCentroResultadoGrouped({
		this.lancaCentroResultado, 
		this.centroResultado, 

  });
}
