import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

@DataClassName("RateioCentroResultadoCab")
class RateioCentroResultadoCabs extends Table {
	@override
	String get tableName => 'rateio_centro_resultado_cab';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCentroResultado => integer().named('id_centro_resultado').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class RateioCentroResultadoCabGrouped {
	RateioCentroResultadoCab? rateioCentroResultadoCab; 
	List<RateioCentroResultadoDetGrouped>? rateioCentroResultadoDetGroupedList; 
	CentroResultado? centroResultado; 

  RateioCentroResultadoCabGrouped({
		this.rateioCentroResultadoCab, 
		this.rateioCentroResultadoDetGroupedList, 
		this.centroResultado, 

  });
}
