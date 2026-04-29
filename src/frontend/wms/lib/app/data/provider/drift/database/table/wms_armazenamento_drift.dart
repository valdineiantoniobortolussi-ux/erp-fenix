import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsArmazenamento")
class WmsArmazenamentos extends Table {
	@override
	String get tableName => 'wms_armazenamento';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idWmsCaixa => integer().named('id_wms_caixa').nullable()();
	IntColumn get idWmsRecebimentoDetalhe => integer().named('id_wms_recebimento_detalhe').nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsArmazenamentoGrouped {
	WmsArmazenamento? wmsArmazenamento; 
	WmsRecebimentoDetalhe? wmsRecebimentoDetalhe; 

  WmsArmazenamentoGrouped({
		this.wmsArmazenamento, 
		this.wmsRecebimentoDetalhe, 

  });
}
