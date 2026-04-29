import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeCanaFornecimentoDiario")
class NfeCanaFornecimentoDiarios extends Table {
	@override
	String get tableName => 'nfe_cana_fornecimento_diario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCana => integer().named('id_nfe_cana').nullable()();
	TextColumn get dia => text().named('dia').withLength(min: 0, max: 2).nullable()();
	RealColumn get quantidade => real().named('quantidade').nullable()();
	RealColumn get quantidadeTotalMes => real().named('quantidade_total_mes').nullable()();
	RealColumn get quantidadeTotalAnterior => real().named('quantidade_total_anterior').nullable()();
	RealColumn get quantidadeTotalGeral => real().named('quantidade_total_geral').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeCanaFornecimentoDiarioGrouped {
	NfeCanaFornecimentoDiario? nfeCanaFornecimentoDiario; 
	NfeCana? nfeCana; 

  NfeCanaFornecimentoDiarioGrouped({
		this.nfeCanaFornecimentoDiario, 
		this.nfeCana, 

  });
}
