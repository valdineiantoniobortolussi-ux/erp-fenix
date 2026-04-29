import 'package:drift/drift.dart';
import 'package:ordem_servico/app/data/provider/drift/database/database.dart';

@DataClassName("OsStatus")
class OsStatuss extends Table {
	@override
	String get tableName => 'os_status';

	IntColumn get id => integer().named('id').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 2).nullable()();
	TextColumn get nome => text().named('nome').withLength(min: 0, max: 100).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class OsStatusGrouped {
	OsStatus? osStatus; 

  OsStatusGrouped({
		this.osStatus, 

  });
}
