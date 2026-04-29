import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilLancamentoPadrao")
class ContabilLancamentoPadraos extends Table {
	@override
	String get tableName => 'contabil_lancamento_padrao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 250).nullable()();
	IntColumn get idContaDebito => integer().named('id_conta_debito').nullable()();
	IntColumn get idContaCredito => integer().named('id_conta_credito').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilLancamentoPadraoGrouped {
	ContabilLancamentoPadrao? contabilLancamentoPadrao; 

  ContabilLancamentoPadraoGrouped({
		this.contabilLancamentoPadrao, 

  });
}
