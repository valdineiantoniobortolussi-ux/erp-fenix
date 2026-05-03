import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilLancamentoDetalhe")
class ContabilLancamentoDetalhes extends Table {
	@override
	String get tableName => 'contabil_lancamento_detalhe';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContabilLancamentoCab => integer().named('id_contabil_lancamento_cab').nullable()();
	IntColumn get idContabilConta => integer().named('id_contabil_conta').nullable()();
	IntColumn get idContabilHistorico => integer().named('id_contabil_historico').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	RealColumn get valor => real().named('valor').nullable()();
	TextColumn get historico => text().named('historico').withLength(min: 0, max: 250).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilLancamentoDetalheGrouped {
	ContabilLancamentoDetalhe? contabilLancamentoDetalhe; 
	ContabilHistorico? contabilHistorico; 
	ContabilConta? contabilConta; 

  ContabilLancamentoDetalheGrouped({
		this.contabilLancamentoDetalhe, 
		this.contabilHistorico, 
		this.contabilConta, 

  });
}
