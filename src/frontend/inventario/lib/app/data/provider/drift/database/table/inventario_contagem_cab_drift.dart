import 'package:drift/drift.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';
import 'package:inventario/app/data/provider/drift/database/database_imports.dart';

@DataClassName("InventarioContagemCab")
class InventarioContagemCabs extends Table {
	@override
	String get tableName => 'inventario_contagem_cab';

	IntColumn get id => integer().named('id').nullable()();
	DateTimeColumn get dataContagem => dateTime().named('data_contagem').nullable()();
	TextColumn get estoqueAtualizado => text().named('estoque_atualizado').withLength(min: 0, max: 1).nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class InventarioContagemCabGrouped {
	InventarioContagemCab? inventarioContagemCab; 
	List<InventarioContagemDetGrouped>? inventarioContagemDetGroupedList; 

  InventarioContagemCabGrouped({
		this.inventarioContagemCab, 
		this.inventarioContagemDetGroupedList, 

  });
}
