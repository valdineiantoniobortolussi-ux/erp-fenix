import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("CentroResultado")
class CentroResultados extends Table {
	@override
	String get tableName => 'centro_resultado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idPlanoCentroResultado => integer().named('id_plano_centro_resultado').nullable()();
	TextColumn get classificacao => text().named('classificacao').withLength(min: 0, max: 30).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get sofreRateiro => text().named('sofre_rateiro').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CentroResultadoGrouped {
	CentroResultado? centroResultado; 

  CentroResultadoGrouped({
		this.centroResultado, 

  });
}
