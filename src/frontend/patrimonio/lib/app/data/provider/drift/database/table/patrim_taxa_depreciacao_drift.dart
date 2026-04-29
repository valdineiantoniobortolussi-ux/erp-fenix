import 'package:drift/drift.dart';
import 'package:patrimonio/app/data/provider/drift/database/database.dart';

@DataClassName("PatrimTaxaDepreciacao")
class PatrimTaxaDepreciacaos extends Table {
	@override
	String get tableName => 'patrim_taxa_depreciacao';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get ncm => text().named('ncm').withLength(min: 0, max: 8).nullable()();
	TextColumn get bem => text().named('bem').withLength(min: 0, max: 250).nullable()();
	RealColumn get vida => real().named('vida').nullable()();
	RealColumn get taxa => real().named('taxa').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class PatrimTaxaDepreciacaoGrouped {
	PatrimTaxaDepreciacao? patrimTaxaDepreciacao; 

  PatrimTaxaDepreciacaoGrouped({
		this.patrimTaxaDepreciacao, 

  });
}
