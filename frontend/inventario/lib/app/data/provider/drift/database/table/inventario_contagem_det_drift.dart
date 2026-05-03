import 'package:drift/drift.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';

@DataClassName("InventarioContagemDet")
class InventarioContagemDets extends Table {
	@override
	String get tableName => 'inventario_contagem_det';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idInventarioContagemCab => integer().named('id_inventario_contagem_cab').nullable()();
	IntColumn get idProduto => integer().named('id_produto').nullable()();
	RealColumn get contagem01 => real().named('contagem01').nullable()();
	RealColumn get contagem02 => real().named('contagem02').nullable()();
	RealColumn get contagem03 => real().named('contagem03').nullable()();
	TextColumn get fechadoContagem => text().named('fechado_contagem').withLength(min: 0, max: 2).nullable()();
	RealColumn get quantidadeSistema => real().named('quantidade_sistema').nullable()();
	RealColumn get acuracidade => real().named('acuracidade').nullable()();
	RealColumn get divergencia => real().named('divergencia').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class InventarioContagemDetGrouped {
	InventarioContagemDet? inventarioContagemDet; 
	Produto? produto; 

  InventarioContagemDetGrouped({
		this.inventarioContagemDet, 
		this.produto, 

  });
}
