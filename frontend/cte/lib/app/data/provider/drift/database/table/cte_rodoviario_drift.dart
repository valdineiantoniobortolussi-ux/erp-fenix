import 'package:drift/drift.dart';
import 'package:cte/app/data/provider/drift/database/database.dart';

@DataClassName("CteRodoviario")
class CteRodoviarios extends Table {
	@override
	String get tableName => 'cte_rodoviario';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idCteCabecalho => integer().named('id_cte_cabecalho').nullable()();
	TextColumn get rntrc => text().named('rntrc').withLength(min: 0, max: 8).nullable()();
	DateTimeColumn get dataPrevistaEntrega => dateTime().named('data_prevista_entrega').nullable()();
	TextColumn get indicadorLotacao => text().named('indicador_lotacao').withLength(min: 0, max: 1).nullable()();
	IntColumn get ciot => integer().named('ciot').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class CteRodoviarioGrouped {
	CteRodoviario? cteRodoviario; 

  CteRodoviarioGrouped({
		this.cteRodoviario, 

  });
}
