import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("EncerraCentroResultado")
class EncerraCentroResultados extends Table {
	@override
	String get tableName => 'encerra_centro_resultado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCentroResultado => integer().named('id_centro_resultado').nullable()();
	TextColumn get competencia => text().named('competencia').withLength(min: 0, max: 7).nullable()();
	RealColumn get valorTotal => real().named('valor_total').nullable()();
	RealColumn get valorSubRateio => real().named('valor_sub_rateio').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class EncerraCentroResultadoGrouped {
	EncerraCentroResultado? encerraCentroResultado; 
	CentroResultado? centroResultado; 

  EncerraCentroResultadoGrouped({
		this.encerraCentroResultado, 
		this.centroResultado, 

  });
}
