import 'package:drift/drift.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';

@DataClassName("InventarioAjusteDet")
class InventarioAjusteDets extends Table {
	@override
	String get tableName => 'inventario_ajuste_det';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idInventarioAjusteCab => integer().named('id_inventario_ajuste_cab').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get valorOriginal => real().named('valor_original').nullable()();
	RealColumn get valorReajuste => real().named('valor_reajuste').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class InventarioAjusteDetGrouped {
	InventarioAjusteDet? inventarioAjusteDet; 
	Produto? produto; 

  InventarioAjusteDetGrouped({
		this.inventarioAjusteDet, 
		this.produto, 

  });
}
