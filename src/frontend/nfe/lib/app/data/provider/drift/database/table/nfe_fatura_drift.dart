import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeFatura")
class NfeFaturas extends Table {
	@override
	String get tableName => 'nfe_fatura';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();
	RealColumn get valorOriginal => real().named('valor_original').nullable()();
	RealColumn get valorDesconto => real().named('valor_desconto').nullable()();
	RealColumn get valorLiquido => real().named('valor_liquido').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeFaturaGrouped {
	NfeFatura? nfeFatura; 

  NfeFaturaGrouped({
		this.nfeFatura, 

  });
}
