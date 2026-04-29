import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsRua")
class WmsRuas extends Table {
	@override
	String get tableName => 'wms_rua';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 10).nullable()();
	IntColumn get quantidadeEstante => integer().named('quantidade_estante').nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsRuaGrouped {
	WmsRua? wmsRua; 

  WmsRuaGrouped({
		this.wmsRua, 

  });
}
