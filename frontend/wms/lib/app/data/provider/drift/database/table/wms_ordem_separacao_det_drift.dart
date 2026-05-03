import 'package:drift/drift.dart';
import 'package:wms/app/data/provider/drift/database/database.dart';

@DataClassName("WmsOrdemSeparacaoDet")
class WmsOrdemSeparacaoDets extends Table {
	@override
	String get tableName => 'wms_ordem_separacao_det';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idWmsOrdemSeparacaoCab => integer().named('id_wms_ordem_separacao_cab').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	IntColumn get quantidade => integer().named('quantidade').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class WmsOrdemSeparacaoDetGrouped {
	WmsOrdemSeparacaoDet? wmsOrdemSeparacaoDet; 
	Produto? produto; 

  WmsOrdemSeparacaoDetGrouped({
		this.wmsOrdemSeparacaoDet, 
		this.produto, 

  });
}
