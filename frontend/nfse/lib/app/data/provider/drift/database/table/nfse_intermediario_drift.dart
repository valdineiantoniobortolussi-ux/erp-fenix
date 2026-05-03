import 'package:drift/drift.dart';
import 'package:nfse/app/data/provider/drift/database/database.dart';

@DataClassName("NfseIntermediario")
class NfseIntermediarios extends Table {
	@override
	String get tableName => 'nfse_intermediario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfseCabecalho => integer().named('id_nfse_cabecalho').nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get inscricaoMunicipal => text().named('inscricao_municipal').withLength(min: 0, max: 15).nullable()();
	TextColumn get razao => text().named('razao').withLength(min: 0, max: 150).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfseIntermediarioGrouped {
	NfseIntermediario? nfseIntermediario; 

  NfseIntermediarioGrouped({
		this.nfseIntermediario, 

  });
}
