import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("PlanoCentroResultado")
class PlanoCentroResultados extends Table {
	@override
	String get tableName => 'plano_centro_resultado';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	TextColumn get mascara => text().named('mascara').withLength(min: 0, max: 50).nullable()();
	IntColumn get niveis => integer().named('niveis').nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PlanoCentroResultadoGrouped {
	PlanoCentroResultado? planoCentroResultado; 

  PlanoCentroResultadoGrouped({
		this.planoCentroResultado, 

  });
}
