import 'package:drift/drift.dart';
import 'package:compras/app/data/provider/drift/database/database.dart';

@DataClassName("TributIcmsCustomCab")
class TributIcmsCustomCabs extends Table {
	@override
	String get tableName => 'tribut_icms_custom_cab';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get descricao => text().named('descricao').withLength(min: 0, max: 100).nullable()();
	TextColumn get origemMercadoria => text().named('origem_mercadoria').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class TributIcmsCustomCabGrouped {
	TributIcmsCustomCab? tributIcmsCustomCab; 

  TributIcmsCustomCabGrouped({
		this.tributIcmsCustomCab, 

  });
}
