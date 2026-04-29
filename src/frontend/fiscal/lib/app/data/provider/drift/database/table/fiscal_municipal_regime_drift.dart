import 'package:drift/drift.dart';
import 'package:fiscal/app/data/provider/drift/database/database.dart';

@DataClassName("FiscalMunicipalRegime")
class FiscalMunicipalRegimes extends Table {
	@override
	String get tableName => 'fiscal_municipal_regime';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 20).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 50).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class FiscalMunicipalRegimeGrouped {
	FiscalMunicipalRegime? fiscalMunicipalRegime; 

  FiscalMunicipalRegimeGrouped({
		this.fiscalMunicipalRegime, 

  });
}
