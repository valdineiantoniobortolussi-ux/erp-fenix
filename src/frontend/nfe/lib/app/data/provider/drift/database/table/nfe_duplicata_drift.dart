import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeDuplicata")
class NfeDuplicatas extends Table {
	@override
	String get tableName => 'nfe_duplicata';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeFatura => integer().named('id_nfe_fatura').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 60).nullable()();
	DateTimeColumn get dataVencimento => dateTime().named('data_vencimento').nullable()();
	RealColumn get valor => real().named('valor').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeDuplicataGrouped {
	NfeDuplicata? nfeDuplicata; 
	NfeFatura? nfeFatura; 

  NfeDuplicataGrouped({
		this.nfeDuplicata, 
		this.nfeFatura, 

  });
}
