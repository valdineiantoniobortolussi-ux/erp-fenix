import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("PlanoConta")
class PlanoContas extends Table {
	@override
	String get tableName => 'plano_conta';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();
	TextColumn get mascara => text().named('mascara').withLength(min: 0, max: 50).nullable()();
	IntColumn get niveis => integer().named('niveis').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PlanoContaGrouped {
	PlanoConta? planoConta; 

  PlanoContaGrouped({
		this.planoConta, 

  });
}
