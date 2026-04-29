import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsEstante")
class WmsEstantes extends Table {
	@override
	String get tableName => 'wms_estante';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idWmsRua => integer().named('id_wms_rua').nullable()();
	TextColumn get codigo => text().named('codigo').withLength(min: 0, max: 10).nullable()();
	IntColumn get quantidadeCaixa => integer().named('quantidade_caixa').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsEstanteGrouped {
	WmsEstante? wmsEstante; 
	WmsRua? wmsRua; 

  WmsEstanteGrouped({
		this.wmsEstante, 
		this.wmsRua, 

  });
}
