import 'package:drift/drift.dart';
import 'package:inventario/app/data/provider/drift/database/database.dart';
import 'package:inventario/app/data/provider/drift/database/database_imports.dart';

part 'inventario_ajuste_cab_dao.g.dart';

@DriftAccessor(tables: [
	InventarioAjusteCabs,
	ViewPessoaColaboradors,
	InventarioAjusteDets,
	Produtos,
])
class InventarioAjusteCabDao extends DatabaseAccessor<AppDatabase> with _$InventarioAjusteCabDaoMixin {
	final AppDatabase db;

	List<InventarioAjusteCab> inventarioAjusteCabList = []; 
	List<InventarioAjusteCabGrouped> inventarioAjusteCabGroupedList = []; 

	InventarioAjusteCabDao(this.db) : super(db);

	Future<List<InventarioAjusteCab>> getList() async {
		inventarioAjusteCabList = await select(inventarioAjusteCabs).get();
		return inventarioAjusteCabList;
	}

	Future<List<InventarioAjusteCab>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		inventarioAjusteCabList = await (select(inventarioAjusteCabs)..where((t) => expression)).get();
		return inventarioAjusteCabList;	 
	}

	Future<List<InventarioAjusteCabGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(inventarioAjusteCabs)
			.join([ 
				leftOuterJoin(viewPessoaColaboradors, viewPessoaColaboradors.id.equalsExp(inventarioAjusteCabs.idViewPessoaColaborador)), 
			]);

		if (field != null && field != '') { 
			final column = inventarioAjusteCabs.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		inventarioAjusteCabGroupedList = await query.map((row) {
			final inventarioAjusteCab = row.readTableOrNull(inventarioAjusteCabs); 
			final viewPessoaColaborador = row.readTableOrNull(viewPessoaColaboradors); 

			return InventarioAjusteCabGrouped(
				inventarioAjusteCab: inventarioAjusteCab, 
				viewPessoaColaborador: viewPessoaColaborador, 

			);
		}).get();

		// fill internal lists
		dynamic expression;
		for (var inventarioAjusteCabGrouped in inventarioAjusteCabGroupedList) {
			inventarioAjusteCabGrouped.inventarioAjusteDetGroupedList = [];
			final queryInventarioAjusteDet = ' id_inventario_ajuste_cab = ${inventarioAjusteCabGrouped.inventarioAjusteCab!.id}';
			expression = CustomExpression<bool>(queryInventarioAjusteDet);
			final inventarioAjusteDetList = await (select(inventarioAjusteDets)..where((t) => expression)).get();
			for (var inventarioAjusteDet in inventarioAjusteDetList) {
				InventarioAjusteDetGrouped inventarioAjusteDetGrouped = InventarioAjusteDetGrouped(
					inventarioAjusteDet: inventarioAjusteDet,
					produto: await (select(produtos)..where((t) => t.id.equals(inventarioAjusteDet.idProduto!))).getSingleOrNull(),
				);
				inventarioAjusteCabGrouped.inventarioAjusteDetGroupedList!.add(inventarioAjusteDetGrouped);
			}

		}		

		return inventarioAjusteCabGroupedList;	
	}

	Future<InventarioAjusteCab?> getObject(dynamic pk) async {
		return await (select(inventarioAjusteCabs)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<InventarioAjusteCab?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM inventario_ajuste_cab WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as InventarioAjusteCab;		 
	} 

	Future<InventarioAjusteCabGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(InventarioAjusteCabGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.inventarioAjusteCab = object.inventarioAjusteCab!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(inventarioAjusteCabs).insert(object.inventarioAjusteCab!);
			object.inventarioAjusteCab = object.inventarioAjusteCab!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(InventarioAjusteCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(inventarioAjusteCabs).replace(object.inventarioAjusteCab!);
		});	 
	} 

	Future<int> deleteObject(InventarioAjusteCabGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(inventarioAjusteCabs).delete(object.inventarioAjusteCab!);
		});		
	}

	Future<void> insertChildren(InventarioAjusteCabGrouped object) async {
		for (var inventarioAjusteDetGrouped in object.inventarioAjusteDetGroupedList!) {
			inventarioAjusteDetGrouped.inventarioAjusteDet = inventarioAjusteDetGrouped.inventarioAjusteDet?.copyWith(
				id: const Value(null),
				idInventarioAjusteCab: Value(object.inventarioAjusteCab!.id),
			);
			await into(inventarioAjusteDets).insert(inventarioAjusteDetGrouped.inventarioAjusteDet!);
		}
	}
	
	Future<void> deleteChildren(InventarioAjusteCabGrouped object) async {
		await (delete(inventarioAjusteDets)..where((t) => t.idInventarioAjusteCab.equals(object.inventarioAjusteCab!.id!))).go();
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from inventario_ajuste_cab").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}