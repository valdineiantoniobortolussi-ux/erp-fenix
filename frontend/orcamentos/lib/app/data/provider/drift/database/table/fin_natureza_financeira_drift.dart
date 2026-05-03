import 'package:drift/drift.dart';
import 'package:orcamentos/app/data/provider/drift/database/database.dart';

@DataClassName("FinNaturezaFinanceira")
class FinNaturezaFinanceiras extends Table {
	@override
	String get tableName => 'fin_natureza_financeira';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 4).nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get aplicacao => text().named('aplicacao').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FinNaturezaFinanceiraGrouped {
	FinNaturezaFinanceira? finNaturezaFinanceira; 

  FinNaturezaFinanceiraGrouped({
		this.finNaturezaFinanceira, 

  });
}
