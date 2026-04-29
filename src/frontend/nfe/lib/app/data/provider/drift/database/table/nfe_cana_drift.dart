import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeCana")
class NfeCanas extends Table {
	@override
	String get tableName => 'nfe_cana';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get safra => text().named('safra').withLength(min: 0, max: 9).nullable()();
	TextColumn get mesAnoReferencia => text().named('mes_ano_referencia').withLength(min: 0, max: 7).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeCanaGrouped {
	NfeCana? nfeCana; 

  NfeCanaGrouped({
		this.nfeCana, 

  });
}
