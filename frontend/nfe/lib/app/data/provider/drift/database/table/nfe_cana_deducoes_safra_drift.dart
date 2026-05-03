import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeCanaDeducoesSafra")
class NfeCanaDeducoesSafras extends Table {
	@override
	String get tableName => 'nfe_cana_deducoes_safra';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCana => integer().named('id_nfe_cana').nullable()();
	TextColumn get decricao => text().named('decricao').withLength(min: 0, max: 60).nullable()();
	RealColumn get valorDeducao => real().named('valor_deducao').nullable()();
	RealColumn get valorFornecimento => real().named('valor_fornecimento').nullable()();
	RealColumn get valorTotalDeducao => real().named('valor_total_deducao').nullable()();
	RealColumn get valorLiquidoFornecimento => real().named('valor_liquido_fornecimento').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeCanaDeducoesSafraGrouped {
	NfeCanaDeducoesSafra? nfeCanaDeducoesSafra; 
	NfeCana? nfeCana; 

  NfeCanaDeducoesSafraGrouped({
		this.nfeCanaDeducoesSafra, 
		this.nfeCana, 

  });
}
