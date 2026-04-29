import 'package:drift/drift.dart';
import 'package:nfe/app/data/provider/drift/database/database.dart';

@DataClassName("NfeTransporteReboque")
class NfeTransporteReboques extends Table {
	@override
	String get tableName => 'nfe_transporte_reboque';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idNfeTransporte => integer().named('id_nfe_transporte').nullable()();
	TextColumn get placa => text().named('placa').withLength(min: 0, max: 8).nullable()();
	TextColumn get uf => text().named('uf').withLength(min: 0, max: 2).nullable()();
	TextColumn get rntc => text().named('rntc').withLength(min: 0, max: 20).nullable()();
	TextColumn get vagao => text().named('vagao').withLength(min: 0, max: 20).nullable()();
	TextColumn get balsa => text().named('balsa').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class NfeTransporteReboqueGrouped {
	NfeTransporteReboque? nfeTransporteReboque; 
	NfeTransporte? nfeTransporte; 

  NfeTransporteReboqueGrouped({
		this.nfeTransporteReboque, 
		this.nfeTransporte, 

  });
}
