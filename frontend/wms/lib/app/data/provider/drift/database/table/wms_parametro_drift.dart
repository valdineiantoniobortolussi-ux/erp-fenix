import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsParametro")
class WmsParametros extends Table {
	@override
	String get tableName => 'wms_parametro';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get horaPorVolume => integer().named('hora_por_volume').nullable()();
	IntColumn get pessoaPorVolume => integer().named('pessoa_por_volume').nullable()();
	IntColumn get horaPorPeso => integer().named('hora_por_peso').nullable()();
	IntColumn get pessoaPorPeso => integer().named('pessoa_por_peso').nullable()();
	TextColumn get itemDiferenteCaixa => text().named('item_diferente_caixa').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsParametroGrouped {
	WmsParametro? wmsParametro; 

  WmsParametroGrouped({
		this.wmsParametro, 

  });
}
