import 'package:drift/drift.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';
import 'package:inventario/app/data/provider/drift/database/database_imports.dart';

part 'inventario_contagem_cab_dao.g.dart';

@DriftAccessor(tables: [
	InventarioContagemCabs,
	InventarioContagemDets,
	Produtos,
])
class InventarioContagemCabDao extends DatabaseAccessor<AppDatabase> with _$InventarioContagemCabDaoMixin {
	final AppDatabase db;

	List<InventarioContagemCab> inventarioContagemCabList = []; 
	List<InventarioContagemCabGrouped> inventarioContagemCabGroupedList = []; 

	InventarioContagemCabDao(this.db) : super(db);

	Future<List<InventarioContagemCab>> getList() async {
		inventarioContagemCabList = await select(inventarioContagemCabs).get();
		return inventarioContagemCabList;
	}

	Future<List<InventarioContagemCab>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		inventarioContagemCabList = await (select(inventarioContagemCabs)..where((t) => expression)).get();
		return inventarioContagemCabList;	 
	}

	Future<List<InventarioContagemCabGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(inventarioContagemCabs)
			.join([]);

		if (field != null && field != '') { 
			final column = inventarioContagemCabs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		inventarioContagemCabGroupedList = await query.map((row) {
			final inventarioContagemCab = row.readTableOrNull(inventarioContagemCabs); 

			return InventarioContagemCabGrouped(
				inventarioContagemCab: inventarioContagemCab, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var inventarioContagemCabGrouped in inventarioContagemCabGroupedList) {
			inventarioContagemCabGrouped.inventarioContagemDetGroupedList = [];
			final queryInventarioContagemDet = ' id_inventario_contagem_cab = ${inventarioContagemCabGrouped.inventarioContagemCab!.id}';
			expression = CustomExpression<bool>(queryInventarioContagemDet);
			final inventarioContagemDetList = await (select(inventarioContagemDets)..where((t) => expression)).get();
			for (var inventarioContagemDet in inventarioContagemDetList) {
				InventarioContagemDetGrouped inventarioContagemDetGrouped = InventarioContagemDetGrouped(
					inventarioContagemDet: inventarioContagemDet,
					produto: await (select(produtos)..where((t) => t.id.equals(inventarioContagemDet.idProduto!))).getSingleOrNull(),
				);
				inventarioContagemCabGrouped.inventarioContagemDetGroupedList!.add(inventarioContagemDetGrouped);
			}

		}		

		return inventarioContagemCabGroupedList;	
	}

	Future<InventarioContagemCab?> getObject(dynamic pk) async {
		return await (select(inventarioContagemCabs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<InventarioContagemCab?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM inventario_contagem_cab WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as InventarioContagemCab;		 
	} 

	Future<InventarioContagemCabGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(InventarioContagemCabGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.inventarioContagemCab = object.inventarioContagemCab!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(inventarioContagemCabs).insert(object.inventarioContagemCab!);
			object.inventarioContagemCab = object.inventarioContagemCab!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(InventarioContagemCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(inventarioContagemCabs).replace(object.inventarioContagemCab!);
		});	 
	} 

	Future<int> deleteObject(InventarioContagemCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(inventarioContagemCabs).delete(object.inventarioContagemCab!);
		});		
	}

	Future<void> insertChildren(InventarioContagemCabGrouped object) async {
		for (var inventarioContagemDetGrouped in object.inventarioContagemDetGroupedList!) {
			inventarioContagemDetGrouped.inventarioContagemDet = inventarioContagemDetGrouped.inventarioContagemDet?.copyWith(
				id: const Value(null),
				idInventarioContagemCab: Value(object.inventarioContagemCab!.id),
			);
			await into(inventarioContagemDets).insert(inventarioContagemDetGrouped.inventarioContagemDet!);
		}
	}
	
	Future<void> deleteChildren(InventarioContagemCabGrouped object) async {
		await (delete(inventarioContagemDets)..where((t) => t.idInventarioContagemCab.equals(object.inventarioContagemCab!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from inventario_contagem_cab").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}