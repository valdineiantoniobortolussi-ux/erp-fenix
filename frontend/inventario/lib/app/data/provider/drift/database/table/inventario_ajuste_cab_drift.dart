import 'package:drift/drift.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';
import 'package:inventario/app/data/provider/drift/database/database_imports.dart';

@DataClassName("InventarioAjusteCab")
class InventarioAjusteCabs extends Table {
	@override
	String get tableName => 'inventario_ajuste_cab';

	IntColumn get id => integer().named('id').nullable()();
	IntColumn get idViewPessoaColaborador => integer().named('id_view_pessoa_colaborador').nullable()();
	DateTimeColumn get dataAjuste => dateTime().named('data_ajuste').nullable()();
	TextColumn get tipo => text().named('tipo').withLength(min: 0, max: 1).nullable()();
	RealColumn get taxa => real().named('taxa').nullable()();
	TextColumn get justificativa => text().named('justificativa').nullable()();

	@override
	Set<Column> get primaryKey => { id };	
	
}

class InventarioAjusteCabGrouped {
	InventarioAjusteCab? inventarioAjusteCab; 
	ViewPessoaColaborador? viewPessoaColaborador; 
	List<InventarioAjusteDetGrouped>? inventarioAjusteDetGroupedList; 

  InventarioAjusteCabGrouped({
		this.inventarioAjusteCab, 
		this.viewPessoaColaborador, 
		this.inventarioAjusteDetGroupedList, 

  });
}
