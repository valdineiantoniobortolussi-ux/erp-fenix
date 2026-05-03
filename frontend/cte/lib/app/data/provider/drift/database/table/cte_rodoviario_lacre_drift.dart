import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteRodoviarioLacre")
class CteRodoviarioLacres extends Table {
	@override
	String get tableName => 'cte_rodoviario_lacre';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteRodoviario => integer().named('id_cte_rodoviario').nullable()();
	TextColumn get numero => text().named('numero').withLength(min: 0, max: 20).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteRodoviarioLacreGrouped {
	CteRodoviarioLacre? cteRodoviarioLacre; 
	CteRodoviario? cteRodoviario; 

  CteRodoviarioLacreGrouped({
		this.cteRodoviarioLacre, 
		this.cteRodoviario, 

  });
}
