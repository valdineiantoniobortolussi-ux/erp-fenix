import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilHistorico")
class ContabilHistoricos extends Table {
	@override
	String get tableName => 'contabil_historico';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get pedeComplemento => text().named('pede_complemento').withLength(min: 0, max: 1).nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilHistoricoGrouped {
	ContabilHistorico? contabilHistorico; 

  ContabilHistoricoGrouped({
		this.contabilHistorico, 

  });
}
