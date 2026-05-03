import 'package:drift/drift.dart';
import 'package:mdfe/app/data/provider/drift/database/database.dart';

@DataClassName("MdfeLacre")
class MdfeLacres extends Table {
	@override
	String get tableName => 'mdfe_lacre';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idMdfeCabecalho => integer().named('id_mdfe_cabecalho').nullable()();
	TextColumn get numeroLacre => text().named('numero_lacre').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class MdfeLacreGrouped {
	MdfeLacre? mdfeLacre; 

  MdfeLacreGrouped({
		this.mdfeLacre, 

  });
}
