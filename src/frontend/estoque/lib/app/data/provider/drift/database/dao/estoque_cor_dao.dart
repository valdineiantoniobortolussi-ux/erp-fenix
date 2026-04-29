import 'package:drift/drift.dart';
import 'package:estoque/app/data/provider/drift/database/database.dart';
import 'package:estoque/app/data/provider/drift/database/database_imports.dart';

part 'estoque_cor_dao.g.dart';

@DriftAccessor(tables: [
	EstoqueCors,
])
class EstoqueCorDao extends DatabaseAccessor<AppDatabase> with _$EstoqueCorDaoMixin {
	final AppDatabase db;

	List<EstoqueCor> estoqueCorList = []; 
	List<EstoqueCorGrouped> estoqueCorGroupedList = []; 

	EstoqueCorDao(this.db) : super(db);

	Future<List<EstoqueCor>> getList() async {
		estoqueCorList = await select(estoqueCors).get();
		return estoqueCorList;
	}

	Future<List<EstoqueCor>> getListFilter(String field, String value) async {
		final query = " $field like '%$value%'";
		final expression = CustomExpression<bool>(query);
		estoqueCorList = await (select(estoqueCors)..where((t) => expression)).get();
		return estoqueCorList;	 
	}

	Future<List<EstoqueCorGrouped>> getGroupedList({String? field, dynamic value}) async {
		final query = select(estoqueCors)
			.join([]);

		if (field != null && field != '') { 
			final column = estoqueCors.$columns.where(((column) => column.$name == field)).first;
			if (column is TextColumn) {
				query.where((column as TextColumn).like('%$value%'));
			} else if (column is IntColumn) {
				query.where(column.equals(int.tryParse(value) as Object));
			} else if (column is RealColumn) {
				query.where(column.equals(double.tryParse(value) as Object));
			}
		}

		estoqueCorGroupedList = await query.map((row) {
			final estoqueCor = row.readTableOrNull(estoqueCors); 

			return EstoqueCorGrouped(
				estoqueCor: estoqueCor, 

			);
		}).get();

		// fill internal lists
		//dynamic expression;
		//for (var estoqueCorGrouped in estoqueCorGroupedList) {
		//}		

		return estoqueCorGroupedList;	
	}

	Future<EstoqueCor?> getObject(dynamic pk) async {
		return await (select(estoqueCors)..where((t) => t.id.equals(pk))).getSingleOrNull();
	} 

	Future<EstoqueCor?> getObjectFilter(String field, String value) async {
		final query = "SELECT * FROM estoque_cor WHERE $field like '%$value%'";
		return (await customSelect(query).getSingleOrNull()) as EstoqueCor;		 
	} 

	Future<EstoqueCorGrouped?> getObjectGrouped({String? field, dynamic value}) async {
		final result = await getGroupedList(field: field, value: value);

		if (result.length != 1) {
			return null;
		} else {
			return result[0];
		} 
	}

	Future<int> insertObject(EstoqueCorGrouped object) {
		return transaction(() async {
			final maxPk = await lastPk();
			object.estoqueCor = object.estoqueCor!.copyWith(id: Value(maxPk + 1));
			final pkInserted = await into(estoqueCors).insert(object.estoqueCor!);
			object.estoqueCor = object.estoqueCor!.copyWith(id: Value(pkInserted));			 
			await insertChildren(object);
			return pkInserted;
		});		
	}	 

	Future<bool> updateObject(EstoqueCorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			await insertChildren(object);
			return update(estoqueCors).replace(object.estoqueCor!);
		});	 
	} 

	Future<int> deleteObject(EstoqueCorGrouped object) {
		return transaction(() async {
			await deleteChildren(object);
			return delete(estoqueCors).delete(object.estoqueCor!);
		});		
	}

	Future<void> insertChildren(EstoqueCorGrouped object) async {
	}
	
	Future<void> deleteChildren(EstoqueCorGrouped object) async {
	}

	Future<int> lastPk() async {
		final result = await customSelect("select MAX(id) as LAST from estoque_cor").getSingleOrNull();
		return result?.data["LAST"] ?? 0;
	} 
}