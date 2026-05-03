import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteAquaviario")
class CteAquaviarios extends Table {
	@override
	String get tableName => 'cte_aquaviario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	RealColumn get valorPrestacao => real().named('valor_prestacao').nullable()();
	RealColumn get afrmm => real().named('afrmm').nullable()();
	TextColumn get numeroBooking => text().named('numero_booking').withLength(min: 0, max: 10).nullable()();
	TextColumn get numeroControle => text().named('numero_controle').withLength(min: 0, max: 10).nullable()();
	TextColumn get idNavio => text().named('id_navio').withLength(min: 0, max: 60).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteAquaviarioGrouped {
	CteAquaviario? cteAquaviario; 

  CteAquaviarioGrouped({
		this.cteAquaviario, 

  });
}
