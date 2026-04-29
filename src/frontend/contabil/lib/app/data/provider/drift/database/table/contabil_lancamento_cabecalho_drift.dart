import 'package:drift/drift.dart';
import 'package:contabil/app/data/provider/drift/database/database.dart';
import 'package:contabil/app/data/provider/drift/database/database_imports.dart';

@DataClassName("ContabilLancamentoCabecalho")
class ContabilLancamentoCabecalhos extends Table {
	@override
	String get tableName => 'contabil_lancamento_cabecalho';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idContabilLote => integer().named('id_contabil_lote').nullable()();
	DateTimeColumn get dataLancamento => dateTime().named('data_lancamento').nullable()();
	DateTimeColumn get dataInclusao => dateTime().named('data_inclusao').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	TextColumn get liberado => text().named('liberado').withLength(min: 0, max: 1).nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class ContabilLancamentoCabecalhoGrouped {
	ContabilLancamentoCabecalho? contabilLancamentoCabecalho; 
	List<ContabilLancamentoDetalheGrouped>? contabilLancamentoDetalheGroupedList; 
	ContabilLote? contabilLote; 

  ContabilLancamentoCabecalhoGrouped({
		this.contabilLancamentoCabecalho, 
		this.contabilLancamentoDetalheGroupedList, 
		this.contabilLote, 

  });
}
