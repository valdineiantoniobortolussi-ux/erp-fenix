import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeNfReferenciada")
class NfeNfReferenciadas extends Table {
	@override
	String get tableName => 'nfe_nf_referenciada';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	IntColumn get codigoUf => integer().named('codigo_uf').nullable()();
	TextColumn get anoMes => text().named('ano_mes').withLength(min: 0, max: 4).nullable()();
	TextColumn get cnpj => text().named('cnpj').withLength(min: 0, max: 14).nullable()();
	TextColumn get modelo => text().named('modelo').withLength(min: 0, max: 2).nullable()();
	TextColumn get serie => text().named('serie').withLength(min: 0, max: 3).nullable()();
	IntColumn get numeroNf => integer().named('numero_nf').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeNfReferenciadaGrouped {
	NfeNfReferenciada? nfeNfReferenciada; 

  NfeNfReferenciadaGrouped({
		this.nfeNfReferenciada, 

  });
}
