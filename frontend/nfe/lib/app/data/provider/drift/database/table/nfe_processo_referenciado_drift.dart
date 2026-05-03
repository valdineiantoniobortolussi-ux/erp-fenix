import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeProcessoReferenciado")
class NfeProcessoReferenciados extends Table {
	@override
	String get tableName => 'nfe_processo_referenciado';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeCabecalho => integer().named('id_nfe_cabecalho').nullable()();
	TextColumn get identificador => text().named('identificador').withLength(min: 0, max: 60).nullable()();
	TextColumn get origem => text().named('origem').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeProcessoReferenciadoGrouped {
	NfeProcessoReferenciado? nfeProcessoReferenciado; 

  NfeProcessoReferenciadoGrouped({
		this.nfeProcessoReferenciado, 

  });
}
