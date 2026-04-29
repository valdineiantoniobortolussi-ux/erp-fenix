import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';

@DataClassName("OrcamentoPeriodo")
class OrcamentoPeriodos extends Table {
	@override
	String get tableName => 'orcamento_periodo';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get periodo => text().named('periodo').withLength(min: 0, max: 1).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 30).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OrcamentoPeriodoGrouped {
	OrcamentoPeriodo? orcamentoPeriodo; 

  OrcamentoPeriodoGrouped({
		this.orcamentoPeriodo, 

  });
}
