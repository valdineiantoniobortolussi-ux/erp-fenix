import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';

@DataClassName("ContabilLancamentoOrcado")
class ContabilLancamentoOrcados extends Table {
	@override
	String get tableName => 'contabil_lancamento_orcado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContabilConta => integer().named('id_contabil_conta').nullable()();
	TextColumn get ano => text().named('ano').withLength(min: 0, max: 4).nullable()();
	RealColumn get janeiro => real().named('janeiro').nullable()();
	RealColumn get fevereiro => real().named('fevereiro').nullable()();
	RealColumn get marco => real().named('marco').nullable()();
	RealColumn get abril => real().named('abril').nullable()();
	RealColumn get maio => real().named('maio').nullable()();
	RealColumn get junho => real().named('junho').nullable()();
	RealColumn get julho => real().named('julho').nullable()();
	RealColumn get agosto => real().named('agosto').nullable()();
	RealColumn get setembro => real().named('setembro').nullable()();
	RealColumn get outubro => real().named('outubro').nullable()();
	RealColumn get novembro => real().named('novembro').nullable()();
	RealColumn get dezembro => real().named('dezembro').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilLancamentoOrcadoGrouped {
	ContabilLancamentoOrcado? contabilLancamentoOrcado; 
	ContabilConta? contabilConta; 

  ContabilLancamentoOrcadoGrouped({
		this.contabilLancamentoOrcado, 
		this.contabilConta, 

  });
}
