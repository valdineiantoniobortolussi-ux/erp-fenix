import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsExpedicao")
class WmsExpedicaos extends Table {
	@override
	String get tableName => 'wms_expedicao';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idWmsOrdemSeparacaoDet => integer().named('id_wms_ordem_separacao_det').nullable()();
	IntColumn get idWmsArmazenamento => integer().named('id_wms_armazenamento').nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();
	DateTimeColumn get dataSaida => dateTime().named('data_saida').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsExpedicaoGrouped {
	WmsExpedicao? wmsExpedicao; 
	WmsOrdemSeparacaoDet? wmsOrdemSeparacaoDet; 
	WmsArmazenamento? wmsArmazenamento; 

  WmsExpedicaoGrouped({
		this.wmsExpedicao, 
		this.wmsOrdemSeparacaoDet, 
		this.wmsArmazenamento, 

  });
}
