import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("RateioCentroResultadoDet")
class RateioCentroResultadoDets extends Table {
	@override
	String get tableName => 'rateio_centro_resultado_det';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCentroResultadoDestino => integer().named('id_centro_resultado_destino').nullable()();
	IntColumn get idRateioCentroResulCab => integer().named('id_rateio_centro_resul_cab').nullable()();
	RealColumn get porcentoRateio => real().named('porcento_rateio').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class RateioCentroResultadoDetGrouped {
	RateioCentroResultadoDet? rateioCentroResultadoDet; 
	CentroResultado? centroResultado; 

  RateioCentroResultadoDetGrouped({
		this.rateioCentroResultadoDet, 
		this.centroResultado, 

  });
}
