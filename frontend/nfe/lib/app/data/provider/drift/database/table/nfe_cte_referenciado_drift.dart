import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeCteReferenciado")
class NfeCteReferenciados extends Table {
	@override
	String get tableName => 'nfe_cte_referenciado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get chaveAcesso => text().named('chave_acesso').withLength(min: 0, max: 44).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeCteReferenciadoGrouped {
	NfeCteReferenciado? nfeCteReferenciado; 

  NfeCteReferenciadoGrouped({
		this.nfeCteReferenciado, 

  });
}
